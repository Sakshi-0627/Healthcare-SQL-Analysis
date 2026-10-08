-- ==============================================================
-- SQL Exam
-- Dataset : Healthcare_analytics
-- Sakshi Shinde
-- ==============================================================

-- ===============================================================================================================
-- Q1. List the first 10 patients from the city ‘Bengaluru’, showing patient_id, full name, city, and blood group.
-- ===============================================================================================================
select * from patients;

select patient_id, concat(first_name,' ',last_name) as "Full name" , city, blood_group
from patients
where city= "Bengaluru"
limit 10;


-- ===============================================================================================================
-- Q2. Display all doctors who are currently ‘Active’ and have more than 10 years of experience.
-- ===============================================================================================================

select * from doctors;

select doctor_id, CONCAT(first_name, ' ', last_name) AS doctor_name, specialization, experience_years,city, consultation_fee
from doctors
where status="Active" 
and experience_years>10;


-- =================================================================================================================
-- Q3. Find the total number of patients treated by each doctor. Display doctor_id, doctor name, and patient_count.
-- =================================================================================================================

select * from patients;
select * from doctors;

select d.doctor_id,concat(d.first_name,' ',d.last_name) as "Doctor_Name",
       count( distinct p.patient_id) as "Total_Patient"
from doctors as d
left join patients as p
using(doctor_id)
group by d.doctor_id, Doctor_Name;


-- ==================================================================================================================
-- Q4. For each payment mode, find how many bills are ‘Paid’ and their total net_amount.
-- ==================================================================================================================
select * from bills;

select payment_mode, count(*) as "Total bills paid" ,sum(net_amount) as "Total Net Amount"
from bills
where payment_status="Paid" 
group by payment_mode;



-- =================================================================================================================
-- Q5. Show top 5 departments with the highest total revenue generated from patient bills.
-- ==================================================================================================================

select * from departments;

select d.department_id,d.department_name , sum(b.net_amount) as Total_amount
from departments as d
inner join doctors as dc
on d.department_id=dc.department_id
inner join bills as b
on dc.doctor_id=b.doctor_id
WHERE b.payment_status = "Paid"
group by d.department_id,d.department_name
order by Total_amount desc
limit 5;


-- =================================================================================================================
-- Q6. Create a view named “vw_doctor_revenue” that displays each doctor’s total revenue collected from paid bills.
-- ==================================================================================================================
/* The view should include:
●	Doctor ID
●	Doctor Full Name
●	Total Revenue (sum of net_amount from paid bills) */

create view vw_doctor_revenue as
select d.doctor_id, concat(d.first_name,' ',d.last_name) as Doctor_Name ,sum(b.net_amount) as Total_Revenue
from doctors as d
inner join bills as b
on d.doctor_id=b.doctor_id
where payment_status="paid"
group by d.doctor_id, Doctor_name;

-- 1. Select all columns from vw_doctor_revenue

select * from vw_doctor_revenue;

-- 2. Display only those doctors whose total revenue exceeds ₹1000

select * from vw_doctor_revenue
where Total_Revenue>1000;

-- =================================================================================================================
-- Q7. Identify the top 5 patients who have paid the highest total amount across all their bills.
--     Show patient name and total amount paid.
-- ==================================================================================================================

select concat(p.first_name,' ',p.last_name) as Patient_name, sum(b.net_amount) as Total_amount_paid
from patients as p
inner join 
bills as b
on p.patient_id=b.patient_id
where b.payment_status="Paid"
group by p.patient_id, Patient_name
order by Total_amount_paid Desc
limit 5;

-- =================================================================================================================
-- Q8. Show a list of medications prescribed by doctors belonging to departments whose name contains ‘ology’ 
--     (like Cardiology, Neurology, etc.).
-- ==================================================================================================================

select * from medications;
select * from departments;

select m.medication_id, m.generic_name, m.brand_name, CONCAT(d.first_name,' ',d.last_name) AS doctor_name, de.department_name
from medications as m
inner join 
doctors as d
on m .doctor_id=d.doctor_id
inner join departments as de
on d.department_id=de.department_id
where de.department_name like "%ology%";

