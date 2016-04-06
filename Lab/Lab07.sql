-- Lab 7 – SQL
-- DUE March 10, 2016

-- Each problem is worth one point. No partial credit will be given. This lab is worth a total of 15  points.

-- Use hostname: classdb.jccc.edu

-- From this lab forward, please notice if a result table is in a particular order. If it is you must use the order by clause. Failure to do so will result in 0 points for that specific problem.

-- Place all answers into ONE .sql file. Attach that file to the Dropbox for Lab 7 in D2L. Only one .sql file will be accepted.

-- Table names are not given. You must determine the correct tables.

-- **** Use the Student table space for the following questions ****

-- 1.    Display the student’s state. You must use the explicit join format. 

-- Partial result table (268 rows total)

SELECT s.student_id,
       z.state AS "STATE"
FROM STUDENT.STUDENT s
JOIN student.zipcode z ON s.zip=z.zip
ORDER BY s.STUDENT_ID;

-- 2.    Display the student’s state. You must use the implicit join format. 

-- Partial result table (268 rows total)

SELECT student_id,
       STATE
FROM student.student s,
     student.zipcode z
WHERE s.zip=z.zip
ORDER BY student_id;

-- 3.    Display the student’s city and state. You must use the explicit join format. 

-- Partial result table (268 rows total)

SELECT s.student_id,
       z.city || ', '|| z.state AS "City, State"
FROM STUDENT.STUDENT s
JOIN student.zipcode z ON s.zip=z.zip
ORDER BY s.STUDENT_ID;



-- *** Use EXPLICIT format whenever joining tables for all remaining problems ***

-- 4.    (Instructor table and Section table) Use the MINUS operator to determine if any instructors are 
--         not currently teaching any sections. Display the following result table. No points will be given if 
--         the MINUS operator is not used. 

-- https://community.oracle.com/thread/2176544?tstart=0
-- http://www.techonthenet.com/sql/minus.php

-- Preliminary logic:

-- SELECT i.instructor_id,
-- s.instructor_id AS "Instructor Not Teaching"
-- FROM STUDENT.INSTRUCTOR i
-- join STUDENT.SECTION s on i.INSTRUCTOR_ID=s.instructor_id;

-- SELECT i.INSTRUCTOR_ID
-- FROM STUDENT.INSTRUCTOR i MINUS
-- SELECT s.INSTRUCTOR_ID
-- FROM student.section s
-- JOIN STUDENT.INSTRUCTOR i ON i.instructor_id=s.instructor_id;

SELECT i.INSTRUCTOR_ID AS "Instructors Not Teaching"
FROM STUDENT.INSTRUCTOR i MINUS
SELECT s.INSTRUCTOR_ID
FROM student.section s
JOIN STUDENT.INSTRUCTOR i ON i.instructor_id=s.instructor_id
ORDER BY "Instructors Not Teaching" DESC;


 
-- 5.    Display the following result table. 

-- Logic

-- SELECT d.DESCRIPTION, 
-- r.course_no,
-- TO_CHAR(r.revenue, '$999,999.99') AS "Total Revenue"
-- FROM student.course d
-- JOIN student.course_revenue r ON d.course_no=r.course_no;


-- SELECT d.DESCRIPTION, 
-- r.course_no,
-- TO_CHAR(r.revenue, '$999,999.99') AS "Total Revenue"
-- FROM student.course d
-- JOIN student.course_revenue r ON d.course_no=r.course_no
-- ORDER BY r.revenue;


-- SELECT d.DESCRIPTION, 
-- r.course_no,
-- TO_CHAR(r.revenue, '$999,999.99') AS "Total Revenue",
-- ROUND(r.revenue/r.NUM_OF_SECTIONS, 2) AS "Revenue per section taught"
-- FROM student.course d
-- JOIN student.course_revenue r ON d.course_no=r.course_no
-- ORDER BY r.revenue DESC;

-- -- OH, dang num of sections was included on same table!
-- SELECT distinct course_no, COUNT(section_no) AS "Section No Count"
-- FROM student.section
-- GROUP BY course_no
-- ORDER BY course_no ASC;

SELECT d.DESCRIPTION, 
TO_CHAR(r.revenue, '$999,999') AS "Total Revenue",
TO_CHAR(ROUND(r.revenue/r.NUM_OF_SECTIONS, 2),'$999,999.99') AS "Revenue per section taught"
FROM student.course d
JOIN student.course_revenue r ON d.course_no=r.course_no
ORDER BY "Revenue per section taught" DESC;

