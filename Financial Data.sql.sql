DROP TABLE IF EXISTS Bank_Loan_Data;
CREATE TABLE Bank_Loan_Data(
    id INT PRIMARY KEY,
    address_state VARCHAR(100),
    application_type VARCHAR(100),
    emp_length VARCHAR(100),
    emp_title VARCHAR(100),
    grade VARCHAR(50),
    home_ownership VARCHAR(100),
    issue_date DATE,
    last_credit_pull_date DATE,
    last_payment_date DATE,
    loan_status VARCHAR(100),
    next_payment_date DATE,
    member_id INT,
    purpose VARCHAR(100),
    sub_grade VARCHAR(100),
    term VARCHAR(100),
    verification_status VARCHAR(100),
    annual_income DECIMAL(12,2),
    dti NUMERIC(10,4),
    installment NUMERIC(10,2),
    int_rate NUMERIC(10,4),
    loan_amount DECIMAL(12,2),
    total_acc INT,
    total_payment DECIMAL(12,2)
);

SELECT * FROM Bank_Loan_Data;

--DASHBOARD 1: SUMMARY

--1)Total Loan Application
SELECT COUNT(id) AS Total_Application FROM Bank_Loan_Data;

--MONTH TO DATE Application CURRENT
SELECT COUNT(id) AS MTD_Total_Loan_Application 
FROM Bank_Loan_Data
WHERE EXTRACT(MONTH FROM issue_date)=12 AND EXTRACT(YEAR FROM issue_date)=2021;

--MONTH TO MONTH Application
--(MTD-PMTD)/PMTD :- PERCENTAGE
SELECT COUNT(id) AS PMTD_Total_Loan_Application 
FROM Bank_Loan_Data
WHERE EXTRACT(MONTH FROM issue_date)=11 AND EXTRACT(YEAR FROM issue_date)=2021;

--2)Total Funded Amount
SELECT CAST(SUM(loan_amount) AS DECIMAL(12,0)) AS Total_Funded_Amount FROM Bank_Loan_Data;

--MONTH TO DATE Total_Funded_AmounT-CURRENT
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM Bank_Loan_Data
WHERE EXTRACT(MONTH FROM issue_date)=12 AND EXTRACT(YEAR FROM issue_date)=2021;

--MONTH TO MONTH Total_Funded_Amount-PREVIOUS
--(MTD-PMTD)/PMTD :- PERCENTAGE
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount
FROM Bank_Loan_Data
WHERE EXTRACT(MONTH FROM issue_date)=11 AND EXTRACT(YEAR FROM issue_date)=2021;

--3)Total Amount Received
SELECT SUM(total_payment) AS Toatl_Amount_received FROM Bank_Loan_Data;

--MONTH TO DATE Total Amount Received CURRENT
SELECT SUM(total_payment) AS MTD_Toatl_Amount_received FROM Bank_Loan_Data
WHERE EXTRACT(MONTH FROM issue_date)=12 AND EXTRACT(YEAR FROM issue_date)=2021;

--MONTH TO MONTH Total Amount Received 
SELECT SUM(total_payment) AS PMTD_Toatl_Amount_received FROM Bank_Loan_Data
WHERE EXTRACT(MONTH FROM issue_date)=11 AND EXTRACT(YEAR FROM issue_date)=2021;

--4)Average Interest Rate
SELECT ROUND(AVG(int_rate)*100,2) AS Avg_Interest_Rate FROM Bank_Loan_Data;

SELECT ROUND(AVG(int_rate)*100,2) AS MTD_Avg_Interest_Rate FROM Bank_Loan_Data
WHERE EXTRACT(MONTH FROM issue_date)=12 AND EXTRACT(YEAR FROM issue_date)=2021;

SELECT ROUND(AVG(int_rate)*100,2) AS PMTD_Avg_Interest_Rate FROM Bank_Loan_Data
WHERE EXTRACT(MONTH FROM issue_date)=11 AND EXTRACT(YEAR FROM issue_date)=2021;

--5)Average Debt-to-income Ratio(DTI)
SELECT ROUND(AVG(dti)*100,2) AS Avg_Debt_to_income FROM Bank_Loan_Data;

SELECT ROUND(AVG(dti)*100,2) AS MTD_Avg_Debt_to_income FROM Bank_Loan_Data
WHERE EXTRACT(MONTH FROM issue_date)=12 AND EXTRACT(YEAR FROM issue_date)=2021;

SELECT ROUND(AVG(dti)*100,2) AS PMTD_Avg_Debt_to_income FROM Bank_Loan_Data
WHERE EXTRACT(MONTH FROM issue_date)=11 AND EXTRACT(YEAR FROM issue_date)=2021;


