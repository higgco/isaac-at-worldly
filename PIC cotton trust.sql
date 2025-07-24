WITH cte AS (
    SELECT
    msi.msi_id,
    msi.account_id,
    bm ->> '_id' AS base_material_id,
    ARRAY_AGG(sel ->> 'id') AS all_selected_ids
    FROM public.msi msi
    JOIN public.account a ON a.account_id = msi.account_id
    CROSS JOIN LATERAL jsonb_array_elements(msi.raw -> 'version' -> 'baseMaterials') AS bm

    LEFT JOIN LATERAL (
    SELECT jsonb_array_elements(
        COALESCE(bm -> 'cycles' -> 'P001' -> 'selected', '[]'::jsonb)
    ) AS sel
    UNION ALL
    SELECT jsonb_array_elements(
        COALESCE(bm -> 'cycles' -> 'P002' -> 'selected', '[]'::jsonb)
    )
    UNION ALL
    SELECT jsonb_array_elements(
        COALESCE(bm -> 'cycles' -> 'P003' -> 'selected', '[]'::jsonb)
    )
    UNION ALL
    SELECT jsonb_array_elements(
        COALESCE(bm -> 'cycles' -> 'P004' -> 'selected', '[]'::jsonb)
    )
    UNION ALL
    SELECT jsonb_array_elements(
        COALESCE(bm -> 'cycles' -> 'P005' -> 'selected', '[]'::jsonb)
    )
    ) AS all_selected ON true

    WHERE a.demo = FALSE AND a.active = TRUE
    GROUP BY msi.msi_id, msi.account_id, base_material_id
)

-- Count of MSI IDs and Account IDs
SELECT
    COUNT(DISTINCT msi_id) AS count_id,
    COUNT(DISTINCT account_id) AS count_account_id
FROM cte
WHERE all_selected_ids ILIKE '%PR0804000852%';

---
-- Accounts with MSI IDs that include the specified process
-- SELECT
--     msi_id AS msi_id,
--     cte.account_id AS account_id,
--     a.name AS account_name,
--     all_processes AS all_processes
-- FROM cte
-- LEFT JOIN public.account a ON a.account_id = cte.account_id
-- WHERE all_processes ILIKE '%PR0804000852%';

---
-- Count MSI IDs per account first, then count how many accounts fall into each count
-- SELECT 
--     msi_per_account.count_msi_ids,
--     COUNT(*) AS num_accounts
-- FROM (
--     SELECT 
--         account_id,
--         COUNT(DISTINCT msi_id) AS count_msi_ids
--     FROM cte
--     WHERE all_processes ILIKE '%PR0804000852%'
--     GROUP BY account_id
-- ) AS msi_per_account
-- GROUP BY msi_per_account.count_msi_ids
-- ORDER BY msi_per_account.count_msi_ids;