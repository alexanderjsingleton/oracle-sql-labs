-- Lab 8 – SQL
-- Due March 10, 2016

-- Each problem is worth one point. No partial credit will be given. This lab is worth a total of 20  points.

-- Use hostname: classdb.jccc.edu

-- From this lab forward, please notice if a result table is in a particular order. If it is you must use the order by clause. Failure to do so will result in 0 points for that specific problem.

-- Place all answers into ONE .sql file. Attach that file to the Dropbox for Lab 8 in D2L. Only one .sql file will be accepted.

-- Table names are not given. You must determine the correct tables.

-- **** Use the Student table space for the following questions ****

-- 1.    Display the course revenue even if no course revenue exists for a particular course. Use a 
--         Left Outer Join.

-- Partial result table (30 rows total)

-- USED NVL ISNULL
-- http://www.w3schools.com/sql/sql_isnull.asp

-- SELECT c.course_no,
--        c.description,
--        nvl(cr.revenue,0)
-- FROM student.course c
-- LEFT OUTER JOIN student.course_revenue cr ON c.COURSE_NO = cr.course_no
-- ORDER BY cr.revenue ASC;

SELECT c.course_no,
       c.description,
       nvl(cr.revenue,0) AS "Total Revenue per Course"
FROM student.course c
LEFT OUTER JOIN student.course_revenue cr ON cr.COURSE_NO = c.course_no
ORDER BY nvl(cr.revenue,0) ASC;

-- 2.    Display the course revenue even if no course revenue exists for a particular course. Use a 
--         Right Outer Join.

-- Page 136 within textbook

-- select c.course_no
--         c.description,
--         nvl(cr.revenue,0)
-- FROM student.course_revenue cr
-- RIGHT OUTER JOIN student.course c ON c.course_no = cr.course_no
-- ORDER BY nvl(cr.revenue,0) ASC; 


select  c.course_no,
        c.description,
        nvl(cr.revenue,0) AS "Total Revenue per Course"
FROM student.course_revenue cr
RIGHT OUTER JOIN student.course c ON c.course_no = cr.course_no
ORDER BY nvl(cr.revenue,0) ASC; 

-- Partial result table (30 rows total)


-- 3.    Display all courses that had revenue.

-- Partial result table (24 rows total)


SELECT c.course_no,
       c.description,
       cr.revenue
FROM student.course_revenue cr
RIGHT OUTER JOIN student.course c ON c.course_no = cr.course_no
WHERE cr.revenue IS NOT NULL
ORDER BY cr.revenue DESC;
  

-- 4.    Display the average course fee.

SELECT to_char(avg(course_fee), '$999,999.00') AS "Average Cost per Course"
FROM student.course_revenue;
 

-- 5.    Display all courses that cost more than 1100 and the course prerequisite is between 25
--         and 80, inclusive and the course description ends in an ‘s’.

-- select description, cost, prerequisite from student.course
-- WHERE cost > 1100 AND prerequisite BETWEEN 25 AND 80;

SELECT description,
       cost,
       prerequisite
FROM student.course
WHERE description LIKE '%s'
  AND cost > 1100
  AND prerequisite BETWEEN 25 AND 80;
  

-- 6.    Display the number of courses by cost.


-- http://stackoverflow.com/questions/2068682/why-cant-i-use-alias-in-a-count-column-and-reference-it-in-a-having-clause
-- https://community.oracle.com/thread/698866?start=0&tstart=0

-- SELECT vendor_state,
--        COUNT(*) AS "Vendors per State"
-- FROM ap.vendors
-- GROUP BY vendor_state
-- ORDER BY vendor_state;

-- SELECT COST, count(*) AS "vendors per state" 
-- FROM STUDENT.COURSE
-- group_by COST
-- order by COST;

SELECT cost,
       COUNT(*) AS "Total Courses"
FROM STUDENT.COURSE
GROUP BY cost
ORDER BY "Total Courses" DESC;
 

-- 7.    Display any courses that have at least 10 characters but strictly less than 16.

SELECT course_no,
       description
FROM student.course
WHERE LENGTH(description) >= 10
  AND LENGTH(description) < 16;
  

-- **** Use the Dual table for the following questions ****

-- 8.    Display today’s date formatted as per the result table. Your date will be different.

SELECT to_char(sysdate, 'mm/dd/yyyy') AS "Formatted Today's Date"
FROM dual;
  

-- 9.    Display today’s date formatted as per the result table. Your date will be different.
-- Page 265 top from book:
-- Number 6 from Lab05:

-- *****Great resource*****=>http://www.techonthenet.com/oracle/functions/to_char.php

-- SELECT TO_CHAR(SYSDATE -1/24,'DD-MON-RR HH:MI:SS') AS "One Hour Ago"
-- FROM DUAL;

-- SELECT to_char(sysdate, 'DAY, DD-MON-RRRR HH:MI:SS') AS "Formatted Today's Date"
-- FROM dual;

-- SELECT to_char(sysdate, 'DAY, DD-MON-RRRR HH:MI:SS') AS "Formatted Today's Date"
-- FROM dual;

-- SELECT to_char(sysdate, 'DD-MON-YYYY HH:MI:SS') AS "Formatted Today's Date"
-- FROM dual;

SELECT to_char(sysdate, 'DD-MON-YYYY HH:MI:SS') AS "Formatted Today's Date"
FROM dual;

-- 10.  Display today’s date formatted as per the result table. Your date will be different.

-- SELECT to_char(sysdate, 'DY FMMonth DD, YYYY') AS "Formatted Today's Date"
-- FROM dual;

SELECT to_char(sysdate, 'Dy FMMonth DD, YYYY') AS "Formatted Today's Date"
FROM dual;
  
