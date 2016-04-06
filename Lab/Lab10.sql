-- Lab 10 – SQL
-- DUE START OF CLASS MARCH 31st 2016

-- Each problem is worth one point. No partial credit will be given. This lab is worth a total of 20 points.

-- Use hostname: classdb.jccc.edu

-- From this lab forward, please notice if a result table is in a particular order. If it is you must use the order by clause. Failure to do so will result in 0 points for that specific problem.

-- Place all answers into ONE .sql file. Attach that file to Dropbox for Lab 10 in D2L. Only one .sql file will be accepted.

-- Remember, in order to insert, update or delete table data, you must place a copy of the original table into your table space. You do not have update permissions on the original tables.

-- **** Use the Student table space for the following questions ****


-- http://dba.stackexchange.com/questions/133994/how-to-download-or-place-a-copy-of-original-tables-with-locked-permissions-via-r


-- 1.    Change Mary’s title on your Employee table to ‘Director’.

--   1 rows updated

UPDATE STUDENT_EMP_LOCAL
SET TITLE='Director'
WHERE TITLE='Manager';

-- 2.    Give all employees a 10% raise in salary. Use your Employee table.

--   4 rows updated

-- Page 225 within text

UPDATE STUDENT_EMP_LOCAL
SET SALARY = SALARY * 1.1;


-- ****3.    Display the average salary of all employees. Use your Employee table.

SELECT to_char(avg(salary), '$9,999.00') AS "New Average Salary"
FROM STUDENT_EMP_LOCAL;
  

-- 4.    Insert a new record into your Employee table (Employee_ID of 5, Name of ‘Dave’, Salary 
--        of 3000, Title of ‘Manager’) .

--   1 rows inserted

INSERT INTO student_emp_local (employee_id, name, salary, title)
VALUES (5,
        'Dave',
        3000,
        'Manager');


-- 5.    Display the standard deviation of the salary for all employees. Use your Employee table.

-- https://docs.oracle.com/cd/B19306_01/server.102/b14200/functions159.htm

SELECT FLOOR(STDDEV(salary)) "Standard Deviation"
FROM STUDENT_EMP_LOCAL;

-- 6.    Insert a new record into your Enrollment table. You must insert a valid value for the final 
--         grade.

INSERT INTO STUDENT_ENROLLMENT_LOCAL (student_id, section_id, enroll_date, final_grade, created_by, created_date, modified_by, modified_date)
VALUES (144,
        555,
        '01-JAN-16',
        99,
        'ASINGLE',
        '31-MAR-16',
        'ASINGLE',
        '01-APR-16');

--   1 rows inserted

-- 7.    Give all students in section 81 a final grade of 95. Use your Enrollment table.

-- PAGE 225 WITHIN TEXT

--   3 rows updated

UPDATE STUDENT_ENROLLMENT_LOCAL
SET FINAL_GRADE = 95
WHERE SECTION_ID = 81;

-- 8.    Display the number of students in your enrollment table that now have a valid final 
--         grade.

-- DELETE FROM STUDENT_ENROLLMENT_LOCAL WHERE STUDENT_ID=144;

-- select * FROM STUDENT_ENROLLMENT_LOCAL
-- WHERE FINAL_GRADE IS NOT NULL;

SELECT COUNT(FINAL_GRADE) AS "Students with Valid Grade"
FROM STUDENT_ENROLLMENT_LOCAL
WHERE FINAL_GRADE IS NOT NULL
  

-- 9.    Delete ‘Dave’ from your Employee table.

--   1 rows deleted

-- http://www.w3schools.com/sql/sql_delete.asp

DELETE
FROM STUDENT_EMP_LOCAL
WHERE Employee_ID=5;

-- 10.  Delete all rows in your Employee table.

--   4 rows deleted

-- http://www.w3schools.com/sql/sql_delete.asp

DELETE FROM STUDENT_EMP_LOCAL;

-- **** Use the HR table space for the following questions ****

-- 11.  Display the approximate hours a person has worked. Assume 2000 hours per year is 
--         worked by an individual. Use the Job_History table.

-- http://stackoverflow.com/questions/18534404/oracle-sql-dev-how-to-calc-num-of-weekdays-between-2-dates

SELECT START_DATE,
       END_DATE,

  (SELECT COUNT(*)
   FROM DUAL
   WHERE TO_CHAR(START_DATE + LEVEL - 1, 'DY') NOT IN ('SAT',
                                                       'SUN') CONNECT BY LEVEL <= (END_DATE - START_DATE + 1)*8 ) AS "Total Hours Worked"
