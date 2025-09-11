# excel_diff_app.py
"""
Local Excel Diff App (Streamlit)
--------------------------------
Runs entirely on your machine. No cloud uploads.

Features
- Compare two Excel workbooks (.xlsx)
- Choose sheets to compare (auto-matches by name)
- Optional row-wise comparison using one or more key columns
- Highlights added/removed/changed rows
- Produces a downloadable Excel report with per-sheet tabs and a summary

Usage
1) Install deps (ideally in a virtualenv):
   pip install streamlit pandas openpyxl xlsxwriter
2) Run:
   streamlit run excel_diff_app.py
3) Open the local URL Streamlit prints (e.g., http://localhost:8501)

Notes
- Works fully offline. Files never leave your computer.
- If you provide key columns, diffs are row-aware; otherwise a positional cell-by-cell compare is done.
"""

import io
from typing import Dict, List, Tuple, Optional

import pandas as pd
import streamlit as st

st.set_page_config(page_title="Excel Diff (Local)", layout="wide")

st.title("🔍 Excel Diff (Local, Private)")
st.write("Compare two .xlsx files on your computer. Nothing is uploaded.")

# --------------------- Helpers ---------------------

def load_workbook(file) -> Dict[str, pd.DataFrame]:
    """Read an Excel file-like into dict of DataFrames keyed by sheet name."""
    xls = pd.ExcelFile(file)
    sheets = {}
    for name in xls.sheet_names:
        df = xls.parse(name)
        # Normalize column names (strings) for robustness
        df.columns = [str(c) for c in df.columns]
        sheets[name] = df
    return sheets


def infer_sheet_mapping(sheets_a: List[str], sheets_b: List[str]) -> List[Tuple[str, str]]:
    """Auto-match sheets by identical name; return list of (left,right)."""
    common = sorted(set(sheets_a).intersection(sheets_b))
    return [(s, s) for s in common]


def normalize_keys(df: pd.DataFrame, keys: List[str]) -> pd.DataFrame:
    """Ensure key columns exist and cast to string for stable matching."""
    missing = [k for k in keys if k not in df.columns]
    if missing:
        raise KeyError(f"Missing key columns: {missing}")
    out = df.copy()
    for k in keys:
        out[k] = out[k].astype(str)
    return out


def rowwise_diff(left: pd.DataFrame, right: pd.DataFrame, keys: List[str]) -> Tuple[pd.DataFrame, pd.DataFrame, pd.DataFrame]:
    """Return (added_rows_in_right, removed_rows_from_left, changed_rows) using keys."""
    L = normalize_keys(left, keys)
    R = normalize_keys(right, keys)

    L_keyed = L.set_index(keys)
    R_keyed = R.set_index(keys)

    # Align columns union for fair compare
    all_cols = sorted(set(L_keyed.columns).union(R_keyed.columns))
    L_keyed = L_keyed.reindex(columns=all_cols)
    R_keyed = R_keyed.reindex(columns=all_cols)

    added_keys = R_keyed.index.difference(L_keyed.index)
    removed_keys = L_keyed.index.difference(R_keyed.index)
    common_keys = L_keyed.index.intersection(R_keyed.index)

    added = R_keyed.loc[added_keys].reset_index()
    removed = L_keyed.loc[removed_keys].reset_index()

    # Find changed rows: any column differs
    L_common = L_keyed.loc[common_keys]
    R_common = R_keyed.loc[common_keys]
    diff_mask = (L_common != R_common) & ~(L_common.isna() & R_common.isna())
    changed_keys = diff_mask.any(axis=1)

    changed_records = []
    for idx in L_common.index[changed_keys]:
        row_l = L_common.loc[idx]
        row_r = R_common.loc[idx]
        changes = {}
        for col in all_cols:
            lv = row_l.get(col)
            rv = row_r.get(col)
            if pd.isna(lv) and pd.isna(rv):
                continue
            if (lv != rv) and not (pd.isna(lv) and pd.isna(rv)):
                changes[f"{col}__OLD"] = lv
                changes[f"{col}__NEW"] = rv
        rec = {}
        if isinstance(idx, tuple):
            for k, v in zip(keys, idx):
                rec[k] = v
        else:
            rec[keys[0]] = idx
        rec.update(changes)
        changed_records.append(rec)

    changed = pd.DataFrame(changed_records)
    if not changed.empty:
        # Order key columns first, then grouped old/new pairs
        other_cols = [c for c in changed.columns if c not in keys]
        # group old/new
        def sort_key(c):
            # sort base col name, then OLD before NEW
            if c in keys:
                return (0, c, 0)
            base = c.replace("__OLD", "").replace("__NEW", "")
            is_new = c.endswith("__NEW")
            return (1, base, 1 if is_new else 0)
        changed = changed[sorted(changed.columns, key=sort_key)]

    return added, removed, changed