-- 6.     Create the following result table.

-- Logic

-- select i.instructor_id, 
--        i.first_name, 
--        i.last_name, 
--        is.NUM_OF_CLASSES, 
--        is.NUM_OF_STUDENTS,
-- FROM student.instructor i 
-- JOIN STUDENT.INSTRUCTOR_SUMMARY is ON i.instructor_id=is.instructor_id;

-- WELLP, don't use 'is' as a prefix

-- SELECT i.instructor_id,
--        i.first_name,
--        i.last_name,
--        ip.NUM_OF_CLASSES,
--        ip.NUM_OF_STUDENTS
-- FROM student.instructor i
-- JOIN student.instructor_summary ip ON i.instructor_id=ip.INSTRUCTOR_ID;


-- SELECT i.instructor_id,
--        i.first_name,
--        i.last_name,
--        ip.NUM_OF_CLASSES,
--        ip.NUM_OF_STUDENTS
-- FROM student.instructor i
-- JOIN student.instructor_summary ip ON i.instructor_id=ip.INSTRUCTOR_ID
-- ORDER BY ip.num_of_classes DESC,
--          ip.NUM_OF_STUDENTS DESC;

SELECT i.instructor_id,
       i.first_name,
       i.last_name,
       ip.NUM_OF_CLASSES,
       ip.NUM_OF_STUDENTS
FROM student.instructor i
JOIN student.instructor_summary ip ON i.instructor_id=ip.INSTRUCTOR_ID
WHERE ip.NUM_OF_CLASSES > 0
ORDER BY ip.num_of_classes DESC,
         ip.NUM_OF_STUDENTS DESC;
  
-- 7.    What is the average numeric grade for all grade types? Display the following result table.  


-- select gt.grade_type_code, gt.description
-- from student.grade_type gt;

-- select grade_type_code, numeric_grade
-- from student.grade;


-- select distinct grade_type_code, numeric_grade
-- from student.grade
-- group by grade_type_code, numeric_grade
-- ORDER BY GRADE_TYPE_CODE DESC;


-- select count(grade_type_code), numeric_grade
-- from student.grade
-- group by grade_type_code, numeric_grade
-- ORDER BY GRADE_TYPE_CODE DESC;


-- SELECT grade_type_code,
--        count(grade_type_code),
--        Round(avg(numeric_grade),2)
-- FROM student.grade
-- GROUP BY grade_type_code
-- ORDER BY GRADE_TYPE_CODE;

-- select gt.grade_type_code, gt.description, gg.numeric_grade
-- from student.grade_type gt
-- JOIN student.grade gg ON gt.grade_type_code = gg.GRADE_TYPE_CODE;

-- I'm idiot-I forgot to add additional group_by statement: 
-- http://dba.stackexchange.com/questions/131746/how-to-group-joined-tables-by-aggregate-function-specifically-by-average-group/131753#131753

SELECT gt.grade_type_code,
       gt.description,
       round(avg(gg.numeric_grade),2) AS "AVERAGE GRADE"
FROM student.grade_type gt
JOIN student.grade gg ON gt.grade_type_code = gg.GRADE_TYPE_CODE
GROUP BY gt.grade_type_code,
         gt.description
ORDER BY gt.grade_type_code;



-- 8.    Create the following result table. 

-- http://www.bennadel.com/blog/984-using-nullif-to-prevent-divide-by-zero-errors-in-sql.htm
-- http://www.techonthenet.com/sql_server/functions/nullif.php
-- http://stackoverflow.com/questions/5027808/how-to-avoid-divide-by-zero-error-in-an-sql-query


-- select TO_CHAR(ROUND(revenue/num_enrolled,2),'$999,999.99') AS "Avg Revenue" from student.course_revenue;

-- select TO_CHAR(ROUND(revenue/NULLIF(num_of_students,0)),'$999,999.99') AS "Avg Revenue" from student.instructor_summary WHERE "Avg Revenue" IS NOT NULL;

-- select it.instructor_id FROM STUDENT.INSTRUCTOR it;

-- select ir.revenue, ir.num_of_students FROM STUDENT.INSTRUCTOR_SUMMARY IR;

