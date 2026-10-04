**Finance & Sales Performance Analysis**
- **Project Overview**

An end-to-end Finance & Sales Performance Analysis project built for portfolio practice using a realistic simulated business dataset.

The project covers data cleaning, exploratory analysis, SQL-based business analysis, financial KPI calculation, budget vs. actual analysis, and an interactive Power BI management dashboard.

- Note: This is a realistic simulated dataset created for portfolio practice. It should not be presented as real company data

**Business Objectives**
- Analyze sales and revenue performance
- Measure gross profit and profit margin
- Compare actual revenue with budget
- Analyze performance by region, channel, category, and product
- Identify key business trends and performance gaps
- Build a management-friendly Power BI dashboard
  
**Dataset**

**The project uses the following tables:**

**Table	Description**
- sales_transactions_raw.csv	Transaction-level raw sales data containing data-quality issues
- customers.csv	Customer dimension
- products.csv	Product dimension, including Unit Cost
- regions.csv	Region dimension
- expenses.csv	Monthly regional expense fact
- budget.csv	Monthly product budget fact
  
**Calculated Sales Metrics**

The calculated sales metrics are not included directly in the raw sales transaction file. They are created during the project.

- Gross Revenue = Quantity × Unit Price
- Discount Amount = Gross Revenue × Discount %
- Net Revenue = Gross Revenue − Discount Amount
- Total Cost = Quantity × Unit Cost
- Gross Profit = Net Revenue − Total Cost
- Profit Margin % = Gross Profit / Net Revenue × 100

Only delivered orders are treated as realized sales for the financial analysis. Cancelled and returned orders do not contribute to realized revenue and profit.

**Project Workflow**

- Excel / Power Query
↓
- Data Profiling & Cleaning
↓
- Python / Pandas
↓
- EDA & Financial Calculations
↓
- MySQL / SQL
↓
- Business Analysis & KPI Queries
↓
- Power BI / DAX
↓
- Interactive Management Dashboard

**Tools & Technologies**
- Excel / Power Query — Data profiling and cleaning
- Python — Data cleaning, transformation and EDA
- Pandas / NumPy — Data manipulation and calculations
- SQL / MySQL — Business analysis and KPI queries
- Power BI — Dashboard and reporting
- DAX — Financial measures and KPIs
  
Python Analysis

Python and Pandas are used to:

- Inspect data quality
- Handle missing and duplicate records
- Clean and transform sales data
- Calculate revenue, cost and profit metrics
- Analyze monthly trends
- Analyze regional, channel and category performance
- Validate financial calculations
**SQL Analysis**

SQL is used for:

- Monthly revenue analysis
- Regional performance analysis
- Channel performance analysis
- Category and product analysis
- Customer contribution analysis
- Top-product analysis
- Budget vs. Actual analysis
- Revenue variance analysis

**Power BI Dashboard**

**The final Power BI dashboard contains six analysis pages:**

- Executive Overview
- Sales Analysis
- Profitability Analysis
- Budget vs Actual
- Regional Analysis
- Product Analysis

The dashboard uses KPIs, DAX measures, slicers, charts and tables to provide an interactive view of business performance.

**Key Business Insights**
- Actual realized revenue was approximately ₹3,355M
- Total budgeted revenue was approximately ₹3,975M
- Overall budget variance was approximately −₹620M
- The Central region was the strongest revenue contributor
- The Online channel generated the highest revenue
- Services was the highest-revenue category
- Budget vs. Actual analysis highlighted a significant revenue gap requiring management attention

**Project Structure**

finance-sales-performance-analysis/
 - ├── README.md
 - ├── data/
 - │    ├── raw/
 - │    └── cleaned/
 - ├── python/
 - ├── sql/
 - ├── powerbi/
 - ├── screenshots/
 - └── documentation/

**Documentation**

Detailed project workflow documentation covers:

**Project objective**
- Data preparation
- Python analysis
- SQL analysis
- MySQL integration
- Power BI data model
- Dashboard pages
- Validation
- Business insights

**Conclusion**
This project demonstrates an end-to-end approach to Finance and Sales Analytics, starting from raw business data and progressing through data cleaning, 
Python analysis, SQL-based reporting, financial KPI calculation and Power BI dashboard development.
The project is designed to demonstrate practical Data Analyst and FP&A-oriented analytical skills.


