# Tior Games Data Warehouse Project

## 📋 Project Overview
This is a comprehensive Business Analytics project for **Tior Games**, focused on building and analyzing a data warehouse for gaming event management. The project involves data cleaning, warehouse design, and business intelligence analytics to support decision-making for game operations, merchandise sales, and customer experience optimization.

## 🎯 Business Objectives
The data warehouse supports analysis in several key areas:
- **Game Performance Analytics**: Understanding game duration, interruptions, and results
- **Merchandise Sales Optimization**: Tracking sales, refunds, and promotional effectiveness
- **Stadium Operations**: Analyzing venue performance and customer experience
- **Financial Performance**: Revenue tracking and cost optimization

## 📁 Project Structure
```
Tior Games/
├── 📊 Data Files
│   ├── GameFact_MockData.xlsx - Sheet1.csv    # Primary game fact data (CSV)
│   ├── GameFactMockData2.json                 # Additional game fact data (JSON)
│   └── TiorGames data dictionary.xlsx         # Data dictionary and schema definitions
│
├── 🔧 Data Processing
│   └── data cleaning.ipynb                    # Main data cleaning and preparation notebook
│
├── 🗄️ Database & Queries
│   ├── t-sql_queries-DESKTOP-GD6JNO2.sql     # T-SQL analysis queries
│   └── Tior Data Warehouse Schema.pdf         # Complete database schema documentation
│
├── 📈 Visualizations & Analysis
│   ├── avg game dur.png                       # Average game duration analysis
│   ├── game interruptions.png                 # Game interruption patterns
│   ├── net sales.png                          # Net sales performance
│   ├── promo.png                              # Promotional campaign analysis
│   ├── ticket refund.png                      # Ticket refund analysis
│   └── total merch.png                        # Total merchandise sales
│
├── 📑 Documentation
│   ├── Tior Games Data Warehouse.pptx         # Project presentation
│   └── README.md                              # This documentation
│
└── 🔍 Version Control
    └── .git/                                  # Git repository
```

## 🎮 Data Schema Overview

### Game Fact Table
The core fact table contains the following dimensions:
- **Event Identifiers**: `EventID`, `GameID`
- **Location & Personnel**: `StadiumID`, `RefereeID`
- **Time Dimensions**: `TimeID`, `DateID`
- **Game Metrics**: 
  - `GameDuration` (minutes)
  - `GameInterruption` (count)
  - `GameNumberOfPause`, `GameMinuteOfPause`, `GameDurationOfPause`
- **Game Details**: `GameTeam`, `GameResult`
- **Additional Features**: `PauseID`, `HighlightID`

### Data Quality Challenges
The dataset contains various data quality issues that are addressed in the cleaning process:
- Missing values (empty cells, "None", null)
- Invalid data types ("Invalid" strings in numeric fields)
- Negative values in duration/count fields
- Inconsistent formatting between CSV and JSON sources

## 🧹 Data Cleaning Process

### 1. Data Integration
```python
# Combine CSV and JSON data sources
csv_data = pd.read_csv('GameFact_MockData.xlsx - Sheet1.csv')
json_data = pd.json_normalize(json_data, record_path=["gamefact_data"])
raw_data = pd.concat([csv_data, json_data], axis=0, ignore_index=True)
```

### 2. Missing Value Treatment
Remove rows with missing values in critical business keys:
- Event, Stadium, Referee, Game, Time, and Date IDs
- Core game metrics (Duration, Team, Interruption, Result)

### 3. Data Type Validation & Business Rules
```python
expected_types = {
    'EventID': int, 'StadiumID': int, 'RefereeID': int,
    'GameID': int, 'TimeID': int, 'DateID': int,
    'GameDuration': int, 'GameTeam': str,
    'GameInterruption': int, 'GameResult': str
}
```
- Validate data types for each field
- Reject negative values for duration and count fields
- Ensure string fields contain valid text data

## 📊 Business Intelligence Queries

The project includes comprehensive T-SQL queries for business analysis:

### 🏪 Merchandise Analytics
- **Total merchandise sold by type and location** (using CUBE for multi-dimensional analysis)
- **Net sales analysis with refunds** by merchandise type
- **Promotional spending optimization** with ROI calculations

### 🏟️ Stadium & Game Analytics  
- **Average game duration by stadium** with performance ranking
- **Game interruption analysis** by venue
- **Ticket refund breakdown** by event and ticket type

### 📈 Key Performance Indicators
- Stadium performance ranking by game duration
- Promotional campaign effectiveness (Revenue vs Cost)
- Customer satisfaction metrics (refund rates)

## 🔧 Technical Requirements

### Python Environment
```bash
pip install pandas numpy json
```

### Development Tools
- **Jupyter Notebook** or **VS Code** for data processing
- **SQL Server** or compatible database for T-SQL queries
- **Excel/PowerBI** for additional visualizations

## 🚀 Getting Started

### 1. Environment Setup
```bash
# Clone the repository
git clone https://github.com/HandharJunino/Tior-Games.git
cd Tior-Games

# Install dependencies
pip install pandas numpy
```

### 2. Data Processing
1. Open `data cleaning.ipynb` in Jupyter Notebook or VS Code
2. Ensure data files are in the same directory:
   - `GameFact_MockData.xlsx - Sheet1.csv`
   - `GameFactMockData2.json`
3. Run all cells sequentially to perform data cleaning

### 3. Database Analysis
1. Import cleaned data into your SQL Server database
2. Use `t-sql_queries-DESKTOP-GD6JNO2.sql` for business intelligence queries
3. Refer to `Tior Data Warehouse Schema.pdf` for complete schema design

## 📈 Output & Results

### Cleaned Datasets
- **`raw_data`**: Combined dataset from CSV and JSON (before cleaning)
- **`cleaned_data_1`**: After removing rows with missing critical values
- **`cleaned_data_2`**: Final dataset after data type validation and business rule application

### Business Insights
The analysis generates insights across multiple business areas:
- **Operational Efficiency**: Stadium performance and game management optimization
- **Revenue Optimization**: Merchandise sales patterns and promotional effectiveness
- **Customer Experience**: Refund analysis and service quality metrics

## 🎓 Academic Context
- **Course**: Business Analytics Year 3
- **Institution**: University of Portsmouth
- **Focus**: Data Warehouse Design & Business Intelligence
- **Skills Demonstrated**: 
  - Data cleaning and preprocessing
  - Multi-source data integration
  - Business intelligence query design
  - Data visualization and reporting

## 🚨 Troubleshooting

### Common Data Issues
**JSON Decode Error**: 
```
JSONDecodeError: Expecting value: line X column Y
```
- Verify JSON file structure and syntax
- Check for trailing commas or invalid characters
- Ensure proper encoding (UTF-8)

**Missing Data Handling**:
- Review data quality rules in the cleaning notebook
- Adjust missing value thresholds based on business requirements
- Validate data type conversions for edge cases

**SQL Query Execution**:
- Ensure proper database schema setup
- Verify table and column names match the schema
- Check for data type compatibility in JOIN operations

## 📞 Support & Contact
For questions regarding this project:
- **Academic Supervisor**: TBA
- **Repository**: [GitHub Repository](https://github.com/HandharJunino/Tior-Games)
- **University Portal**: Business Analytics Course Forum

---
**Last Updated**: January 2025  
**Version**: 1.0  
**License**: Educational Use - University of Portsmouth