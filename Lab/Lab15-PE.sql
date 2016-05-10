CREATE TABLE Lines (line_id NUMBER(7) NOT NULL, 
order_id NUMBER(7) NOT NULL,
product_id varchar2(30) NOT NULL,
ordered_quantity varchar2(18) NOT NULL,
CONSTRAINT lines_id_pk PRIMARY KEY(order_id),
CONSTRAINT lines_fk_orders FOREIGN KEY (order_id) REFERENCES lines (order_id));


CREATE TABLE customers (CUSTOMER_ID NUMBER(7) NOT NULL, 
  CUSTOMER_NAME VARCHAR(30) NOT NULL, 
  CUSTOMER_Address VARCHAR(60) NOT NULL, 
  City VARCHAR(30) NOT NULL, 
  STATE CHAR(2) NOT NULL, 
  Postal_Code VARCHAR(10) NOT NULL, 
  CONSTRAINT customer_id_pk PRIMARY KEY(CUSTOMER_ID));



CREATE TABLE Product (product_id NUMBER(7) NOT NULL, 
  product_description CLOB NOT NULL, 
  product_finish CHAR(30) NOT NULL, 
  standard_price NUMBER(8,2) NOT NULL, 
  Product_Line_ID varchar2(30) NOT NULL, 
  CONSTRAINT product_product_id_pk PRIMARY KEY(product_id), 
  CONSTRAINT product_fk_lines FOREIGN KEY (product_id) REFERENCES Product (product_id));





-- Should we enter piecemeal or just proceed with copy/paste below entirely in sequence?

CREATE TABLE regions (
REGION_ID NUMBER NOT NULL,
REGION_NAME VARCHAR2(25),
CONSTRAINT reg_id_pk PRIMARY KEY(REGION_ID)
);

CREATE TABLE countries (
country_id CHAR(2) NOT NULL,
country_name VARCHAR2(40),
region_id NUMBER,
CONSTRAINT country_c_id_pk PRIMARY KEY(COUNTRY_ID),
CONSTRAINT countries_reg_fk FOREIGN KEY (region_id) REFERENCES regions (region_id) 
);

CREATE TABLE locations (
location_id NUMBER(4) NOT NULL,
street_address VARCHAR2(40),
postal_code VARCHAR2(12),
city VARCHAR2(30) NOT NULL,
state_province VARCHAR2(25),
country_id CHAR(2),
CONSTRAINT LOC_ID_PK PRIMARY KEY (LOCATION_ID),
CONSTRAINT LOC_C_ID_FK FOREIGN KEY (country_id) REFERENCES countries (country_id)
);

CREATE TABLE departments (
department_id NUMBER(4) NOT NULL,
department_name VARCHAR2(30) NOT NULL,
manager_id NUMBER(6),
location_id NUMBER(4),
CONSTRAINT DEPT_ID_PK PRIMARY KEY (DEPARTMENT_ID),
-- what about the mangers foreign key?
CONSTRAINT DEPT_LOC_FK FOREIGN KEY (location_id) REFERENCES locations (location_id)
);




INSERT INTO regions (region_id, region_name) VALUES (1,'Europe');
INSERT INTO regions (region_id, region_name) VALUES (2,'Americas');
INSERT INTO regions (region_id, region_name) VALUES (3,'Asia');
INSERT INTO regions (region_id, region_name) VALUES (4,'Middle East and Africa');

-- PART B Copy and paste and run the following SQL as a script in SQL Developer to INSERT the following 
-- records



INSERT INTO countries VALUES 
   ( 'IT'
   , 'Italy'
   , 1 
   );
INSERT INTO countries VALUES 
   ( 'JP'
   , 'Japan'
   , 3 
   );
INSERT INTO countries VALUES 
   ( 'US'
   , 'United States of America'
   , 2 
   );
INSERT INTO countries VALUES 
   ( 'CA'
   , 'Canada'
   , 2 
   );
INSERT INTO countries VALUES 
   ( 'CN'
   , 'China'
   , 3 
   );
INSERT INTO countries VALUES 
   ( 'IN'
   , 'India'
   , 3 
   );
INSERT INTO countries VALUES 
   ( 'AU'
   , 'Australia'
   , 3 
   );
INSERT INTO countries VALUES 
   ( 'ZW'
   , 'Zimbabwe'
   , 4 
   );
INSERT INTO countries VALUES 
   ( 'SG'
   , 'Singapore'
   , 3 
   );
