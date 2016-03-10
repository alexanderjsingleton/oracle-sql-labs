-- Lab 5 – SQL
-- Due Start of Class February 25, 2016

-- Each problem is worth one point. No partial credit will be given. This lab is worth a total of 15 points.

-- Use hostname: classdb.jccc.edu

-- From this lab forward, please notice if a result table is in a particular order. If it is you must use the order by clause. Failure to do so will result in 0 points for that specific problem.

-- Place all answers into ONE .sql file. Attach that file to the Dropbox for Lab 5 in D2L. Only one .sql file will be accepted.

-- **** Use the Dual table for the following questions ****

-- 1.    Display the integer division, full division, and mod of 7/3. Use the Dual table.
-- https://community.oracle.com/thread/955074?start=0&tstart=0
-- MOD: https://docs.oracle.com/cd/B19306_01/server.102/b14200/functions088.htm

SELECT TRUNC (7/3) AS "Integer Div",
       (7/3) AS "Full Div",
       MOD(7,3) AS "Mod"
FROM DUAL;
 
-- 2.    Display the ceiling and floor values of 5.768 and -2.35. Use the Dual table.

SELECT CEIL(5.768) AS "Ceil Value of 5.768",
       FLOOR (5.768) AS "Floor Value of 5.768",
       CEIL(-2.35) AS "Ceil Value of -2.35",
       FLOOR(-2.35) AS "Floor Value of -2.35"
FROM DUAL;
 
-- 3.    Display the absolute value of -3.4, 0 and 4.01. Use the Dual table.

SELECT ABS (-3.4) AS "Absolute Value of -3.4",
           ABS (0) AS "Absolute Value of 0",
               ABS (4.01) AS "Absolute Value of 4.01"
FROM DUAL;
 

-- 4.    Using the value 9.58348, display the following result table using only the round function.
--         Use the Dual table.
-- https://docs.oracle.com/cd/B19306_01/server.102/b14200/functions135.htm
-- http://www.techonthenet.com/oracle/functions/round_nbr.php
-- http://www.w3schools.com/sql/sql_func_round.asp

SELECT ROUND(9.58348) AS "Answer 1",
       ROUND (9.58348,1) AS "Answer 1",
       ROUND (9.58348,4) AS "Answer 3",
       ROUND (9.58348,5) AS "Answer 2"
FROM DUAL;
 

-- 5.    Display the number of years between August 15, 2011 and December 4, 1865.
--         Use the Dual table.

-- http://www.w3schools.com/sql/sql_dates.asp
-- http://stackoverflow.com/questions/28406397/datediff-function-in-oracle/35589445#35589445

SELECT FLOOR((to_date('2011-08-04', 'yyyy-MM-dd') - to_date('1865-12-04', 'yyyy-MM-dd')) /365) AS "Number of Years"
FROM dual;

  

-- 6.    Display the current date and time one hour ago. Use the Dual table. Your answer will be 
--        dependent on todays’ date and time.
-- Page 265 top from book:

SELECT TO_CHAR(SYSDATE -1/24,'DD-MON-RR HH:MI:SS') AS "One Hour Ago"
FROM DUAL;

-- 7.    Display the current year. Use the Dual table. 
-- Page 265 top from book:

SELECT TO_CHAR(SYSDATE, 'YYYY') AS "One Hour Ago"
FROM DUAL;
 
-- 8.    Display the results of solving the quadratic formula using the following values: a=1, b=5, 
--         c=1. Use the Dual table.
-- http://progopedia.com/implementation/oracle-sql/
-- http://dba.stackexchange.com/questions/130322/how-to-reformat-oracle-sql-quadratic-equation-solver-script

-- Refactored solution:

ALTER SESSION
SET NLS_NUMERIC_CHARACTERS='. ';

SELECT 'Not a quadratic equation.' AS "Answer 1", '0' AS "Answer 2"
FROM dual
WHERE &&A = 0
UNION
SELECT 'x = ' || to_char(-&&B/2/&A) AS "Answer 1", '0' AS "Answer 2"
FROM dual
WHERE &A != 0
  AND &B*&B-4*&A*&&C = 0
