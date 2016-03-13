-- Lab 6 – SQL
-- March 3, 2016

-- Each problem is worth one point. No partial credit will be given. This lab is worth a total of 20 points.

-- Use hostname: classdb.jccc.edu

-- From this lab forward, please notice if a result table is in a particular order. If it is you must use the order by clause. Failure to do so will result in 0 points for that specific problem.

-- Place all answers into ONE .sql file. Attach that file to the Dropbox for Lab 6 in D2L. Only one .sql file will be accepted.

-- **** Use the AP table space for the following questions ****

-- 1.    Display the number of rows in the Invoice table.

-- http://www.w3schools.com/sql/sql_func_count.asp

SELECT COUNT(*) AS "Number of Invoices"
FROM ap.invoices;
  

-- 2.    Display the number of non-null values of payment_date. Use the Invoice table.

-- http://www.w3schools.com/sql/sql_func_count.asp

SELECT COUNT(payment_date) AS "Number of Valid Payment Dates"
FROM ap.invoices
WHERE payment_date IS NOT NULL;


-- 3.    Display the number of null values of payment_date. Use the Invoice table.

-- Page 163 from textbook.
-- http://ss64.com/ora/syntax-is-not-null.html
-- http://docs.oracle.com/cd/B19306_01/server.102/b14200/functions032.htm
-- SUM([ALL|DISTINCT] EXPRESSION)
-- MIN([ALL|DISTINCT] EXPRESSION)
-- MAX([ALL|DISTINCT] EXPRESSION)
-- COUNT([ALL|DISTINCT] EXPRESSION)
-- COUNT(*)

SELECT COUNT(DISTINCT payment_date) AS "Number of Valid Payment Dates"
FROM ap.invoices
WHERE payment_date IS NOT NULL;

-- 4.    Display all of the different payment_dates. Use the Invoice table.

-- Partial Result Table (41 rows total)
-- http://www.tutorialspoint.com/sql/sql-syntax.htm
-- http://www.w3schools.com/sql/sql_distinct.asp
-- FLAG FOR REVIEW: Question requires 41 but my correct-query only displays 40?
  
SELECT DISTINCT payment_date AS "Different Payment Dates"
FROM ap.invoices
WHERE payment_date IS NOT NULL
ORDER BY payment_date;

-- 5.    Display the number of different payment_dates. Use the Invoice table.


SELECT COUNT(DISTINCT payment_date) AS "Number of Diff. Payment Dates"
FROM ap.invoices

-- 6.    Display the total amount of the invoices. Use the Invoice table.
SELECT SUM(invoice_total) AS "Total Invoice Amount" FROM ap.invoices;
  

-- 7.    Display the average amount of the invoice totals. Use the Invoice table.

-- I'm also an idiot: http://dba.stackexchange.com/questions/131087/how-to-convert-the-column-sum-function-total-to-dollars-in-oracle-sql

SELECT to_char(sum(invoice_total),'$999,999.99') AS "Total Invoice Amount"
FROM ap.invoices;

-- NOTES
-- SELECT to_char(sum(invoice_total)) AS "Total Invoice Amount" from ap.invoices;

-- SELECT TO_CHAR(invoice_total, '$999,999.99') FROM ap.invoices;
-- SUM(invoice_total) AS "Total Invoice Amount" from ap.invoices;

-- 8.    Display the average amount of the invoice totals. Use the Invoice table.

-- http://stackoverflow.com/questions/12565790/selecting-both-min-and-max-from-the-table-is-slower-than-expected

SELECT ROUND(AVG(invoice_total),3) AS "Average Invoice Amount"
FROM ap.invoices;

-- 9.    Display the lowest and highest invoice total. Use the Invoice table.

SELECT MIN(invoice_total) AS "Lowest Invoice Total",
       MAX(invoice_total) AS "Highest Invoice Total"
FROM ap.invoices; 

-- 10.  Display the lowest and highest invoice total. Use the Invoice table.