-- ===========================================================================================================================
-- Q9. Using a window function, list the top 3 earning patients per city based on total amount paid (net_amount from bills).
-- ===========================================================================================================================

select *
from
(select  p.city,concat(p.first_name,' ',p.last_name) as patient_name,sum(b.net_amount) as Total_paid, rank()
Over(Partition by p.city order by sum(b.net_amount) desc) as Rank_in_city
from patients as p 
inner join 
bills as b
on p.patient_id=b.patient_id
where b.payment_status='paid'
group by p.patient_id,p.city, patient_name
)temp
where rank_in_city<=3;


-- ===========================================================================================================================
-- Q10. Increase the discount by 5% for all bills where payment_status = ‘Pending’.
-- ===========================================================================================================================
select * from bills;
-- 1. Check how many such records exist.
select count(*) as Total_Pending_bills
from bills
where payment_status="pending";

-- 2. Preview a few rows.
select bill_id, patient_id, net_amount, discount, payment_status
from bills
where payment_status='pending'
limit 10;

-- update discount
update bills
set discount = discount + (net_amount * 0.05)
where payment_status = 'Pending';

/* if discount was null
then we have to do 
set discount = ifnull(discount, 0) + (net_amount * 0.05)
because if null +100=null
but here discount was not null that's why set discount = discount + (net_amount * 0.05) */

-- 3. Verify that discounts are correctly applied
select bill_id, patient_id, net_amount, discount, payment_status
from bills
where payment_status = 'Pending'
limit 10;

-- ===========================================================================================================================
-- Q11. Part A – CTE:
--      Write a CTE (Common Table Expression) to find doctors who have handled more than 8 appointments.
-- ===========================================================================================================================

 with doctor_appointments as
(
    select
        doctor_id,
        COUNT(*) as appointment_count
    from appointments
    group by doctor_id
)
select
    d.doctor_id,
    CONCAT(d.first_name,' ',d.last_name) as doctor_name,
    da.appointment_count
from doctor_appointments as da
inner join doctors as d
on da.doctor_id = d.doctor_id
where appointment_count > 8;

-- ==========================================================================================================================
-- Part B – Trigger:
-- Create a trigger named trg_update_discount that automatically updates the discount field in the bills table
-- to 10% of net_amount whenever a new bill is inserted with a NULL discount
-- ==========================================================================================================================
DELIMITER $$

create trigger trg_update_discount
before insert 
on bills
for each row
begin
    if new.discount is null then
        set new.discount = new.net_amount * 0.10;
    end if;
end$$

DELIMITER ;


-- ===========================================================================================================================
-- Q12. DDL Task
-- Create a new database named ‘Hospital_Training_DB’ and inside it create two tables:
-- test_doctors and test_patients.
-- ===========================================================================================================================

-- Create Database
create database Hospital_Training_DB;
use Hospital_Training_DB;

-- Create Table
Create table test_doctors
(
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(100),
    experience_years INT
);

Create table test_patients
(
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    doctor_id INT,
    city VARCHAR(100),
    FOREIGN KEY (doctor_id) REFERENCES test_doctors(doctor_id)
);

-- Insert 2 records each

Insert into test_doctors
(first_name, last_name, specialization, experience_years)
values ('Sakshi', 'Shinde', 'Neurology', 10),
('Karan', 'Patil', 'Orthopedics', 12);

select * from test_doctors;

insert into test_patients
(first_name, last_name, doctor_id, city)
values ('Zarna', 'Sonar', 1, 'Mumbai'),
('Mahima', 'Gupta', 2, 'Pune');

select * from test_patients;

-- By using Joins

select d.doctor_id, concat(d.first_name,' ',d.last_name) as Doctor_name , p.patient_id, concat(p.first_name,' ',p.last_name) as Patient_name
from test_doctors as d
inner join test_patients as p
on d.doctor_id=p.doctor_id;

