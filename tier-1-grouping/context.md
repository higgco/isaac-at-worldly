# Tier 1 Grouping Analysis Project - Context Document

## Project Overview

This project analyzes apparel facility data from the Higg Facility Environmental Module (FEM) to understand product weight distributions and their relationship to energy consumption and GHG emissions. The analysis focuses on Tier 1 facilities (assemblers) that produce apparel products.

## Project Structure

### Files and Directories
- **`tier 1 analysis.ipynb`** - Main Jupyter notebook containing the complete analysis
- **`queries/facility type and pc.sql`** - SQL query that extracts facility and product data
- **`PIC default product weights.csv`** - Reference data with default weights for apparel product categories
- **`requirements.txt`** - Python dependencies including pandas, matplotlib, seaborn, etc.
- **`tier-1-venv/`** - Python virtual environment
- **`context.md`** - This context document

## Data Sources and Structure

### Database Connection
- **Database**: PostgreSQL (Higg FEM database)
- **Connection**: Uses environment variables from `.env` file
- **Host**: wg-data-rds.data.higg.org
- **Table**: `fem_simple_090825` (view of FEM data)

### Key Data Fields
- **`assessment_id`** - Unique identifier for each facility assessment
- **`rfi_pid`** - RFI period identifier (e.g., 'fem2024', 'fem2023') - used to determine year
- **`sipfacilityapparelpc`** - List of apparel product categories produced by facility
- **`finished_product_assembly_prod_vol_pcs`** - Production volume in pieces
- **`total_energy_mj`** - Total energy consumption in MJ
- **`totalghgemissions`** - Total GHG emissions
- **`energy_outlier`** - Boolean flag indicating if facility is an energy outlier
- **`sitecountry`** - Country where facility is located

### Product Weight Reference Data
The `PIC default product weights.csv` contains default weights for apparel categories:
- **FEM Apparel PC** - Product category names (Shirts, Dresses, Jackets, etc.)
- **PIC Product** - Corresponding PIC product classification
- **Product Weight (kg)** - Default weight in kilograms

## Analysis Components

### 1. Data Loading and Setup (Cells 1-4)
- Environment variable loading
- Database connection setup
- SQL query execution
- Basic data validation and display

### 2. Product Weight Analysis (Cell 5)
- Loads default product weights from CSV
- Creates mapping dictionary for weight lookup
- Handles tab-separated format correctly

### 3. Weight Calculation and Analysis (Cell 6)
- **Core Function**: `calculate_average_weight()` - calculates average weight for each facility based on their product mix
- **Weight Range Categorization**: Assigns facilities to weight categories (Very Light, Light, Medium-Light, Medium, Medium-Heavy, Heavy)
- **Production Volume Conversion**: Converts production from pieces to kg using calculated average weights
- **Energy/Emissions Analysis**: Calculates intensity metrics (MJ/kg and kgCO2e/kg)
- **Comprehensive Statistics**: Provides detailed statistics for all metrics
- **CSV Export**: Exports complete results to timestamped CSV file

### 4. Outlier Analysis (Cell 7)
- **Separate Analysis**: Statistics excluding energy outliers
- **Enhanced Metrics**: Includes standard deviation calculations
- **Clean Data Focus**: Provides representative statistics without extreme values

### 5. Data Visualization (Cell 9)
- **Grouped Bar Chart**: Shows assessment counts by weight range category and year
- **Outlier Exclusion**: Uses clean data (excluding energy outliers)
- **Year Extraction**: Derives years from `rfi_pid` field
- **Professional Styling**: Publication-ready visualization with proper labels and colors

## Key Calculations and Metrics

### Weight Calculations
1. **Average Product Weight**: For each facility, calculates the average weight based on their product mix using default weights
2. **Production Volume (kg)**: `pieces × average_weight = kg`
3. **Weight Range Categories**: 
   - Very Light (0-0.2 kg)
   - Light (0.2-0.3 kg)
   - Medium-Light (0.3-0.4 kg)
   - Medium (0.4-0.5 kg)
   - Medium-Heavy (0.5-0.6 kg)
   - Heavy (0.6+ kg)

### Intensity Metrics
1. **Energy Intensity**: `total_energy_mj / estimated_production_volume_kg` (MJ/kg)
2. **Emissions Intensity**: `totalghgemissions / estimated_production_volume_kg` (kgCO2e/kg)

### Data Filtering
- **Outlier Exclusion**: Removes facilities where `energy_outlier = True`
- **Year Extraction**: Uses regex to extract 4-digit years from `rfi_pid` field
- **Case-Insensitive Column Matching**: Handles database column name variations

## Technical Implementation Details

### Error Handling
- **Type Conversion**: Handles decimal.Decimal to float conversions for calculations
- **Missing Columns**: Gracefully handles missing energy/emissions columns
- **Data Validation**: Checks for required data before processing

### Data Processing
- **List Parsing**: Safely converts string representations of lists to actual lists
- **Cross-Tabulation**: Creates year × weight_category matrices for analysis
- **Statistical Calculations**: Comprehensive statistics including mean, median, std dev

### Visualization
- **Matplotlib/Seaborn**: Professional charting with proper styling
- **Grouped Bar Charts**: Side-by-side comparison of years within weight categories
- **Color Coding**: Distinct colors for each year
- **Responsive Layout**: Proper spacing and legend placement

## Output Files

### CSV Export
- **Filename Format**: `tier1_analysis_results_YYYYMMDD_HHMMSS.csv`
- **Location**: User's Documents folder
- **Content**: All calculated metrics including:
  - Original data fields
  - Calculated average weights
  - Weight range categories
  - Production volumes in kg
  - Energy and emissions intensities
  - Outlier flags

## Current Status

The project is complete with:
- ✅ Full data pipeline from database to analysis
- ✅ Comprehensive weight and intensity calculations
- ✅ Outlier analysis and filtering
- ✅ Professional data visualization
- ✅ Automated CSV export
- ✅ Error handling and data validation

## Usage Instructions

1. **Setup**: Ensure virtual environment is activated and dependencies installed
2. **Configuration**: Set up `.env` file with database credentials
3. **Execution**: Run cells sequentially in the Jupyter notebook
4. **Results**: Check Documents folder for exported CSV files

## Key Insights and Applications

This analysis enables:
- **Sustainability Benchmarking**: Compare energy and emissions intensity across facilities
- **Product Mix Analysis**: Understand how product types affect environmental impact
- **Trend Analysis**: Track changes in facility characteristics over time
- **Outlier Identification**: Identify facilities with unusual energy consumption patterns
- **Weight-Based Normalization**: Fair comparison of facilities regardless of production volume

## Technical Dependencies

- **Python 3.13**
- **pandas** - Data manipulation and analysis
- **matplotlib/seaborn** - Data visualization
- **psycopg2** - PostgreSQL database connection
- **SQLAlchemy** - Database ORM
- **python-dotenv** - Environment variable management

This project provides a comprehensive framework for analyzing apparel facility environmental data with a focus on product weight normalization and sustainability metrics.