SELECT TO_CHAR(MIN(invoice_total),'$999,999.99') AS "Lowest Invoice Total",
       TO_CHAR(MAX(invoice_total),'$999,999.99') AS "Highest Invoice Total"
FROM ap.invoices; 

-- 11.  Display the last vendor in the alphabetic sort sequence. Use the Vendor table.

SELECT MAX(vendor_name) AS "Last Vendor"
FROM ap.vendors;

-- 12.  Display the earliest invoice date. Use the Invoices table.

SELECT MIN(invoice_date) AS "Earliest Invoice Date"
FROM ap.invoices;
  
-- 13.  Display the number of invoices by date. Use the Invoices table.
-- Partial Result Table (49 rows total)

-- Syntax referenced on page 11 of Chapter 5 slides:

SELECT invoice_date,
       COUNT(*) AS "Invoices per Date"
FROM ap.invoices
GROUP BY invoice_date
ORDER BY invoice_date;

-- 14.  Display the number of invoice totals that are less than $10.00. Use the Invoices table.

-- Consulted page 165 of texbook.

SELECT INVOICE_TOTAL,
       COUNT(*) AS "Invoices Less than $10.00"
FROM ap.invoices
WHERE invoice_total < 10
GROUP BY INVOICE_TOTAL
ORDER BY INVOICE_TOTAL;

-- 15.  Display the number of vendors in each state. Use the Vendors table.

-- Partial Result Table (22 rows total)

SELECT vendor_state,
       COUNT(*) AS "Vendors per State"
FROM ap.vendors
GROUP BY vendor_state
ORDER BY vendor_state;

-- 16.  Display the number of vendors in each state only if there are at least 3 vendors in that 
--         particular state. Use the Vendors table.

-- http://stackoverflow.com/questions/2068682/why-cant-i-use-alias-in-a-count-column-and-reference-it-in-a-having-clause
-- https://community.oracle.com/thread/698866?start=0&tstart=0

SELECT vendor_state,
       COUNT(*) AS "Vendors per State"
FROM ap.vendors
GROUP BY vendor_state
HAVING COUNT(*) >= 3
ORDER BY COUNT(*) DESC;

-- 17.  Display the number in each terms id category. Use the Invoices table.

SELECT TERMS_ID,
       COUNT(*) AS "Number in Terms Id Category"
FROM ap.invoices
GROUP BY TERMS_ID
ORDER BY TERMS_ID;

-- 18.  Display the number of invoices in June 2008.You must use a WHERE clause (no HAVING 
--         clause) to receive credit. Use the Invoices table.

-- http://www.techonthenet.com/oracle/between.php

SELECT invoice_date,
       COUNT(*) AS "Invoices in June, 2008"
FROM ap.invoices
WHERE invoice_date >= '01-JUN-08'
  AND invoice_date < '01-JUL-08'
GROUP BY invoice_date
ORDER BY invoice_date ASC;
 
-- 19.  Display the number of invoices in June 2008.You must use a HAVING clause (no WHERE 
--         clause) to receive credit. Use the Invoices table.

SELECT invoice_date,
       COUNT(*) AS "Invoices in June 2008"
FROM ap.invoices
GROUP BY invoice_date
HAVING invoice_date >= '01-JUN-08'
AND invoice_date < '01-JUL-08'
ORDER BY invoice_date ASC;

-- 20.  Display the number of invoices that have the same number of days between when the
--         invoice was created and when it is due. Use the Invoices table.

--   Partial Result Table (51 rows total)

-- http://dba.stackexchange.com/questions/131218/how-to-total-additional-results-from-alias-column-results-in-oracle-sql/131222#131222

SELECT INVOICE_DUE_DATE - INVOICE_DATE AS "Difference in Days",
       COUNT(INVOICE_DUE_DATE - INVOICE_DATE) AS "How Many?"
FROM ap.invoices
GROUP BY INVOICE_DUE_DATE - INVOICE_DATE
ORDER BY INVOICE_DUE_DATE - INVOICE_DATE DESC;




















  