FROM HR_JOBHX;

  

-- 12.  Display all employees whose first name starts with a ‘J’ and whose commission rate is 
--         greater than 10%. Use the Employees table.

SELECT first_name,
       last_name,
       commission_pct,
       hire_date
FROM HR_EMPLOYEES
WHERE first_name LIKE 'J%'
  AND COMMISSION_PCT > 0.1;
  

-- 13.  Display all employees whose first name starts with a ‘J’ and whose commission rate is 
--         greater than 10% and whose last name contains an ‘o’ and whose was hired after June 1, 
--        1996. Use the Employees table.

-- http://www.w3schools.com/sql/sql_wildcards.asp

SELECT first_name,
       last_name,
       commission_pct,
       hire_date
FROM HR_EMPLOYEES
WHERE first_name LIKE 'J%'
  AND COMMISSION_PCT > 0.1
  AND LAST_NAME LIKE '%o%'
  AND HIRE_DATE > '01-JUN-1996';


  

-- 14.  Display the last letter of all region names that are longer than 4 characters. Use the 
--         Regions table.

SELECT region_id,
       region_name,
       SUBSTR(region_name,-1) AS "Last Letter in Region Name"
FROM HR_REGIONS
WHERE LENGTH(REGION_NAME) > 4;




-- ****15.  Using LPAD and RPAD, recreate the following result table for department 100. Use the 
--         Employees table.

select first_name || last_name || 'earns' || salary from hr_employees AS "LPAD RPAD Example" where department_id= 100;

  

-- 16.  Calculate a bonus for each employee by using the number of days since they were hired. 
--         The employee receives $2 for each day they have been with the company. Assume this 
--         query is run on June 1, 2000. Use the Employees table.

-- Partial result table (107 rows total)

https://docs.oracle.com/cd/B19306_01/server.102/b14200/functions016.htm

SELECT Last_name,HIRE_DATE,
       CAST('01-JUN-2000'AS TIMESTAMP WITH LOCAL TIME ZONE),

  (SELECT COUNT(*)
   FROM DUAL
   WHERE TO_CHAR(HIRE_DATE + LEVEL - 1, 'DY') NOT IN ('SAT',
                                                       'SUN') CONNECT BY LEVEL <= (SYSDATE - HIRE_DATE + 1)*2 ) AS "Bonus"
FROM HR_EMPLOYEES;



-- 17.  Display team numbers for all employees. Team numbers are found by dividing the 
--         employee id by four. If 4 divides the employee id evenly, then that employee is part of 
--         team 1. For the other cases, a remainder of 1 places that employee on team 2, etc. Use 
--         the Employees table.

-- Partial result table (107 rows total)




-- 18.  Using question 17 as a starting point, display the number of employees on each team. 
--         Use the Employees table.

  

-- 19.  Display the following result table. Use the Employees table.

--   Partial result table (107 rows total)
  

-- 20.  Display all employees as either someone that earns a commission or someone that does 
--         not earn a commission. Use the Employees table.

-- Partial result table (107 rows total)

SELECT last_name, salary, commission_pct "Commission Percent" FROM HR_EMPLOYEES WHERE COMMISSION_PCT IS NOT NULL;



-- 21.  Display the number of employees employed each year. Use the Job_History table.

  

-- 22.  Display the job id of employees having an average salary of more than $10,000 and there 
--         must be more than one employee with that job id. Use the Employees table.

  
-- 23.  Using a NATURAL JOIN, join the tables Regions and Countries. Only select a country name 
--         of Canada. Use the Regions and Countries tables.

  

-- 24.  Display all employees that are part of a department. Show any employees that are not 
--         part of a department. Show any departments that do not have any employees. Use the
--         Departments and Employees tables.

-- Partial result table (123 rows total)



-- 25.  Using question 24 as a starting point, display any employees that are not currently 
--         assigned to a department. Use the Departments and Employees tables.

  

-- 26.  Display all managers that are in department 20 or 30, but not in department 50. You 
--         must use SET OPERATORS to receive credit. Use the Employees table.

  





-- 27.  Display all administration employees. Use the Employees table.

  
    

-- **** Use the Dual table for the following questions ****

-- 28.  Display the number of seconds in a year. Use the Dual table.

  

-- 29.  Starting with the date/time of July 20, 2001 10:40:12, display the following result table. Use the Dual table.

  

-- 30.  Display May 13, 2015 as per the following result table. Use the Dual table.

SELECT 'Wednesday, May 2015' AS "Formatted Current Date" FROM DUAL;

  



