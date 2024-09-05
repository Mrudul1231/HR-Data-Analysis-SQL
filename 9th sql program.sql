-- Create database
CREATE DATABASE hrdata;
USE hrdata;
SELECT*FROM employees;

-- total employees
SELECT COUNT(*) AS Total_employees
FROM employees;

-- total old employees
SELECT COUNT(*) AS TOTAL_Old_employees
from employees
WHERE DateofTermination !="";

-- total current employees
SELECT COUNT(*) AS TOTAL_Current_employees
from employees
WHERE DateofTermination ="";

-- Average Salary
SELECT AVG(SALARY) AS AVG_Salary
FROM employees;

-- Average Age
SELECT AVG(TIMESTAMPDIFF(YEAR,STR_TO_DATE(DOB,'%d-%m-%Y'),CURDATE())) AS Avg_Age
FROM employees;

-- Average years in company
SELECT AVG(TIMESTAMPDIFF(YEAR,STR_TO_DATE(DateofHire,'%d-%m-%Y'),CURDATE())) AS Avg_Age_Years_in_Company
FROM employees;

-- adding new coloumn for employee current status
ALTER TABLE employees
ADD EmployeeCurrentStatus INT;

-- UPDATING VALUES FOR NEW COLOUMN
SET SQL_SAFE_UPDATES=0;
UPDATE employees
SET EmployeeCurrentStatus=CASE
WHEN DateofTermination=''THEN 1
ELSE 0
END;

-- Calculate Attrition Rate based on custom EmpStatusID values 
SELECT
(CAST(COUNT(CASE WHEN EmployeeCurrentStatus=0 THEN 1 END) AS FLOAT)/COUNT(*))*100 AS Attrition_Rate
FROM employees;

-- get coloumn names and data types
DESCRIBE employees;
SHOW COLUMNS FROM employees;

-- print 1st 5 rows
SELECT* FROM employees LIMIT 5;

-- Print last 5 Rows
SELECT*FROM employees
order by EmpID DESC LIMIT 5;

-- Changing data type of salary
ALTER TABLE employees
MODIFY COLUMN Salary DECIMAL(10,2);

-- Convert all date columns in proper dates
UPDATE employees
SET DOB=STR_TO_DATE(DOB,'%Y-%m-%d');
UPDATE employees
SET DateofHire=STR_TO_DATE(DateofHire,'%Y-%m-%d');
UPDATE employees
SET LastPerformanceReview_Date=STR_TO_DATE(LastPerformanceReview_Date,'%Y-%m-%d');

-- Alter table
ALTER TABLE employees
MODIFY COLUMN DOB DATE,
MODIFY COLUMN DateofHire DATE,
MODIFY COLUMN LastPerformanceReview_DATE DATE;

-- Read columns to check changes
 SELECT DOB,DateofHire,DateofTermination,LastPerformanceReview_Date FROM employees;
DESCRIBE employees;

-- fill empty values in date of termination
UPDATE employees
SET DateofTermination='CurrentlyWorking'
WHERE DateofTermination IS NULL OR DateofTermination='';

-- count of each unique value in the MaritalDesc
SELECT MaritalDesc,COUNT(*)AS Count
FROM employees
GROUP BY MaritalDesc
ORDER BY Count DESC;

-- count of each unique value in the department
SELECT Department,COUNT(*) AS Count
FROM employees
GROUP BY Department
ORDER BY Count DESC;

-- COUNT OF EACH UNIQUE VALUE IN THE POSITIONS
SELECT Position,COUNT(*) AS Count
FROM employees
GROUP BY position
ORDER BY Count DESC;

-- COUNT OF EACH UNIQUE VALUE IN THE MANAGER
SELECT ManagerName,COUNT(*) AS COUNT
FROM employees
GROUP BY ManagerName
ORDER BY COUNT DESC;

-- SALARY DISTRIBUTION BY EMPLOYEES
SELECT
CASE
WHEN Salary <30000 then '<30k'
WHEN Salary BETWEEN 30000 AND 49999 THEN '30K-49K'
WHEN Salary BETWEEN 50000 AND 69999 THEN '50K-69K'
WHEN Salary BETWEEN 70000 AND 89999 THEN '70K-89K'
WHEN Salary >=90000 THEN '90K AND ABOVE'
END AS Salary_Range,
COUNT(*) AS Frequency
FROM employees GROUP BY Salary_Range ORDER BY Salary_Range;

-- Performance score
SELECT 
PerformanceScore,
COUNT(*) AS Count
FROM employees
GROUP BY PerformanceScore
ORDER BY PerformanceScore;

-- AVERAGE SALARY BY DEPARTMENT
SELECT
DEPARTMENT,
AVG(Salary) AS AverageSalary
FROM employees
GROUP BY Department
ORDER BY Department;

-- count termination by cause
SELECT
TermReason,
COUNT(*) AS Count
FROM employees
WHERE TermReason IS NOT NULL
GROUP BY TermReason
ORDER BY CouNt DESC;

-- EMPLOYEE COUNT OF STATE
SELECT
State,
COUNT(*) AS Count
FROM employees
GROUP BY State
ORDER BY Count DESC;

-- GENDER DISTRIBUTION
SELECT 
Sex,
COUNT(*) AS Count
FROM employees
GROUP BY Sex
ORDER BY Count DESC;

-- Add a new coloumn AGE
ALTER TABLE employees
ADD COLUMN Age INT;

-- Update th age column with calculated age
Set sql_safe_updates=0;
UPDATE employees
SET Age =TIMESTAMPDIFF(YEAR,DOB,CURDATE());

-- AGE DISTRIBUTION

SELECT
CASE
WHEN Age <20 then '<20'
WHEN Age BETWEEN 20 AND 29 THEN '20-29'
WHEN Age BETWEEN 30 AND 39 THEN '30-39'
WHEN Age BETWEEN 40 AND 49 THEN '40-49K'
WHEN Age BETWEEN 50 AND 59 THEN '50-59'
WHEN AGE >=60 THEN '60 AND ABOVE'
END AS AGE_Range,
COUNT(*) AS Count
FROM employees GROUP BY Age_Range;

-- absences by department
select 
department,
sum(Absences) as TotalAbsences
FROM employees
GROUP BY DEPARTMENT
ORDER BY TotalAbsences DESC;

-- SALARY DISTRIBUTION BY GENDER
SELECT Sex,
SUM(Salary) AS TotalSalary
FROM employees;

-- Count of employees terminated as per marital status
SELECT
MaritalDesc,
count(*) AS TerminatedCount
FROM employees
WHERE Termd=1
GROUP BY MaritalDesc
ORDER BY TerminatedCount DESC;

-- AVERAGE ABSENCE BY PERFORMANCE SCORE
SELECT
PerformanceScore,
AVG(Absences) AS AverageAbsences
FROM employees
GROUP BY PerformanceScore
ORDER BY PerformanceScore;

-- employee count by recuirment score
SELECT 
RecruitmentSOUrCe,
COUNT(*) AS EmployeeCount
FROM employees
GROUP BY RecruitmentSource
ORDER BY EmployeeCount DESC;