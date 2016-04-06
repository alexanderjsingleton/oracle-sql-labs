-- Links:
-- http://www.java2s.com/Code/Oracle/Table/CreatetablewithdatatypeVARCHAR2DateNumber82.htm

-- http://www.w3schools.com/sql/sql_foreignkey.asp

-- How to drop a table in Oracle SQL=>DROP TABLE Customer;
-- http://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_9003.htm
-- DROP TABLE HR_JOBHX;

-- Rename a table:

-- RENAME TABLE table-Name TO new-Table-Name
-- RENAME LINES TO "Order Lines";

-- RENAME "Order Lines" TO LINES;

-- http://www.w3schools.com/sql/sql_datatypes.asp

-- http://www.thatjeffsmith.com/archive/2012/11/keyboard-shortcuts-in-oracle-sql-developer/

-- http://docs.oracle.com/cd/B19306_01/server.102/b14200/statements_10007.htm

-- http://www.techonthenet.com/sql/update.php



-- 1.) 

CREATE TABLE customers (CUSTOMER_ID NUMBER(7) NOT NULL, CUSTOMER_NAME VARCHAR(30) NOT NULL, CUSTOMER_Address VARCHAR(60) NOT NULL, City VARCHAR(30) NOT NULL, STATE CHAR(2) NOT NULL, Postal_Code VARCHAR(10) NOT NULL, CONSTRAINT customer_id_pk PRIMARY KEY(CUSTOMER_ID));



http://www.w3schools.com/sql/sql_foreignkey.asp

-- 2.)

CREATE TABLE Orders (order_id NUMBER(7) NOT NULL, 
Order_Date DATE NOT NULL, 
CONSTRAINT order_id_pk PRIMARY KEY(order_id),
CONSTRAINT orders_fk_customers FOREIGN KEY (order_id) REFERENCES customers (customer_id));



-- 3.)

CREATE TABLE Lines (line_id NUMBER(7) NOT NULL, 
order_id NUMBER(7) NOT NULL,
product_id varchar2(30) NOT NULL,
ordered_quantity varchar2(18) NOT NULL,
CONSTRAINT lines_id_pk PRIMARY KEY(order_id),
CONSTRAINT lines_fk_orders FOREIGN KEY (order_id) REFERENCES lines (order_id));

-- 4.)

CREATE TABLE Product (product_id NUMBER(7) NOT NULL, product_description CLOB NOT NULL, product_finish CHAR(30) NOT NULL, standard_price NUMBER(8,2) NOT NULL, Product_Line_ID varchar2(30) NOT NULL, CONSTRAINT product_product_id_pk PRIMARY KEY(product_id), CONSTRAINT product_fk_lines
                      FOREIGN KEY (product_id) REFERENCES Product (product_id));


-- 5.)

-- Lines Table

INSERT INTO LINES (ORDER_ID, PRODUCT_ID, ORDERED_QUANTITY) VALUES (100.0,'4000','1');
--Row 2
INSERT INTO LINES (ORDER_ID, PRODUCT_ID, ORDERED_QUANTITY) VALUES (101.0,'1000','2');
--Row 3
INSERT INTO LINES (ORDER_ID, PRODUCT_ID, ORDERED_QUANTITY) VALUES (101.0,'2000','2');
--Row 4
INSERT INTO LINES (ORDER_ID, PRODUCT_ID, ORDERED_QUANTITY) VALUES (102.0,'3000','1');
--Row 5
INSERT INTO LINES (ORDER_ID, PRODUCT_ID, ORDERED_QUANTITY) VALUES (102.0,'2000','1');
--Row 6
INSERT INTO LINES (ORDER_ID, PRODUCT_ID, ORDERED_QUANTITY) VALUES (103.0,'4001','1');
--Row 7
INSERT INTO LINES (ORDER_ID, PRODUCT_ID, ORDERED_QUANTITY) VALUES (104.0,'2000','1');
--Row 8
INSERT INTO LINES (ORDER_ID, PRODUCT_ID, ORDERED_QUANTITY) VALUES (105.0,'3001','2');
--Row 9
INSERT INTO LINES (ORDER_ID, PRODUCT_ID, ORDERED_QUANTITY) VALUES (106.0,'3000','1');
--Row 10
INSERT INTO LINES (ORDER_ID, PRODUCT_ID, ORDERED_QUANTITY) VALUES (106.0,'4000','1');
--Row 11
INSERT INTO LINES (ORDER_ID, PRODUCT_ID, ORDERED_QUANTITY) VALUES (107.0,'4001','1');

-- Need to re-ingest

TRUNCATE TABLE LINES; 

alter table
lines
modify
(
ORDERED_QUANTITY NUMBER(7)
);

#3

-- 1.) 
-- Select * From product;

Select product_id, PRODUCT_FINISH From product;

-- 2.) 

Select product_id, PRODUCT_FINISH From product
ORDER BY product_id ASC;

-- 3.) 

Select product_id, PRODUCT_FINISH From product
ORDER BY product_id DESC;

-- 4.) 

SELECT product_line_id,
       COUNT(*) "Count of Products"
FROM PRODUCT
GROUP BY product_line_id;

-- 5.) 

SELECT product_id,
       product_description
FROM product
WHERE product_description LIKE '%Table%';

-- 6.) 

UPDATE product
SET PRODUCT_DESCRIPTION = 'Duplex Table Lamp'
WHERE PRODUCT_DESCRIPTION = 'Arch Table Lamp';

-- 7.)

SELECT ORDER_DATE, 
COUNT(*) "Number of Products Ordered by Day"
FROM ORDERS
GROUP BY ORDER_DATE;

-- 1.) 
-- http://www.techonthenet.com/sql/tables/alter_table.php

ALTER TABLE customers
ADD Region varchar2(20) NOT NULL;


-- 2.) 

TRUNCATE TABLE CUSTOMERS

ALTER TABLE customers
ADD Region varchar2(20) NOT NULL;

-- 3.) 

CREATE TABLE customers (CUSTOMER_ID NUMBER(7) NOT NULL, 
  CUSTOMER_NAME VARCHAR(30) NOT NULL, 
  CUSTOMER_Address VARCHAR(60) NOT NULL, 
  City VARCHAR(30) NOT NULL, 
  STATE CHAR(2) NOT NULL, 
  Postal_Code VARCHAR(10) NOT NULL,
  REGION VARCHAR2(2) NOT NULL, 
  CONSTRAINT customer_id_pk PRIMARY KEY(CUSTOMER_ID));






