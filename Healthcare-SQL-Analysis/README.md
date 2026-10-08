# 🏥 Healthcare SQL Analysis

## 📌 Project Overview

This project is a SQL-based analysis of a healthcare database. It uses patient, doctor, department, billing, medication, and appointment data to answer practical business and healthcare analytics questions.

The project demonstrates SQL techniques commonly used in data analysis, including joins, aggregation, views, window functions, CTEs, triggers, and data modification.

## 🛠️ Tools & Technologies

- **Database:** MySQL
- **Language:** SQL
- **Tool:** MySQL Workbench
- **Domain:** Healthcare Analytics

## 📂 Project Files

```text
Healthcare-SQL-Analysis/
│
├── README.md
│
├── Dataset/
│   └── Healthcare_Analytics_DB.sql
│
└── SQL/
    └── Sakshi_Shinde_SQL_Exam.sql
```

### Dataset

`Dataset/Healthcare_Analytics_DB.sql` contains the SQL database used for the project, including the database structure and data required for the analysis.

### SQL Analysis

`SQL/Sakshi_Shinde_SQL_Exam.sql` contains the SQL questions, solutions, analysis queries, view, CTE, trigger, update operation, and DDL tasks completed for the project.

## 📊 SQL Concepts Demonstrated

- SELECT statements
- WHERE conditions
- CONCAT()
- COUNT() and SUM()
- GROUP BY
- ORDER BY
- LIMIT
- INNER JOIN
- LEFT JOIN
- Views
- Window Functions
- CTE (Common Table Expressions)
- UPDATE statements
- DDL and DML
- Primary Keys
- Foreign Keys
- AUTO_INCREMENT
- Triggers

## 🔍 Analysis Performed

### 1. Patient Analysis
Retrieved the first 10 patients from Bengaluru with patient ID, full name, city, and blood group.

### 2. Doctor Analysis
Identified active doctors with more than 10 years of experience.

### 3. Patient Count by Doctor
Calculated the total number of patients treated by each doctor.

### 4. Payment Analysis
Calculated the number of paid bills and total net amount for each payment mode.

### 5. Department Revenue Analysis
Identified the top 5 departments based on total revenue from paid patient bills.

### 6. Doctor Revenue View
Created the `vw_doctor_revenue` view to display each doctor's ID, full name, and total revenue collected from paid bills. The project also filters doctors whose total revenue exceeds ₹1000.

### 7. Top Paying Patients
Identified the top 5 patients based on the total amount paid across their bills.

### 8. Medication Analysis
Retrieved medications prescribed by doctors belonging to departments whose names contain `ology`.

### 9. Top 3 Patients Per City
Used the `RANK()` window function to identify the top 3 earning patients in each city based on total amount paid.

### 10. Pending Bill Discount Update
Updated the discount for bills with a `Pending` payment status.

### 11. CTE Analysis
Used a Common Table Expression (CTE) to identify doctors who handled more than 8 appointments.

### 12. Trigger
Created the `trg_update_discount` trigger to automatically set the discount to 10% of `net_amount` when a newly inserted bill has a NULL discount.

### 13. DDL Task
Created `Hospital_Training_DB` with `test_doctors` and `test_patients` tables, including primary and foreign key relationships and sample records.

## 🚀 How to Run the Project

### Step 1 — Import the Dataset

Open **MySQL Workbench** and run the file:

```text
Dataset/Healthcare_Analytics_DB.sql
```

This creates and populates the database required for the analysis.

### Step 2 — Run the Analysis

Open:

```text
SQL/Sakshi_Shinde_SQL_Exam.sql
```

Run the queries section by section in MySQL Workbench.

> **Note:** Run the database/dataset file before running the analysis queries because the analysis depends on the healthcare tables created by the dataset.

## 🎯 Key Learning Outcomes

Through this project, I practiced:

- Writing SQL queries for data analysis
- Working with multiple related tables
- Combining data using JOINs
- Aggregating and grouping data
- Creating and querying SQL views
- Using CTEs
- Applying window functions
- Creating database triggers
- Working with primary and foreign keys
- Performing data updates
- Creating databases and tables using DDL

## 👩‍💻 Author

**Sakshi Shinde**

Aspiring Data Analyst | SQL | Data Analytics | MySQL

## ⭐ Project Highlights

This project demonstrates practical SQL skills for healthcare data analysis, including data extraction, aggregation, transformation, and analysis. It is intended as a portfolio project to showcase SQL and data analytics skills.
