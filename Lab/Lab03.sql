-- 1.Lab 3 – SQL
-- Due Thursday February 18th by 6:00pm

-- Each problem is worth one point. No partial credit will be given. This lab is worth a total of 15 points.

-- Use hostname: classdb.jccc.edu

-- From this lab forward, please notice if a result table is in a particular order. If it is you must use the order by clause. Failure to do so will result in 0 points for that specific problem.

-- Place all answers into ONE .sql file. Attach that file to the Dropbox for Lab 3 in D2L. Only one .sql file will be accepted.

-- **** Use the OM table space for the following questions ****

-- >>>>>>>>>>>>>>>>alexanderjsingleton<<<<<<<<<<<<<<<<<<<<<<<<<<<
-- pretty-print brought to you by http://sqlformat.org/
-- CONTROL + A is short-cut on OS X


-- 1.     Display customer’s last name in alphabetical order. Use the Customers table.

--   Partial result table (25 rows total)

SELECT customer_last_name,
       customer_first_name
FROM OM.CUSTOMERS
ORDER BY customer_last_name;
 

-- 2.     Display customer’s last name in descending order. Use the Customers table.
-- Partial result table (25 rows total)
  
SELECT customer_last_name,
       customer_first_name
FROM OM.CUSTOMERS
ORDER BY customer_last_name DESC;


-- 3.    Display customer’s last name in ascending order and their first name in descending order. 
--         Use the Customers table.
-- Partial result table (25 rows total)

SELECT customer_last_name,
       customer_first_name
FROM OM.CUSTOMERS
ORDER BY customer_last_name ASC,
         customer_first_name DESC;

-- 4.    Display customer’s last name in descending order using a column number. Use the 
--         Customers table.
-- Partial result table (25 rows total)


SELECT customer_last_name,
       customer_first_name
FROM OM.CUSTOMERS
ORDER BY 1 DESC;


-- 5.    Create the following result table exactly. Notice the column names. Use the Customers 
--         table.
--   Partial result table (25 rows total)

SELECT customer_first_name AS FIRSTNAME,
       customer_last_name AS "Last Name",
       customer_city AS "'City'",
       CUSTOMER_STATE AS "*Cust-State*"
FROM om.customers;
  
-- 6.    Display each state only once. Use the Customers table.
-- http://docs.oracle.com/cd/B28359_01/server.111/b28286/statements_10002.htm#sthref9346
-- http://stackoverflow.com/questions/6772451/difference-between-select-distinct-and-select-unique
-- http://stackoverflow.com/questions/5391564/how-to-use-distinct-and-order-by-in-same-select-statement
  
SELECT UNIQUE CUSTOMER_STATE
FROM om.customers
ORDER BY CUSTOMER_STATE;

-- 7.    Display each fax number value only once. Use the Customers table.

SELECT DISTINCT customer_fax
FROM om.customers
ORDER BY customer_fax DESC;
  
-- 8.    Display the first 4 rows only in the customers table. Use the Customers table.
-- http://www.w3schools.com/sql/sql_top.asp

SELECT *
FROM om.customers
WHERE ROWNUM <=4;
  
-- 9.    Display any song titles that contain the word “road”. Use the Items table.
-- https://docs.oracle.com/cd/B12037_01/server.101/b10759/conditions018.htm
-- https://docs.oracle.com/cd/B12037_01/appdev.101/b10795/adfns_re.htm
-- https://docs.oracle.com/cd/B19306_01/server.102/b14200/conditions007.htm
-- https://docs.oracle.com/cd/B12037_01/server.101/b10759/conditions018.htm
-- http://www.techonthenet.com/oracle/regexp_like.php
-- http://regexr.com/
-- https://gist.github.com/alexanderjsingleton/49cdcad68fe12c8dfc02

SELECT title
FROM om.items
WHERE REGEXP_LIKE (title, 'road', 'i');
  
-- 10.    Display any song titles that have a decimal point in the unit price of that song. Use the 
--           Items table.c
-- http://stackoverflow.com/questions/31883879/how-do-you-write-a-sql-query-to-find-all-the-rows-that-has-a-float-currency-valu
-- http://stackoverflow.com/questions/14906251/sql-order-by-wildcard
-- https://docs.oracle.com/cd/B19306_01/server.102/b14200/conditions007.htm
-- http://www.techonthenet.com/oracle/regexp_like.php

SELECT title,
       unit_price
FROM om.items
WHERE unit_price LIKE '%.%'
ORDER BY unit_price DESC,
         title DESC;
  
-- 11.    Display any song titles that do not have a decimal point in the unit price of that song. 
--           Use the Items table.

SELECT title,
       unit_price
FROM om.items
WHERE unit_price NOT LIKE '%.%'
ORDER BY unit_price ASC,
         title DESC;

-- 12.    Display all orders that have at least an order quantity of 2. Use the Order_Details table.

SELECT order_id,
       order_qty
FROM om.order_details
WHERE order_qty >=2
ORDER BY order_id;
  
-- 13.    Display all order id’s divisible by 13. Use the Order_Details table.
-- http://stackoverflow.com/questions/3756928/select-row-if-the-value-2-1-mod

SELECT order_id
FROM om.order_details
WHERE MOD(order_id,13) = 0;
  
-- 14.    Display all orders with no shipped date. Use the Orders table.
-- http://www.w3schools.com/sql/sql_null_values.asp

SELECT order_id,
       shipped_date
FROM om.orders
WHERE shipped_date IS NULL;
  
-- 15.    Display the number of days from when the order was received to when the order was
--           shipped. Only include at least 25 days and above in your result table. Use the Orders 
--           table.
-- http://stackoverflow.com/questions/17944104/change-column-name-in-oracle-in-select-statement
-- SELECT (shipped_date - order_date) AS "Number of Days" FROM om.orders;
-- https://books.google.com/books?id=QXzYAwAAQBAJ&pg=PA138&lpg=PA138&dq=sql,+select+the+number+of+days+from+when+order+to+ship&source=bl&ots=lfFWZjQAJm&sig=r7mCjGpVqFFloNRfCZ0xw2fqNBQ&hl=en&sa=X&ved=0ahUKEwjq0MX6jP3KAhUGyYMKHR3HAJoQ6AEIKTAC#v=onepage&q=sql%2C%20select%20the%20number%20of%20days%20from%20when%20order%20to%20ship&f=false
--  SELECT order_date, shipped_date, CAST(shipped_date - order_date > 25 AS INTEGER) AS DaysToShip from om.orders; 

-- SELECT (shipped_date - order_date) AS DaysElapsed FROM om.orders WHERE DaysElapsed > 25;

-- http://dba.stackexchange.com/questions/129458/how-to-display-the-number-of-days-elapsed-between-two-dates-denoted-in-columns-s

SELECT order_id,
       (shipped_date - order_date) AS "Number of Days elapsed"
FROM om.orders
WHERE shipped_date - order_date > 30
ORDER BY (shipped_date - order_date) DESC;

-- Alternatives below:

SELECT order_id, "Number of Days elapsed"
  FROM (SELECT order_id,
               (shipped_date - order_date) AS "Number of Days elapsed"
          FROM om.orders)
 WHERE "Number of Days elapsed" > 30
 ORDER BY "Number of Days elapsed" desc

 SELECT order_id, days_elapsed "Number of Days elapsed"
  FROM (SELECT order_id,
               (shipped_date - order_date) days_elapsed
          FROM om.orders)
 WHERE days_elapsed > 30
 ORDER BY days_elapsed  desc