UNION
SELECT 'x1 = ' || to_char((-&B+sqrt(&B*&B-4*&A*&C))/2/&A) AS "Answer 1", 'x2 = ' || to_char(-&B-sqrt(&B*&B-4*&A*&C))/2/&A AS "Answer 2"
FROM dual
WHERE &A != 0
  AND &B*&B-4*&A*&C > 0
UNION
SELECT 'x1 = (' || to_char(-&B/2/&A) || ',' || to_char(sqrt(-&B*&B+4*&A*&C)/2/&A) || '), ' AS "Answer 1", 'x2 = (' || to_char(-&B/2/&A) || ',' || to_char(-sqrt(-&B*&B+4*&A*&C)/2/&A) || ')' AS "Answer 2"
FROM dual
WHERE &A != 0
  AND &B*&B-4*&A*&C < 0;


-- First attempt: 

ALTER SESSION
SET NLS_NUMERIC_CHARACTERS='. ';


SELECT 'Not a quadratic equation.' ans
FROM dual
WHERE &&A = 0
UNION
SELECT 'x = ' || to_char(-&&B/2/&A)
FROM dual
WHERE &A != 0
  AND &B*&B-4*&A*&&C = 0
UNION
SELECT 'x1 = ' || to_char((-&B+sqrt(&B*&B-4*&A*&C))/2/&A) || ', x2 = ' || to_char(-&B-sqrt(&B*&B-4*&A*&C))/2/&A
FROM dual
WHERE &A != 0
  AND &B*&B-4*&A*&C > 0
UNION
SELECT 'x1 = (' || to_char(-&B/2/&A) || ',' || to_char(sqrt(-&B*&B+4*&A*&C)/2/&A) || '), ' || 'x2 = (' || to_char(-&B/2/&A) || ',' || to_char(-sqrt(-&B*&B+4*&A*&C)/2/&A) || ')'
FROM dual
WHERE &A != 0
  AND &B*&B-4*&A*&C < 0;


 
-- 9.    Display the current date 3 months ago. Use the Dual table. Your answer depends on 
--         when you run this query.
-- https://community.oracle.com/thread/919912?tstart=0

SELECT add_months(SYSDATE,-3) AS "Three Months Ago"
FROM DUAL;

-- 10.  Display the last day of the current month. Use the Dual table. Your answer depends on 
--         when you run this query.
-- https://docs.oracle.com/cd/B28359_01/server.111/b28286/functions077.htm

SELECT LAST_DAY(SYSDATE) AS "Last Day of Month"
FROM DUAL;


-- 11.  Display the time zone used by the Oracle database server. Use the Dual table.
-- http://docs.oracle.com/cd/B19306_01/server.102/b14200/functions143.htm
-- Go to p.537 in texbook

SELECT DBTIMEZONE AS "Time Zone for DB Server"
FROM DUAL;

-- Alternatives:
SELECT SESSIONTIMEZONE FROM DUAL;

-- 12.  Display the number of days left in the current month. Use the Dual table. Your answer 
--         depends on when you run this query.
-- https://docs.oracle.com/cd/B28359_01/server.111/b28286/functions077.htm

SELECT SYSDATE AS "Current Date",
       LAST_DAY(SYSDATE) AS "Last Day of Current Month",
       LAST_DAY(SYSDATE) - SYSDATE AS "Days Left in Current Month"
FROM DUAL;

-- 13.  Using the power function, display the number 7 raised to the 8th power. Use the Dual 
--         table.
-- https://docs.oracle.com/cd/B19306_01/server.102/b14200/functions112.htm

SELECT POWER(7,8) AS "7 raised to the 8th power"
FROM DUAL;

-- **** Use the Student table space for the following questions ****

-- 14.   Display all students that enrolled in January. Use the Enrollment table.
-- http://www.dba-oracle.com/t_select_rows_specific_month.htm

SELECT *
FROM student.enrollment
WHERE to_char(enroll_date,'Mon-YYYY')='Jan-2007';


-- 15.   Display all course costs as per the following result table. You must use the Case function.
--          Use the Course table.
  
-- Partial Result Table (30 rows total)
-- https://docs.oracle.com/cd/B28359_01/server.111/b28286/expressions004.htm


SELECT course_no,
       description,
       CASE cost
           WHEN 1095 THEN 'Low'
           WHEN 1595 THEN 'High'
           ELSE 'Medium'
       END AS "Category for Costs"
FROM student.course
ORDER BY "Category for Costs" ASC;

