-- Lab 4 – SQL
-- Due Thursday February 18th

-- Each problem is worth one point. No partial credit will be given. This lab is worth a total of 20 points.

-- Use hostname: classdb.jccc.edu

-- From this lab forward, please notice if a result table is in a particular order. If it is you must use the order by clause. Failure to do so will result in 0 points for that specific problem.

-- Place all answers into ONE .sql file. Attach that file to the Dropbox for Lab 4 in D2L. Only one .sql file will be accepted.

-- **** Use the AP table space for the following questions ****

-- 1.    Write an SQL statement to generate the following error message: ORA-00904. Use the
--         Invoices table.
-- http://www.techonthenet.com/oracle/errors/ora00904.php
-- You tried to execute a SQL statement that included an invalid column name or the column name is missing. This commonly occurs 
-- when you reference an invalid alias in a SELECT statement.

SELECT invoicee_id
FROM ap.invoices;

-- 2.    Write an SQL statement to generate the following error message: ORA-00942. Use the 
--         Invoices table.
-- http://www.techonthenet.com/oracle/errors/ora00942.php
-- You tried to execute a SQL statement that references a table or view that either does not exist, that you do not have access to, 
-- or that belongs to another schema and you didn't reference the table by the schema name.

SELECT invoice_id
FROM ap.invoicees;


-- 3.    Write an SQL statement to generate the following error message: ORA-00933. Use the 
--         Invoices table.
-- http://www.techonthenet.com/oracle/errors/ora00933.php
-- You tried to execute a SQL statement with an inappropriate clause.

SELECT invoice_id
FROM ap.invoices ORDER_BY id;

-- 4.    Write an SQL statement to generate the following error message: ORA-00936. Use the 
--         Invoices table.
-- http://www.techonthenet.com/oracle/errors/ora00936.php
-- When you encounter an ORA-00936 error, the following error message will appear

SELECT invoice_id
FROM ap.invoices
GROUP BY number;

-- 5.    Display formatted invoice totals as dollar amounts. Use the Invoices table.

--   Partial Result Table (114 rows total)

SELECT TO_CHAR(invoice_total, '$99,999.99') AS "Formatted"
FROM ap.invoices;


-- 6.    Display invoice totals in scientific notation. Use the Invoices table.

-- Partial Result Table (114 rows total)
-- Page 245 in book:
SELECT TO_CHAR(invoice_total, '9.99EEEE') AS "Scientific Notation"
FROM ap.invoices;



-- 7.    Display the following result table. Use the Invoices table.

--   Partial Result Table (114 rows total)
-- https://community.oracle.com/thread/342445?tstart=0

SELECT TO_CHAR(invoice_date, 'MM/DD/YYYY') AS "Formatted Invoice Date"
FROM ap.invoices
ORDER BY "Formatted Invoice Date" ASC;


-- 8.    Display the invoices for May 7, 2008. Use the Invoices table.

SELECT *
FROM ap.invoices
WHERE INVOICE_DATE='07-May-08';


-- **** Use the Student table space for the following questions ****

-- 9.    Display the enrollment information for students enrolling on January 30, 2007. Use the 
--         Enrollment table.
-- Professor, please see below link and comment
-- http://stackoverflow.com/questions/35470753/how-to-select-all-data-from-table-but-only-display-date-specific-rows-within-dat
---- I do vagulely rememeber you saying something last week about this class-did it apply to this question?
----"If you are using SQL Developer then go to Tools > Preferences > Database > NLS and update the Date Format to something like DD-MON-YYYY HH24:MI:SS to display the time component. If you are in SQL/Plus then you can do ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YYYY HH24:MI:SS';. This will show you why your dates are not being matched. – MT0 13 hours ago ""

-- Trunc strips off the end of the time-stamp; this is why this is so sick!

SELECT e.*
FROM student.enrollment e
WHERE TRUNC(e.enroll_date) = DATE '2007-01-30';
  

-- 10.  Display the city, state and zip as one column. You must use the concat function to receive 
--         credit. Use the Zipcode table.

-- Partial Result Table (227 rows total)
-- http://www.techonthenet.com/oracle/functions/concat.php

SELECT CONCAT(CONCAT(CONCAT(CONCAT(city, ' '),STATE),' '),zip) AS "All together with Concat"
FROM student.zipcode;



-- 11.  Display the city, state and zip as one column. You must use ||’s to receive 
--         credit. Use the Zipcode table.

-- Partial Result Table (227 rows total)

SELECT (city || ' ' || STATE || ' ' || zip) AS "All together with ||"
FROM student.zipcode;


-- 12.  Display the city in upper case, lower case and mixed case. You must use one SQL    
--         statement only. Use the Zipcode table.

--   Partial Result Table (227 rows total)
-- Tried to solicit other alternatives on SO; I'll provide upon ability
--   http://stackoverflow.com/questions/35487341/how-to-structure-query-to-display-different-versions-of-one-column

SELECT 
   city AS "Original",
   upper(city) AS "Upper",
   lower(city) AS "Lower"
FROM student.zipcode;

-- -- First attempt:
-- SELECT city,
--        UPPER(SUBSTR(city,1,29)) AS "Upper",
--        lower(SUBSTR(city,1,29)) AS "lower",
--        city AS "MIXED"
-- FROM student.zipcode;


