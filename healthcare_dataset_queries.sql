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
    test_results VARCHAR(255));
    SHOW TABLES;
    DESCRIBE healthcare_dataset;
    SELECT * FROM healthcare_dataset LIMIT 5;
    
    #Query 1: Top 5 doctors generating highest total billing
    SELECT 
    doctor,
    hospital,
    SUM(billing_amount) AS total_revenue
FROM healthcare_dataset
GROUP BY doctor, hospital
ORDER BY total_revenue DESC
LIMIT 5;

#Query 2: Hospitals with the Highest Average Billing per Patient
SELECT 
    hospital,
    ROUND(AVG(billing_amount), 2) AS avg_billing,
    COUNT(*) AS total_patients
FROM healthcare_dataset
GROUP BY hospital
HAVING COUNT(*) > 5
ORDER BY avg_billing DESC;

#Query 3: Insurance Providers That Bear the Highest Total Billing Burden Across Medical Condition
SELECT insurance_provider, medical_condition, SUM(billing_amount) AS totalamount FROM healthcare_dataset
GROUP BY insurance_provider, medical_condition
ORDER BY totalamount DESC LIMIT 5;

#Query 4: Which Admission Type Costs the Most on Average?
SELECT 
    admission_type,
    ROUND(AVG(billing_amount), 2) AS avg_billing,
    COUNT(*) AS total_cases
FROM healthcare_dataset
GROUP BY admission_type
ORDER BY avg_billing DESC;

#Query 5: Doctors with Most Diverse Medical Conditions Treated
SELECT 
    doctor,
    COUNT(DISTINCT medical_condition) AS unique_conditions
FROM healthcare_dataset
GROUP BY doctor
ORDER BY unique_conditions DESC
LIMIT 5;

#Query 6: Season with Highest Number of Admissions
SELECT 
    MONTHNAME(date_of_admission) AS month_name,
    CASE 
        WHEN MONTH(date_of_admission) IN (12, 1, 2) THEN 'Winter'
        WHEN MONTH(date_of_admission) IN (3, 4, 5) THEN 'Spring'
        WHEN MONTH(date_of_admission) IN (6, 7, 8) THEN 'Summer'
        WHEN MONTH(date_of_admission) IN (9, 10, 11) THEN 'Fall'
    END AS season,
    COUNT(*) AS total_admissions
FROM healthcare_dataset
GROUP BY month_name, season
ORDER BY total_admissions DESC
LIMIT 5;

#Query 7: Patients Whose Billing Exceeds the Average for Their Hospital
SELECT 
    h1.name,
    h1.hospital,
    h1.billing_amount,
    ROUND(h2.avg_hospital_bill, 2) AS avg_hospital_bill
FROM healthcare_dataset h1
JOIN (
    SELECT 
        hospital,
        AVG(billing_amount) AS avg_hospital_bill
    FROM healthcare_dataset
    GROUP BY hospital
) h2
ON h1.hospital = h2.hospital
WHERE h1.billing_amount > h2.avg_hospital_bill
ORDER BY h1.hospital, h1.billing_amount DESC
LIMIT 20;

#Query 8: Which Blood Type is Associated with the Highest Average Bill? 
SELECT 
    blood_type,
    ROUND(AVG(billing_amount), 2) AS avg_bill
FROM healthcare_dataset
GROUP BY blood_type
ORDER BY avg_bill DESC;

#Query 9: Most Common Medical Condition
SELECT medical_condition,
COUNT(*) AS total_cases
FROM healthcare_dataset
GROUP BY medical_condition
ORDER BY total_cases DESC;

#Query 10: Detect Data Errors: Discharge Before Admission
SELECT *
FROM healthcare_dataset
WHERE discharge_date < date_of_admission;