-- select it.instructor_id, it.last_name, to_char(ir.revenue, '$999,999.00') AS "Revenue Per Student", ir.num_of_students
-- FROM STUDENT.INSTRUCTOR_SUMMARY ir 
-- JOIN student.instructor it ON it.instructor_id=ir.instructor_id;

-- select it.instructor_id, it.last_name, to_char(ir.revenue, '$999,999.00') AS "Revenue Per Student", ir.num_of_students, to_char(ir.revenue/ir.NUM_OF_STUDENTS, '$999,999.00')
-- FROM STUDENT.INSTRUCTOR_SUMMARY ir 
-- JOIN student.instructor it ON it.instructor_id=ir.instructor_id
-- WHERE ir.revenue > 0;

SELECT it.instructor_id,
       it.last_name,
       to_char(ir.revenue/ir.NUM_OF_STUDENTS, '$999,999.00') AS "Revenue Per Student"
FROM STUDENT.INSTRUCTOR_SUMMARY ir
JOIN student.instructor it ON it.instructor_id=ir.instructor_id
WHERE ir.revenue > 0
ORDER BY "Revenue Per Student" DESC;
   
-- **** Use the AP table space for the following questions ****

-- 9.    Display the vendor name for all invoices. 

-- Partial result table (114 rows total)

-- select i.invoice_id from ap.invoices i;

-- select i.vendor_id, v.vendor_name from ap.invoices i
-- JOIN ap.vendors v ON i.vendor_id=v.vendor_id;

SELECT i.invoice_id,
       v.vendor_name
FROM ap.invoices i
JOIN ap.vendors v ON i.vendor_id=v.vendor_id
ORDER BY INVOICE_ID ASC;

-- 10.  Display all the different vendor names as per the following result table. 

-- Partial result table (122 rows total)
-- http://dba.stackexchange.com/questions/131771/why-does-query-only-include-the-output-for-the-first-set-of-column-ids-but-bypa


-- **** FLAG FOR REVIEW** According to StackExchange, there must be an error with this question?  Could you please advise-thank you!

-- Original Answer

SELECT DISTINCT v.vendor_name
FROM ap.invoices i
JOIN ap.vendors v ON i.vendor_id=v.vendor_id
ORDER BY v.vendor_name ASC;

-- Correction

SELECT distinct(vendor_name)
FROM ap.vendors
ORDER BY 1;


-- 11.  Display the vendor name for all invoices. Only include the vendors whose names are between 
--         the letters ‘H’ and ‘M’ inclusive.

-- https://docs.oracle.com/cd/E17952_01/refman-5.5-en/pattern-matching.html
-- https://docs.oracle.com/cd/E17952_01/refman-5.5-en/pattern-matching.html


SELECT v.vendor_name
FROM ap.invoices i
JOIN ap.vendors v ON i.vendor_id=v.vendor_id
WHERE REGEXP_LIKE(v.vendor_name, '^[H-L]');

  

-- 12.  Display the earliest and latest payment dates for all non-null invoices. In addition use the average
--         number of days difference between these two dates to calculate a new date that is exactly 
--         between the earliest and latest payment dates as per the result table.

-- http://www.techonthenet.com/oracle/questions/avg_date.php

-- SELECT min(payment_date) AS "Earliest Payment Date",
--        max(payment_date) AS "Latest Payment Date",
-- FROM ap.invoices;

-- SELECT TO_DATE(min(payment_date), 'yyyy/mm/dd')
-- + ((TO_DATE(max(payment_date), 'yyyy/mm/dd') - TO_DATE(min(payment_date), 'yyyy/mm/dd')) /2 )
-- FROM ap.invoices;

-- SELECT min(payment_date) AS "Earliest Payment Date", max(payment_date) AS "Earliest Payment Date", TO_DATE(min(payment_date), 'yyyy/mm/dd')
-- + ((TO_DATE(max(payment_date), 'yyyy/mm/dd') - TO_DATE(min(payment_date), 'yyyy/mm/dd')) /2 )
-- FROM ap.invoices;

-- SELECT min(payment_date) AS "Earliest Payment Date", max(payment_date) AS "Earliest Payment Date", TO_DATE(min(payment_date), 'DD-MON-YY')
-- + ((TO_DATE(max(payment_date), 'DD-MON-YY') - TO_DATE(min(payment_date), 'DD-MON-YY')) /2 ) AS "Date in Between"
-- FROM ap.invoices;