-- **** Use the Student table space for the following questions ****

-- 11.  Display the most expensive course. No hard-coding of values allowed.

SELECT max(cost) AS "Highest Cost"
FROM student.course;

-- 12.  Format the results of problem 11 as per the result table.

SELECT to_char(max(cost),'$999,999.00') AS "Highest Cost"
FROM student.course;

-- 13.  Display the various results for salary as per the result table.

SELECT min(salary) AS "Minimum",
       max(salary) AS "Maximum",
       avg(salary) AS "Average",
       median(salary) AS "Median"
FROM student.employee;
    

-- 14.  Display the total of the minimum and maximum salary.

SELECT min(salary) + max(salary) AS "Min plus Max"
FROM student.employee;
 
-- 15.  Display all employees who are either managers or analysts. You must use the IN operator 
--         to receive credit.

-- http://www.w3schools.com/sql/sql_in.asp

SELECT employee_id,
       name,
       title
FROM student.employee
WHERE title IN('Manager',
               'Analyst')
ORDER BY employee_id DESC;

  

-- 16.  Display all student last names that sound like ‘Archer’.
-- https://docs.oracle.com/cd/B12037_01/server.101/b10759/conditions016.htm

-- GREAT RESOURCE => https://docs.oracle.com/cd/B19306_01/appdev.102/b14251/adfns_regexp.htm

-- SELECT last_name
-- FROM student.student
-- WHERE last_name like('Arch%');

-- SELECT last_name AS "Sounds like Archer"
-- FROM student.student
-- WHERE REGEXP_LIKE(last_name, '^Arch(e|o)r$')

-- SOUNDEX FUNCTION => http://www.techonthenet.com/oracle/functions/soundex.php

SELECT last_name
FROM student.student
WHERE SOUNDEX(LAST_NAME) = SOUNDEX('Archer');

-- 17.  Display the number of students employed by each employer.

-- Partial result table (161 rows total)

-- JUST LIKE NUMBER FROM ABOVE

-- http://stackoverflow.com/questions/2068682/why-cant-i-use-alias-in-a-count-column-and-reference-it-in-a-having-clause
-- https://community.oracle.com/thread/698866?start=0&tstart=0

-- SELECT vendor_state,
--        COUNT(*) AS "Vendors per State"
-- FROM ap.vendors
-- GROUP BY vendor_state
-- ORDER BY vendor_state;

-- SELECT COST, count(*) AS "vendors per state" 
-- FROM STUDENT.COURSE
-- group_by COST
-- order by COST;

-- SELECT cost,
--        COUNT(*) AS "Total Courses"
-- FROM STUDENT.COURSE
-- GROUP BY cost
-- ORDER BY "Total Courses" DESC;

SELECT EMPLOYER,
       COUNT(*) AS "Number of Students Employed by"
FROM STUDENT.STUDENT
GROUP BY EMPLOYER
ORDER BY "Number of Students Employed by" DESC;


-- 18.  Display the number of students employed by each employer. Only list those employers 
--         that have more than 7 students employed.

  -- SELECT * FROM STUDENT.STUDENT;

-- Notes from #16, Lab06
-- http://stackoverflow.com/questions/2068682/why-cant-i-use-alias-in-a-count-column-and-reference-it-in-a-having-clause
-- https://community.oracle.com/thread/698866?start=0&tstart=0

-- SELECT vendor_state,
--        COUNT(*) AS "Vendors per State"
-- FROM ap.vendors
-- GROUP BY vendor_state
-- HAVING COUNT(*) >= 3
-- ORDER BY COUNT(*) DESC;

SELECT EMPLOYER,
       COUNT(*) AS "Number of Students Employed by"
FROM STUDENT.STUDENT
GROUP BY EMPLOYER
HAVING COUNT(*) >= 7
ORDER BY "Number of Students Employed by" DESC;

-- 19.  Display the first 10 rows of students ordered by student id.

-- http://www.adp-gmbh.ch/ora/sql/examples/first_rows.html

-- SELECT student_id,
--        last_name || ', ' || first_name AS "Last, First"
-- FROM STUDENT.STUDENT
-- ORDER BY STUDENT_ID ASC;

SELECT student_id,
       last_name || ', ' || first_name AS "Last, First"
FROM STUDENT.STUDENT
WHERE ROWNUM <= 10
ORDER BY STUDENT_ID ASC;

-- 20.  Display the following result table using the Coalesce function.

-- https://docs.oracle.com/cd/B28359_01/server.111/b28286/functions023.htm
-- http://www.techonthenet.com/oracle/functions/coalesce.php
-- http://www.w3schools.com/sql/sql_isnull.asp
-- https://oracle-base.com/articles/misc/null-related-functions

-- ***ALSO SEE QUESTION NUMBER 2 AND 3 WITHIN THIS LAB!***

-- SELECT * FROM STUDENT.grade_summary;

-- SELECT MIDTERM_GRADE, FINALEXAM_GRADE, QUIZ_GRADE FROM STUDENT.grade_summary;

-- SELECT MIDTERM_GRADE,
--        FINALEXAM_GRADE,
--        QUIZ_GRADE,
--        COALESCE(MIDTERM_GRADE, FINALEXAM_GRADE, QUIZ_GRADE) "Default of 0"
-- FROM STUDENT.grade_summary;

SELECT MIDTERM_GRADE,
       FINALEXAM_GRADE,
       QUIZ_GRADE,
       NVL(COALESCE(MIDTERM_GRADE, FINALEXAM_GRADE, QUIZ_GRADE),0) "Default of 0"
FROM STUDENT.grade_summary;



  