--GOOD LOAN VS BAD LOAN

--GOOD LOAN
--1)Good Loan Application Percentage
SELECT 
      COUNT(CASE WHEN loan_status='Fully Paid' OR loan_status='Current' THEN id END)*100/
	  COUNT(id) AS Good_loan_percentage
FROM Bank_Loan_Data;

--2)Good Loan Application
SELECT COUNT(id) AS Good_loan_Application FROM Bank_Loan_Data
WHERE loan_status='Fully Paid' OR loan_status='Current';

--3)Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_Amount FROM Bank_Loan_Data
WHERE loan_status='Fully Paid' OR loan_status='Current';

--4)Good Loan Total Received Amount
SELECT SUM(total_payment) AS Good_Loan_Total_Received_Amount FROM Bank_Loan_Data
WHERE loan_status='Fully Paid' OR loan_status='Current';

--BAD LOAN
--1)Bad Loan Application Percentage
SELECT 
      COUNT(CASE WHEN loan_status='Charged Off' THEN id END)*100/
	  COUNT(id) AS Bad_loan_percentage
FROM Bank_Loan_Data;

--2)Bad Loan Application
SELECT COUNT(id) AS Bad_loan_Application FROM Bank_Loan_Data
WHERE loan_status='Charged Off';

--3)Good Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount FROM Bank_Loan_Data
WHERE loan_status='Charged Off';

--4)Good Loan Total Received Amount
SELECT SUM(total_payment) AS Bad_Loan_Total_Received_Amount FROM Bank_Loan_Data
WHERE loan_status='Charged Off';

--LOAN STATUS GRID VIEW

SELECT loan_status,
COUNT(id) AS LoanCount,
SUM(total_payment) AS Total_Amount_Received,
SUM(loan_amount) AS Total_Funded_Amount,
AVG(int_rate*100) AS Interest_Rate,
AVG(dti*100) AS DTI
FROM Bank_Loan_Data
GROUP BY loan_status;

--MONTH TO DATE 
SELECT loan_status,
COUNT(id) AS LoanCount,
SUM(total_payment) AS MTD_Total_Amount_Received,
SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM Bank_Loan_Data
WHERE EXTRACT(MONTH FROM issue_date)=12
GROUP BY loan_status;


--DASHBOARD 2:OVERVIEW

--CHARTS

--1)Monthly Trends by issue date
SELECT EXTRACT(MONTH FROM issue_date),
       TO_CHAR(issue_date,'Month') AS month_name,
	   COUNT(id) AS total_loan_Application,
	   SUM(total_payment) AS Total_Amount_Received,
	   SUM(loan_amount) AS Total_Funded_Amount
FROM Bank_Loan_Data
GROUP BY  EXTRACT(MONTH FROM issue_date),TO_CHAR(issue_date,'Month') 
ORDER BY EXTRACT(MONTH FROM issue_date);

--2)Regional Analysis by State
SELECT address_state,
	   COUNT(id) AS total_loan_Application,
	   SUM(total_payment) AS Total_Amount_Received,
	   SUM(loan_amount) AS Total_Funded_Amount
FROM Bank_Loan_Data
GROUP BY address_state
ORDER BY SUM(loan_amount) DESC;


--3)Loan Term Analysis
SELECT term,
	   COUNT(id) AS total_loan_Application,
	   SUM(total_payment) AS Total_Amount_Received,
	   SUM(loan_amount) AS Total_Funded_Amount
FROM Bank_Loan_Data
GROUP BY term
ORDER BY term;

--4)Employee Length Analysis
SELECT emp_length,
	   COUNT(id) AS total_loan_Application,
	   SUM(total_payment) AS Total_Amount_Received,
	   SUM(loan_amount) AS Total_Funded_Amount
FROM Bank_Loan_Data
GROUP BY emp_length
ORDER BY emp_length;

--5)Loan Purpose Breakdown
SELECT purpose,
	   COUNT(id) AS total_loan_Application,
	   SUM(total_payment) AS Total_Amount_Received,
	   SUM(loan_amount) AS Total_Funded_Amount
FROM Bank_Loan_Data
GROUP BY purpose
ORDER BY COUNT(id) DESC;

--6)Home Ownership Analysis
SELECT home_ownership,
	   COUNT(id) AS total_loan_Application,
	   SUM(total_payment) AS Total_Amount_Received,
	   SUM(loan_amount) AS Total_Funded_Amount
FROM Bank_Loan_Data
GROUP BY home_ownership
ORDER BY COUNT(id) DESC;


--DASHBOARD 3:DETAILS
--GRID VIEW
SELECT * FROM Bank_Loan_Data;