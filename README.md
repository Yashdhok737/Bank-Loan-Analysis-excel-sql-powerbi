# 📊Bank Loan Analysis 


###  Overview

This project focuses on analyzing bank loan data to extract meaningful insights related to loan applications, approvals, customer profiles, and financial risk. The analysis helps in understanding lending patterns and supports data-driven decision-making.

<img width="1453" height="804" alt="Overview" src="https://github.com/user-attachments/assets/9b9fa172-c54a-45a4-ba42-509e77039998" />


###  Objectives
- Analyze loan application trends (MTD, YTD)
- Identify factors affecting loan approval and rejection
- Evaluate customer financial behavior
- Monitor key performance indicators (KPIs) like total loans, interest rate, and repayment status
- Provide actionable insights using interactive dashboards

###  Tools & Technologies Used
- Microsoft Excel → Data cleaning and preprocessing
- SQL (PostgreSQL) → Data querying and transformation
- Power BI → Data visualization and dashboard creation

###  Dataset Details

- The dataset contains information related to:
  
    - Customer Information: Annual income, employment length, job title
    - Loan Details: Loan amount, interest rate, term, grade, purpose
    - Loan Status: Fully Paid, Charged Off, Current
    - Dates: Issue date, last payment date, next payment date
    - Financial Metrics: Installment, DTI (Debt-to-Income ratio), total payment

###  Project Workflow

1️⃣ Data Cleaning (Excel)

- Removed duplicates and null values
- Standardized formats (dates, text fields)
- Ensured data consistency

2️⃣ Data Analysis (SQL)

- Used SQL queries for:
    - Aggregations (SUM, AVG, COUNT)
    - Grouping and filtering
    - Date-based analysis (MTD, YTD)
      
#### Example SQL Query:

    SELECT 
        EXTRACT(MONTH FROM issue_date) AS month,
        COUNT(id) AS total_applications
    FROM Bank_Data
    GROUP BY month
    ORDER BY month;

- Created insights like:
    - Total loan applications
    - Average interest rate
    - Loan status distribution

3️⃣ Data Visualization (Power BI)

- Built interactive dashboards including:
    -  Loan Application Trends (MTD, MoM)
    -  Total Funded Amount & Received Amount
    -  Loan Status Breakdown
    -  Customer Segmentation (income, employment)
- Used filters, slicers, and KPIs for better user experience

###  Key Insights

- Majority of loans fall under specific grades and purposes
- Higher income groups tend to have better repayment rates
- Certain loan purposes have higher default risk
- Monthly trends show variation in loan demand

###  KPIs Created

- Total Loan Applications
- Total Funded Amount
- Total Amount Received
- Average Interest Rate
- Debt-to-Income Ratio (DTI)
- Loan Status Ratio (Good vs Bad Loans)

###  How to Use

1. Open the dataset in Excel for raw data
2. Run SQL queries to explore insights
3. Open Power BI file to interact with dashboards

###  Challenges Faced

- Handling inconsistent date formats
- Managing missing and null values
- Converting data types for analysis (e.g., string to datetime)
- Optimizing SQL queries for performance
  
###  Results

- Successfully built a dynamic dashboard for loan analysis
- Generated actionable insights to improve decision-making
- Improved understanding of risk patterns and customer segmentation
 
###  Conclusion

This project demonstrates how combining Excel, SQL, and Power BI enables effective data analysis and visualization. The insights generated can help financial institutions reduce risk, improve loan approval strategies, and enhance customer targeting.

###  Future Scope

- Apply machine learning models for loan default prediction
- Integrate real-time data pipelines
- Enhance dashboard with advanced analytics

###  Author & Contact

#### Yash Dhok

Email : dhokyash4@gmail.com

LinkedIn : www.linkedin.com/in/yash-dhok-375a58319

### 🔗 If you like this project

Give it a ⭐ on GitHub and share your feedback!