def positional_cell_diff(left: pd.DataFrame, right: pd.DataFrame]) -> pd.DataFrame:
    """Cell-by-cell diff by position (no keys). Returns a long-form table of differences."""
    # Align shapes: expand to the max rows/cols, fill with NaN
    max_rows = max(len(left), len(right))
    max_cols = max(left.shape[1], right.shape[1])

    L = left.reindex(range(max_rows))
    R = right.reindex(range(max_rows))

    # Align columns by name where possible; otherwise by position with synthetic names
    lcols = list(left.columns)
    rcols = list(right.columns)
    all_cols = []
    for i in range(max_cols):
        lc = lcols[i] if i < len(lcols) else f"__col_{i}__L"
        rc = rcols[i] if i < len(rcols) else f"__col_{i}__R"
        cname = lc if lc == rc else f"{lc} | {rc}"
        all_cols.append((lc, rc, cname))

    diffs = []
    for r in range(max_rows):
        for i, (lc, rc, cname) in enumerate(all_cols):
            lv = L[lc] if lc in L.columns else pd.Series([pd.NA]*max_rows)
            rv = R[rc] if rc in R.columns else pd.Series([pd.NA]*max_rows)
            vL = lv.iloc[r] if r < len(lv) else pd.NA
            vR = rv.iloc[r] if r < len(rv) else pd.NA
            if (pd.isna(vL) and pd.isna(vR)) or (vL == vR):
                continue
            diffs.append({"Row": r+1, "Column": cname, "OLD": vL, "NEW": vR})
    return pd.DataFrame(diffs)


def build_report(summaries: List[dict], per_sheet: Dict[str, Dict[str, pd.DataFrame]]) -> bytes:
    """Create an Excel report as bytes with a Summary + per-sheet tabs."""
    output = io.BytesIO()
    with pd.ExcelWriter(output, engine="xlsxwriter") as writer:
        # Summary sheet
        summary_df = pd.DataFrame(summaries)
        if summary_df.empty:
            summary_df = pd.DataFrame([{"Sheet": "(none)", "Added": 0, "Removed": 0, "Changed": 0}])
        summary_df.to_excel(writer, index=False, sheet_name="Summary")

        workbook  = writer.book
        header_fmt = workbook.add_format({"bold": True})
        added_fmt  = workbook.add_format({"bg_color": "#C6EFCE"})  # light green
        removed_fmt= workbook.add_format({"bg_color": "#FFC7CE"})  # light red
        changed_fmt= workbook.add_format({"bg_color": "#FFEB9C"})  # light yellow

        # Apply header bold in Summary
        ws_sum = writer.sheets["Summary"]
        for col, _ in enumerate(summary_df.columns):
            ws_sum.write(0, col, summary_df.columns[col], header_fmt)

        # Per-sheet tabs
        for sheet, parts in per_sheet.items():
            if "added" in parts and not parts["added"].empty:
                parts["added"].to_excel(writer, index=False, sheet_name=f"{sheet}__ADDED")
                ws = writer.sheets[f"{sheet}__ADDED"]
                for col, _ in enumerate(parts["added"].columns):
                    ws.write(0, col, parts["added"].columns[col], header_fmt)
                ws.conditional_format(1, 0, len(parts["added"]) , len(parts["added"].columns)-1,
                                      {"type": "no_blanks", "format": added_fmt})

            if "removed" in parts and not parts["removed"].empty:
                parts["removed"].to_excel(writer, index=False, sheet_name=f"{sheet}__REMOVED")
                ws = writer.sheets[f"{sheet}__REMOVED"]
                for col, _ in enumerate(parts["removed"].columns):
                    ws.write(0, col, parts["removed"].columns[col], header_fmt)
                ws.conditional_format(1, 0, len(parts["removed"]) , len(parts["removed"].columns)-1,
                                      {"type": "no_blanks", "format": removed_fmt})

            if "changed" in parts and not parts["changed"].empty:
                parts["changed"].to_excel(writer, index=False, sheet_name=f"{sheet}__CHANGED")
                ws = writer.sheets[f"{sheet}__CHANGED"]
                for col, _ in enumerate(parts["changed"].columns):
                    ws.write(0, col, parts["changed"].columns[col], header_fmt)
                ws.conditional_format(1, 0, len(parts["changed"]) , len(parts["changed"].columns)-1,
                                      {"type": "no_blanks", "format": changed_fmt})

    return output.getvalue()

