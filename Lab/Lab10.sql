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

Select rpad(first_name||' '||last_name,10)||' earns '||lpad(salary,6,' ') as "LPAD RPAD Example"
From hr.employees
Where department_id = 100
Order By 1;

  

-- 16.  Calculate a bonus for each employee by using the number of days since they were hired. 
--         The employee receives $2 for each day they have been with the company. Assume this 
--         query is run on June 1, 2000. Use the Employees table.

-- Partial result table (107 rows total)

-- https://docs.oracle.com/cd/B19306_01/server.102/b14200/functions016.htm

Select last_name, hire_date, (to_date('01-Jun-2000', 'dd-mon-yyyy') - hire_date) * 2 as "Bonus"
From hr.employees
Order by "Bonus" desc;


##EC

--P17
Select first_name, last_name, employee_id, 
       mod(employee_id, 4) + 1 as "Team#"
From hr.employees
Order By employee_id;

--P18
Select mod(employee_id, 4) + 1 as "Team#", count(*) as "Employees on each Team"
From hr.employees
Group By mod(employee_id, 4) + 1
Order By 1;

--P19 
Select hire_date, add_months(hire_date, -15) as "15 Months Before the Hire Date"
From hr.employees
Order By hire_date;

--P20
Select last_name, salary, nvl(commission_pct, 0.0) as "Commission Percent",
       nvl2(commission_pct, 'Commission Earner', 'Not a Commission Earner') as employee_type
From hr.employees
Order By salary desc;

--P21
Select to_char(end_date, 'yyyy') as "Year",
       count(*) as "Number of Employees"
From hr.job_history
Group by to_char(end_date, 'yyyy')
Order by 2 desc;

--P22
Select job_id, to_char(avg(salary), '$99,999.99') as "Average Salary", count(*) as "Total"
From hr.employees
Group By job_id
Having avg(salary) > 10000 and
       count(*) > 1
Order by job_id;

--P23
Select region_name
From hr.regions
Natural Join hr.countries
Where country_name = 'Canada';

--P24
Select e.last_name, d.department_name
From hr.departments d
Full Outer Join hr.employees e
  ON e.department_id = d.department_id
Order By d.department_name;

--P25
Select e.last_name, d.department_name
From hr.departments d
Full Outer Join hr.employees e
  ON e.department_id = d.department_id
Where d.department_name is null
Order By e.last_name;

--P26
Select manager_id 
From hr.employees
Where department_id = 20
UNION
Select manager_id 
From hr.employees
Where department_id = 30
MINUS
Select manager_id 
From hr.employees
Where department_id = 50;

--P27
Select 'Advertising Team Member: ' || substr(first_name, 1, 1) || '. ' ||
       last_name as "Initial and Last Name"
From hr.employees
Where substr(job_id,1,2) = 'AD'
Order By 1;

--28
Select to_char(365.25 * 24 * 60 * 60, '999,999,999') as "Seconds in a year"
From dual;

--29
Select to_char(to_date('20-JUL-2001 10:40:12', 'dd-MON-yy hh24:mi:ss') - 2, 'dd-Mon-yy hh24:mi:ss') as "Subtract 2 Days",
       to_char(to_date('20-JUL-2001 10:40:12', 'dd-MON-yy hh24:mi:ss') + .5, 'dd-Mon-yy hh24:mi:ss') as "Add Half a Day",
       to_char(to_date('20-JUL-2001 10:40:12', 'dd-MON-yy hh24:mi:ss') + 4.5/24, 'dd-Mon-yy hh24:mi:ss') as "Add 4 and a Half Hours"
From dual;

--30
Select to_char(to_date('13-May-2015', 'dd-mon-yyyy'), 'Day') || ', ' || trim(to_char(to_date('13-May-2015', 'dd-mon-yyyy'), 'Month')) || ' ' || to_char(to_date('13-May-2015', 'dd-mon-yyyy'), 'YYYY') as "Formatted Current Date"
From dual;