SELECT min(payment_date) AS "Earliest Payment Date",
       max(payment_date) AS "Earliest Payment Date",
       TO_DATE(min(payment_date), 'DD-MON-YY') + ((TO_DATE(max(payment_date), 'DD-MON-YY') - TO_DATE(min(payment_date), 'DD-MON-YY')) /2) AS "Date in Between"
FROM ap.invoices;

-- 13.  Remove the dashes from the invoice number.

-- Partial result table (114 rows total)

-- http://www.experts-exchange.com/questions/22444006/How-to-remove-dash-from-ssn-using-sql-statement-in-sqlserver.html

-- select invoice_number from ap.invoices;

-- select replace(invoice_number, '-','') from ap.invoices;

-- select replace(invoice_number, '-','') AS "No Dashes" from ap.invoices;

-- select invoice_number, replace(invoice_number, '-','') AS "No Dashes" from ap.invoices;

SELECT invoice_number,
       replace(invoice_number, '-','') AS "No Dashes"
FROM ap.invoices;


-- 14.  Display all vendor names that end in either Inc (no period) or Inc. (with a period). In addition the
--         query must eliminate any vendor names that may start with Inc (no period).

-- Partial result table (15 rows total)

-- http://www.techonthenet.com/oracle/regexp_like.php
-- https://docs.oracle.com/cd/B19306_01/appdev.102/b14251/adfns_regexp.htm
-- https://docs.oracle.com/cd/E17952_01/refman-5.5-en/pattern-matching.html

-- select vendor_name from ap.vendors where regexp_like (v.vendor_name, '(inc)');

-- select vendor_name from ap.vendors where regexp_like (vendor_name, 'inc');

SELECT vendor_name
FROM ap.vendors
WHERE REGEXP_LIKE(vendor_name, 'Inc');

-- 15.  Display each vendor’s complete address. Pay attention to the address for Pacific Bell.  Notice 
--         there are no spaces before this address.

-- http://dba.stackexchange.com/questions/131866/how-to-omit-multiple-columns-where-is-not-null

-- select * from ap.vendors;

-- select vendor_name, vendor_address1 AS "Complete Address" from ap.vendors;

-- SELECT vendor_name,
--        vendor_address1 || '' || vendor_city || ', ' || vendor_state || ' ' || VENDOR_ZIP_CODE AS "Complete Address"
-- FROM ap.vendors;

-- SELECT vendor_name,
--        vendor_address1 || '' || vendor_address2 || '' || vendor_city || ', ' || vendor_state || ' ' || VENDOR_ZIP_CODE AS "Complete Address"
-- FROM ap.vendors
-- WHERE vendor_address1, vendor_address2 IS NOT NULL
-- ORDER BY vendor_name;

-- SELECT vendor_name,
--        vendor_address1 || '' || vendor_address2 || '' || vendor_city || ', ' || vendor_state || ' ' || VENDOR_ZIP_CODE AS "Complete Address"
-- FROM ap.vendors
-- WHERE (vendor_address1 || vendor_address2) IS NOT NULL
-- ORDER BY vendor_name;

-- SELECT vendor_name, vendor_address1 || ' ' || vendor_address2 || ' ' || vendor_city || ', ' || vendor_state || ' ' || VENDOR_ZIP_CODE AS "Complete Address"
-- FROM ap.vendors
-- WHERE (vendor_address1 || vendor_address2 || vendor_city || vendor_state || vendor_zip_code) IS NOT NULL
-- ORDER BY vendor_name;

-- SELECT vendor_name, vendor_address1 || ' ' || vendor_address2 || ' ' || vendor_city || ', ' || vendor_state || ' ' || vendor_zip_code AS "Complete Address"
-- FROM ap.vendors
-- WHERE (vendor_address1 || vendor_address2 || vendor_city || vendor_state || vendor_zip_code) IS NOT NULL
-- ORDER BY vendor_name;


SELECT vendor_name,
       vendor_address1 || ' ' || decode(vendor_address2, 'NULL', null, vendor_address2) || ' ' || vendor_city || ', ' || vendor_state || ' ' || vendor_zip_code AS "Complete Address"
FROM ap.vendors
WHERE (vendor_address1 || vendor_address2 || vendor_city || vendor_state || vendor_zip_code) IS NOT NULL
ORDER BY vendor_name;







  










