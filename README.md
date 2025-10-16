# 🏥 Hospital Data Analytics Using SQL

## 📘 Overview
This project explores a real-world **healthcare dataset** using SQL to uncover insights into hospital performance, patient admissions, and cost patterns.  
The goal is to showcase advanced SQL querying skills, analytical reasoning, and storytelling through data.

---

## 📊 Dataset Description
**Source:** [Healthcare Dataset by Prasad22 (Kaggle)](https://www.kaggle.com/datasets/prasad22/healthcare-dataset)

**Rows:** 55,000  
**Columns:** 15  

**Key Columns**
- `name` – Patient name  
- `age`, `gender`, `blood_type` – Demographic details  
- `medical_condition` – Health issue  
- `doctor`, `hospital` – Provider details  
- `insurance_provider` – Payer organization  
- `billing_amount` – Total bill per patient  
- `date_of_admission`, `discharge_date` – Admission timeline  
- `admission_type` – Emergency / Elective / Urgent  
- `medication`, `test_results` – Treatment details  

---

## Tools & Environment
- **SQL Engine:** MySQL 8.0  
- **IDE:** MySQL Workbench  
- **Techniques Used:** Joins, Grouping, Subqueries, CASE, Aggregation, Data Validation  

---

## Database Setup
```sql
CREATE DATABASE healthcare_db;
USE healthcare_db;

CREATE TABLE healthcare_dataset (
    name VARCHAR(50),
    age INT,
    gender VARCHAR(10),
    blood_type VARCHAR(5),
    medical_condition VARCHAR(100),
    date_of_admission DATE,
    doctor VARCHAR(50),
    hospital VARCHAR(100),
    insurance_provider VARCHAR(50),
    billing_amount DECIMAL(10,2),
    room_number VARCHAR(10),
    admission_type VARCHAR(50),
    discharge_date DATE,
    medication VARCHAR(100),
    test_results VARCHAR(255)
);

**SQL Queries & Insights**
1. Top 5 Doctors Generating Highest Total Billing
SELECT doctor, hospital, SUM(billing_amount) AS total_revenue
FROM healthcare_dataset
GROUP BY doctor, hospital
ORDER BY total_revenue DESC
LIMIT 5;


Insight: Identifies top-performing doctors based on total hospital billing.

2. Hospitals with Highest Average Billing
SELECT hospital, ROUND(AVG(billing_amount), 2) AS avg_billing, COUNT(*) AS total_patients
FROM healthcare_dataset
GROUP BY hospital
HAVING COUNT(*) > 5
ORDER BY avg_billing DESC;


Insight: Shows which hospitals have the highest per-patient billing on average.

3. Insurance Providers Bearing Highest Billing Burden
SELECT insurance_provider, medical_condition, SUM(billing_amount) AS totalamount
FROM healthcare_dataset
GROUP BY insurance_provider, medical_condition
ORDER BY totalamount DESC
LIMIT 5;


Insight: Displays which insurance providers face the highest costs for specific diseases.

4. Admission Type with Highest Average Cost
SELECT admission_type, ROUND(AVG(billing_amount), 2) AS avg_billing, COUNT(*) AS total_cases
FROM healthcare_dataset
GROUP BY admission_type
ORDER BY avg_billing DESC;


Insight: Helps hospitals understand which admission types are most expensive.

5. Doctors with the Most Diverse Medical Conditions
SELECT doctor, COUNT(DISTINCT medical_condition) AS unique_conditions
FROM healthcare_dataset
GROUP BY doctor
ORDER BY unique_conditions DESC
LIMIT 5;


Insight: Highlights multi-specialty doctors who handle a wide range of cases.

6. Seasons with the Highest Admissions
SELECT 
    MONTHNAME(date_of_admission) AS month_name,
    CASE 
        WHEN MONTH(date_of_admission) IN (11, 12, 1, 2) THEN 'Winter'
        WHEN MONTH(date_of_admission) IN (3, 4, 5) THEN 'Spring'
        WHEN MONTH(date_of_admission) IN (6, 7, 8) THEN 'Summer'
        WHEN MONTH(date_of_admission) IN (9, 10) THEN 'Fall'
    END AS season,
    COUNT(*) AS total_admissions
FROM healthcare_dataset
GROUP BY month_name, season
ORDER BY total_admissions DESC
LIMIT 5;


Insight: Helps identify seasonal patterns in hospital admissions, enabling hospitals to plan resources and staffing based on patient inflow trends throughout the year.

7. Patients with Above-Average Billing in Their Hospital
SELECT h1.name, h1.hospital, h1.billing_amount, ROUND(h2.avg_hospital_bill, 2) AS avg_hospital_bill
FROM healthcare_dataset h1
JOIN (
    SELECT hospital, AVG(billing_amount) AS avg_hospital_bill
    FROM healthcare_dataset
    GROUP BY hospital
) h2
ON h1.hospital = h2.hospital
WHERE h1.billing_amount > h2.avg_hospital_bill
ORDER BY h1.hospital, h1.billing_amount DESC
LIMIT 20;


Insight: Identifies patients whose bills are higher than the hospital’s average — potential high-cost outliers.

8. Blood Type vs. Average Billing
SELECT blood_type, ROUND(AVG(billing_amount), 2) AS avg_bill
FROM healthcare_dataset
GROUP BY blood_type
ORDER BY avg_bill DESC;


Insight: Compares average billing across different blood types.

9. Most Common Medical Conditions
SELECT medical_condition, COUNT(*) AS total_cases
FROM healthcare_dataset
GROUP BY medical_condition
ORDER BY total_cases DESC;


Insight: Finds the most frequently treated diseases.

10. Detect Data Errors — Discharge Before Admission
SELECT * 
FROM healthcare_dataset
WHERE discharge_date < date_of_admission;


Insight: Flags incorrect entries for data cleaning.

**Learnings**

Strengthened proficiency in SQL joins, subqueries, and CASE statements.
Developed ability to transform raw data into actionable business insights.
Learned to perform data validation and anomaly detection.
Practiced real-world healthcare data analytics using SQL.

**Author**

👩‍💻 Merin Renjith
Healthcare & Data Analytics Enthusiast
