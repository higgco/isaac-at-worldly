# Excel Deltas App

A local, private Excel comparison tool built with Streamlit. Compare two Excel workbooks (.xlsx) and identify differences between them without uploading any data to the cloud.

## Features

- 🔍 **Compare two Excel workbooks** (.xlsx format)
- 📊 **Choose sheets to compare** (auto-matches by name)
- 🔑 **Optional row-wise comparison** using one or more key columns
- 🎨 **Highlights added/removed/changed rows** with color coding
- 📥 **Downloadable Excel report** with per-sheet tabs and summary
- 🔒 **Fully offline** - files never leave your computer

## Prerequisites

- Python 3.8 or higher
- macOS, Linux, or Windows

## Quick Start

### 1. Clone or Download

```bash
git clone <repository-url>
cd excel-delta-app
```

### 2. Set Up Virtual Environment

The project includes a pre-configured virtual environment with all dependencies installed.

**Activate the virtual environment:**

```bash
# On macOS/Linux
source xlsx-delta-venv/bin/activate

# On Windows
xlsx-delta-venv\Scripts\activate
```

### 3. Run the Application

```bash
streamlit run excel_deltas_app.py
```

### 4. Open in Browser

Streamlit will automatically open your browser, or you can manually navigate to:
```
http://localhost:8501
```

## Manual Setup (Alternative)

If you prefer to create your own virtual environment:

### 1. Create Virtual Environment

```bash
python3 -m venv my-venv
```

### 2. Activate Virtual Environment

```bash
# On macOS/Linux
source my-venv/bin/activate

# On Windows
my-venv\Scripts\activate
```

### 3. Install Dependencies

```bash
pip install streamlit pandas openpyxl xlsxwriter
```

### 4. Run the Application

```bash
streamlit run excel_deltas_app.py
```

## How to Use

1. **Upload Files**: Use the file uploaders to select two Excel files (.xlsx)
2. **Select Sheets**: Choose which sheet pairs to compare (auto-matched by name)
3. **Configure Comparison**:
   - **Row-wise comparison**: Enable to use key columns for better diffs
   - **Key columns**: Specify comma-separated column names that uniquely identify rows
4. **Run Comparison**: Click "Run comparison" to analyze differences
5. **Download Report**: Get a detailed Excel report with all differences highlighted

## Comparison Types

### Row-wise Comparison (Recommended)
- Uses specified key columns to match rows between files
- Identifies added, removed, and changed rows
- Best for data with unique identifiers (ID columns, etc.)

### Positional Comparison
- Compares cells by their position in the spreadsheet
- Useful when files have the same structure
- Shows all cell-level differences

## Output Report

The generated Excel report includes:

- **Summary Sheet**: Overview of changes across all compared sheets
- **Per-sheet Tabs**: Detailed breakdown for each sheet pair
  - `SheetName__ADDED`: New rows (highlighted in green)
  - `SheetName__REMOVED`: Deleted rows (highlighted in red)
  - `SheetName__CHANGED`: Modified rows (highlighted in yellow)

## Dependencies

The application uses the following Python packages:

- **streamlit**: Web application framework
- **pandas**: Data manipulation and analysis
- **openpyxl**: Excel file reading/writing
- **xlsxwriter**: Advanced Excel file creation with formatting

## Troubleshooting

### Virtual Environment Issues

**Problem**: `source: command not found`
**Solution**: Use the full path or ensure you're using bash/zsh:
```bash
source ./xlsx-delta-venv/bin/activate
```

**Problem**: Permission denied on Windows
**Solution**: Run PowerShell as Administrator or use:
```bash
xlsx-delta-venv\Scripts\Activate.ps1
```

### Application Issues

**Problem**: Streamlit won't start
**Solution**: Ensure the virtual environment is activated and dependencies are installed:
```bash
source xlsx-delta-venv/bin/activate
pip list  # Verify packages are installed
```

**Problem**: Excel files won't upload
**Solution**: Ensure files are in .xlsx format (not .xls or .csv)

## File Structure

```
excel-delta-app/
├── excel_deltas_app.py        # Main application file
├── xlsx-delta-venv/           # Virtual environment (pre-configured)
├── requirements.txt           # Python dependencies
└── README.md                  # This file
```

## Privacy & Security

- ✅ **Fully offline**: All processing happens on your local machine
- ✅ **No data uploads**: Files never leave your computer
- ✅ **No internet required**: Works completely offline after setup
- ✅ **Private**: No data is sent to external servers

## License

This project is open source. Feel free to modify and distribute according to your needs.

## Support

For issues or questions:
1. Check the troubleshooting section above
2. Verify your Python version (3.8+)
3. Ensure all dependencies are properly installed
4. Check that your Excel files are in .xlsx format