# --------------------- UI ---------------------

left_file = st.file_uploader("Left / Original workbook (.xlsx)", type=["xlsx"], key="left")
right_file = st.file_uploader("Right / New workbook (.xlsx)", type=["xlsx"], key="right")

if left_file and right_file:
    sheets_left = load_workbook(left_file)
    sheets_right = load_workbook(right_file)

    st.subheader("Sheet selection")
    default_pairs = infer_sheet_mapping(list(sheets_left.keys()), list(sheets_right.keys()))
    if not default_pairs:
        st.warning("No identically named sheets found. You can still compare by selecting pairs manually.")

    # Build a mapping UI
    all_left = list(sheets_left.keys())
    all_right = list(sheets_right.keys())

    pair_count = st.number_input("How many sheet pairs to compare?", min_value=1, max_value=50, value=max(1, len(default_pairs)))
    pairs = []
    for i in range(int(pair_count)):
        default_L = default_pairs[i][0] if i < len(default_pairs) else (all_left[0] if all_left else "")
        default_R = default_pairs[i][1] if i < len(default_pairs) else (all_right[0] if all_right else "")
        cols = st.columns(2)
        with cols[0]:
            L = st.selectbox(f"Left sheet #{i+1}", options=all_left, index=all_left.index(default_L) if default_L in all_left else 0, key=f"L{i}")
        with cols[1]:
            R = st.selectbox(f"Right sheet #{i+1}", options=all_right, index=all_right.index(default_R) if default_R in all_right else 0, key=f"R{i}")
        pairs.append((L, R))

    st.subheader("Row-wise comparison (optional)")
    st.write("If your sheets have one or more columns that uniquely identify a row (e.g., ID), specify them here for better diffs.")
    use_keys = st.checkbox("Use key columns for row-wise comparison?", value=True)

    key_input = ""
    if use_keys:
        key_input = st.text_input("Key columns (comma-separated, must exist in both sheets of each pair)", value="id")

    if st.button("Run comparison", type="primary"):
        summaries = []
        per_sheet = {}
        for (S_L, S_R) in pairs:
            dfL = sheets_left[S_L]
            dfR = sheets_right[S_R]
            sheet_label = f"{S_L}⇄{S_R}" if S_L != S_R else S_L

            try:
                if use_keys and key_input.strip():
                    keys = [k.strip() for k in key_input.split(",") if k.strip()]
                    added, removed, changed = rowwise_diff(dfL, dfR, keys)
                    per_sheet[sheet_label] = {
                        "added": added,
                        "removed": removed,
                        "changed": changed,
                    }
                    summaries.append({
                        "Sheet": sheet_label,
                        "Added": len(added),
                        "Removed": len(removed),
                        "Changed": len(changed),
                    })
                else:
                    # Positional diff
                    diffs = positional_cell_diff(dfL, dfR)
                    per_sheet[sheet_label] = {"changed": diffs}
                    summaries.append({
                        "Sheet": sheet_label,
                        "Added": 0,
                        "Removed": 0,
                        "Changed": len(diffs),
                    })
            except Exception as e:
                st.error(f"Error comparing sheet '{sheet_label}': {e}")

        st.subheader("Results summary")
        st.dataframe(pd.DataFrame(summaries))

        # Build downloadable Excel report
        report_bytes = build_report(summaries, per_sheet)
        st.download_button(
            label="⬇️ Download Excel Diff Report",
            data=report_bytes,
            file_name="excel_diff_report.xlsx",
            mime="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
        )

else:
    st.info("Upload two .xlsx files to begin.")