INSERT INTO countries VALUES 
   ( 'UK'
   , 'United Kingdom'
   , 1 
   );
INSERT INTO countries VALUES 
   ( 'FR'
   , 'France'
   , 1 
   );
INSERT INTO countries VALUES 
   ( 'DE'
   , 'Germany'
   , 1 
   );
INSERT INTO countries VALUES 
   ( 'ZM'
   , 'Zambia'
   , 4 
   );
INSERT INTO countries VALUES 
   ( 'EG'
   , 'Egypt'
   , 4 
   );
INSERT INTO countries VALUES 
   ( 'BR'
   , 'Brazil'
   , 2 
   );
INSERT INTO countries VALUES 
   ( 'CH'
   , 'Switzerland'
   , 1 
   );
INSERT INTO countries VALUES 
   ( 'NL'
   , 'Netherlands'
   , 1 
   );
INSERT INTO countries VALUES 
   ( 'MX'
   , 'Mexico'
   , 2 
   );
INSERT INTO countries VALUES 
   ( 'KW'
   , 'Kuwait'
   , 4 
   );
INSERT INTO countries VALUES 
   ( 'IL'
   , 'Israel'
   , 4 
   );
INSERT INTO countries VALUES 
   ( 'DK'
   , 'Denmark'
   , 1 
   );
INSERT INTO countries VALUES 
   ( 'HK'
   , 'HongKong'
   , 3 
   );
INSERT INTO countries VALUES 
   ( 'NG'
   , 'Nigeria'
   , 4 
   );
INSERT INTO countries VALUES 
   ( 'AR'
   , 'Argentina'
   , 2 
   );
INSERT INTO countries VALUES 
   ( 'BE'
   , 'Belgium'
   , 1  
   );

-- Part C Using the SQL Developer Import Wizard, import the two .csv files for the LOCATIONS and  DEPARTMENTS tables. These have been tested and should import 
-- ‘cleanly’ and without errors

   -- Import table data => http://www.thatjeffsmith.com/archive/2012/04/how-to-import-from-excel-to-oracle-with-sql-developer/

  
-- STEP 3 The HR Department would like access to a quick “view” of the location_id, city, state, and country_name 
-- a specific location is in. Create a VIEW that will display: location_id, city, state, and country_name. 
-- The column appearance for STATE_PROVINCE should appear as “STATE”, and the column appearance COUNTRY_NAME 
-- should appear as “COUNTRY”.



  -- CREATE VIEW vendors_sw AS
  --  SELECT *
  --  FROM vendors
  --  WHERE vendor_state IN ('CA','AZ','NV','NM')

  --  CREATE VIEW hr_dept AS
  --  SELECT * 
  --  FROM 

-- CREATE VIEW hr_department AS
-- SELECT location_id, city, state_province AS "State", country_name AS "Country"
-- FROM locations l,
--      countries c
-- WHERE l.country_id=c.country_id
-- ORDER BY student_id;


create view hr_dept as (
SELECT location_id, city, state_province AS "State", country_name AS "Country"
FROM locations l,
     countries c
WHERE l.country_id=c.country_id);


-- Exactly Correct answer:
-- SELECT l.location_id, l.city, l.state_province, c.country_name
-- From locations l join countries c on l.country_id=c.country_id;
-- create view v_locations as (SELECT l.location_id, l.city, l.state_province AS STATE, c.country_name AS COUNTRY
-- From locations l join countries c on l.country_id=c.country_id);


-- STEP IV Senior management would like an “easy button” located on their front-end application dashboard 
-- that when clicked will display the following information:
-- “Location ID: location_id is located in city and in the state of state_province”

-- You must write a PL/SQL script that uses three declared variables. Using a CURSOR, the script will display all rows 
-- found in the result set




SET SERVEROUTPUT ON;

DECLARE
v_loc_city locations.city%type;
v_loc_state locations.state_province%type;
v_loc_id LOCATIONS.LOCATION_ID%type;

CURSOR location_cursor is
  SELECT location_id,city, state_province from locations;

BEGIN
  OPEN location_cursor;
  LOOP
  FETCH location_cursor into v_loc_id, v_loc_city, v_loc_state;
  EXIT WHEN location_cursor%notfound;
     dbms_output.put_line('Location ID: ' || v_loc_id|| ' is located in ' || v_loc_city || ' and in the state of ' || v_loc_state);
   END LOOP;
   CLOSE location_cursor;
END;