-- 13.  Display all cities whose number of characters are between 5 and 9 inclusive. Use the 
--         Zipcode table.

-- Partial Result Table (156 rows total)

-- SELECT city
-- FROM student.zipcode
-- WHERE LENGTH(city) >= 4
--   AND LENGTH(city) <= 9;

-- CORRECTION:

SELECT city
FROM student.zipcode
WHERE LENGTH(city) >= 4
  AND LENGTH(city) <= 9
ORDER BY city ASC;  

-- 14.  Display the 2nd, 3rd and 4th character of all cities. Use the Zipcode table.

-- Partial Result Table (227 rows total)
-- http://www.techonthenet.com/oracle/regexp_like.php
-- http://www.postgresql.org/docs/9.3/static/functions-matching.html
-- https://docs.oracle.com/cd/B12037_01/server.101/b10759/functions058.htm

-- SELECT SUBSTR(city,2,3,4) 
-- FROM student.zip;

-- CORRECTON
SELECT SUBSTR(city,2,3) 
FROM student.zipcode;



-- 15.  Display the last 3 characters of all cities. Use the Zipcode table.

-- Partial Result Table (227 rows total)
-- https://community.oracle.com/thread/3610502?start=0&tstart=0
-- http://www.techonthenet.com/oracle/functions/regexp_instr.php
-- http://stackoverflow.com/questions/35489437/how-to-retrieve-specific-character-positions-within-rows-of-database-column-usin

-- SELECT SUBSTR(city,-3) AS "Last Three"
-- FROM student.zipcode;

-- CORRECTION:

SELECT CITY, SUBSTR(city,-3) AS "Last Three"
FROM student.zipcode
ORDER BY CITY;

-- 16.  Display all rows in the Grade_Summary table. For any null values in the Midterm_Grade 
--         column, display 0. Use the Grade_Summary table.

-- http://stackoverflow.com/questions/24501915/using-nvl-for-multiple-columns-oracle-sql
-- http://www.techonthenet.com/oracle/functions/nvl.php

-- Final Answer:

-- SELECT student_id,
--        NVL(midterm_grade, 0) AS "Midterm Grade",
--        finalexam_grade,
--        quiz_grade
-- FROM student.grade_summary;

-- Correction:

SELECT student_id,
       NVL(midterm_grade, 0) AS "No Grade Found",
       finalexam_grade AS "FINALEXAM_GRADE",
       quiz_grade
FROM student.grade_summary;

-- Note to Professor George:
-- I'm experiencing problems returning the above query with the entire table; essentially I want to
SELECT * FROM student.grade_summary 

-- COMBINED with

SELECT student_id,
       NVL(midterm_grade, 0) AS "Midterm Grade",
       finalexam_grade,
       quiz_grade
FROM student.grade_summary;

-- what do I need to do in order to display as requested?
 

-- 17.  Display all students that are doctors. Replace the Dr. salutation with Doctor. Use the 
--         Student table.

-- SELECT * FROM (
-- SELECT student_id,
--        salutation,
--        CASE
--            WHEN salutation IN('Dr.') THEN 'Doctor'
--        END AS NewSalutation
-- FROM student.student
-- ) 
-- WHERE NewSalutation IS NOT NULL;

-- CORRECT: 

SELECT * FROM (
SELECT student_id,
       salutation,
       CASE
           WHEN salutation IN('Dr.') THEN 'Doctor'
       END AS "New Salutation"
FROM student.student
) 
WHERE "New Salutation" IS NOT NULL;

-- alternatives:

-- SELECT student_id,
--        salutation,
--        CASE
--            WHEN salutation IN('Dr.') THEN 'Doctor'
--        END AS NewSalutation
-- FROM student.student
-- WHERE salutation = 'Dr.';

-- -- Other attempts:

-- SELECT student_id,
--        salutation,
--        CASE
--            WHEN salutation IN('Dr.') THEN 'Doctor'
--        END AS "NewSalutation"
-- FROM student.student

-- SELECT e.* FROM student.student AS "New alias" e WHERE e.salutation='Dr.';

-- SELECt * FROM student.student;

  

-- 18.  Remove all spaces at the end of the street address. Use the Student table.

--   Partial Result Table (268 rows total)

-- that was the alternative---trim-trailing select street address (trim(trailing))

SELECT street_address,
       RTRIM(street_address) AS "Trimmed Address"
FROM student.student;



-- **** Use the Dual table for the following questions ****

-- 19.  Convert a character string to a number. Use the Dual table.

-- http://ss64.com/ora/syntax-to_number.html

SELECT to_number('123.45') AS "String to Number"
FROM DUAL;


  

-- 20.  Using the SQRT function, create the following result table. Use the Dual table.
-- Professor, a little help here- how do I return NaN for a SQRT(-1)?

-- SELECT SQRT(4) AS "SQRT of 4", SQRT(0) AS "SQRT of 0", SQRT(1) AS "SQRT of -1" FROM DUAL;

-- CORRECTION:
-- http://dba.stackexchange.com/questions/129842/how-to-return-nan-using-sqrt-function-in-oracle-sql

SELECT SQRT(4) AS "SQRT of 4",
   SQRT(0) AS "SQRT of 0",
   SQRT(TO_BINARY_DOUBLE(-1)) AS "SQRT of -1"
FROM DUAL;



  
