-- Problem 1 (3 pts)
-- Create a numeric variable named num with a value of 10.
-- http://www.oracle.com/technetwork/issue-archive/2011/11-nov/o61plsql-512011.html
-- http://oracle.ittoolbox.com/groups/technical-functional/oracle-dev-l/plsql-procedure-successfully-completed-but-not-able-to-view-the-data-3046668
-- http://stackoverflow.com/questions/14803195/plsql-anonymous-block-complete
-- http://www.thatjeffsmith.com/archive/2012/11/keyboard-shortcuts-in-oracle-sql-developer/

-- http://dba.stackexchange.com/questions/137539/how-to-declare-reserved-words-as-variables-in-oracle-pl-sql/137541#137541

-- SET SERVEROUPUT ON;
-- SET VERIFY OFF;
-- DECLARE
--    tiny_nbr NUMBER := 1e-130;
--    test_nbr INTEGER := 10;

--    --                              1111111111222222222233333333334
--    --                     1234567890123456789012345678901234567890
--    big_nbr      NUMBER := 9.999999999999999999999999999999999999999e125;

--    --                                 1111111111222222222233333333334444444
--    --                        1234567890123456789012345678901234567890123456
--    fmt_nbr VARCHAR2(50) := '9.99999999999999999999999999999999999999999EEEE';
-- BEGIN
--    DBMS_OUTPUT.PUT_LINE(
--       'tiny_nbr          =' || TO_CHAR(tiny_nbr, '9.9999EEEE'));
   
--    /* NUMBERs that are too small round down to zero. */
--    test_nbr := tiny_nbr / 1.0001;
--    DBMS_OUTPUT.PUT_LINE(
--       'tiny made smaller =' || TO_CHAR(test_nbr, fmt_nbr));

--    /* NUMBERs that are too large throw an error: */
--    DBMS_OUTPUT.PUT_LINE(
--       'big_nbr           =' || TO_CHAR(big_nbr, fmt_nbr));
--    test_nbr := big_nbr * 1.0001;        -- too big
--    DBMS_OUTPUT.PUT_LINE(
--       'The value of num is   =' || TO_CHAR(test_nbr, '10'));
-- END;
-- /

-- SET SERVEROUTPUT ON;
-- DECLARE
-- a INTEGER :=10;
-- b INTEGER :=20;
-- c float ;

-- d real ;
-- BEGIN
-- c :=a+b;
-- dbms_output.put_line('the value of C is :'|| c);
-- d := 70.0/3.3;
-- dbms_output.put_line('the value of d is:'|| d);
-- END;
-- /


-- SET SERVEROUTPUT ON
-- declare
--   v_testnum number;
--   v_teststring varchar2(1000);

-- begin
--    v_testnum := 2;
--    DBMS_OUTPUT.put_line('v_testnum is now ' || v_testnum);

--    select 36,'hello world'
--    INTO v_testnum, v_teststring
--    from dual;

--    DBMS_OUTPUT.put_line('v_testnum is now ' || v_testnum);
--    DBMS_OUTPUT.put_line('v_teststring is ' || v_teststring);
-- end;


SET SERVEROUTPUT ON
declare
  num number;
begin
   num := 10;
   DBMS_OUTPUT.put_line('The value of num ' || num); 
end;


-- 2. Display the number of students in the student.student table.

SET SERVEROUTPUT ON
declare
  num number;
begin
   SELECT count(*) INTO num
   FROM student.student;
   DBMS_OUTPUT.put_line('The number of students in the table is ' || num ||'.'); 
end;


-- 3.Write a query to display the salary and title for Stella
-- Use the student.employee table
-- You must define the necessary variable utilizing the %TYPE keyword 

-- http://stackoverflow.com/questions/17501909/type-keyword-help-me-in-interpreting-this-code-in-plsql

-- SET SERVEROUTPUT ON
-- declare
--   min_invoice_total .invoices.invoice_total%TYPE;
--   max_invoice_total ap.invoices.invoice_total%TYPE;
-- begin
--    SELECT MIN(invoice_total), MAX(invoice_total) INTO min_invoice_total,max_invoice_total
--    FROM ap.invoices;
--    DBMS_OUTPUT.put_line('The minimum invoice total is ' || min_invoice_total || ' while the maximum output total is ' || max_invoice_total || '.'); 
-- end;

SET SERVEROUTPUT ON
DECLARE 
  salary_stella NUMBER; 
  title_stella VARCHAR2(10);

BEGIN

  SELECT salary, title INTO salary_stella, title_stella
  FROM student.employee
  WHERE NAME = 'Stella';
  DBMS_OUTPUT.put_line('Stella is ' || title_stella || ' and has a salary of ' || salary_stella ||' .');
end;

-- Problem 4 (3 pts)
-- Display the highest and lowest invoice totals
-- Use the ap.invoices table
-- Format the invoice totals as dollars and cents


-- SET SERVEROUTPUT ON
-- declare
--   min_invoice_total ap.invoices.invoice_total%TYPE;
--   max_invoice_total ap.invoices.invoice_total%TYPE;
-- begin
--    SELECT MIN(invoice_total), MAX(invoice_total)  INTO min_invoice_total,max_invoice_total
--    FROM ap.invoices;
--    DBMS_OUTPUT.put_line('The minimum invoice total is ' || to_char(min_invoice_total, '$999,999.00') || ' while the maximum output total is ' || to_char(max_invoice_total, '$999,999.00')  || '.'); 
-- end;

-- How to address breaks that are produced in the above query with RegEx

SET SERVEROUTPUT ON
declare
  min_invoice_total ap.invoices.invoice_total%TYPE;
  max_invoice_total ap.invoices.invoice_total%TYPE;
begin
   SELECT MIN(invoice_total), MAX(invoice_total)  INTO min_invoice_total,max_invoice_total
   FROM ap.invoices;
   DBMS_OUTPUT.put_line(REGEXP_REPLACE('The minimum invoice total is' || to_char(min_invoice_total, '$999,999.00') || ' while the maximum output total is ' || to_char(max_invoice_total, '$999,999.00')  || '.', ' +', ' ')); 
end;

-- Problem 5 (4 pts)
-- Find the latest invoice due date
-- Use the ap.invoices table
-- If the latest invoice due date is before July 19, 2008: Display Overdue
-- -- Otherwise, Display OK

-- select  invoice_id,(invoice_due_date - payment_date) AS "Number of days elapsed" from ap.invoices;


-- select max(invoice_due_date) from ap.invoices;


-- SELECT invoice_date,
--        COUNT(*) AS "Invoices in June 2008"
-- FROM ap.invoices
-- GROUP BY invoice_date
-- HAVING invoice_date >= '09-JUL-08'
-- AND invoice_date < '09-JUL-08'
-- ORDER BY invoice_date ASC;


-- SELECT INVOICE_DUE_DATE - INVOICE_DATE AS "Difference in Days",
--        COUNT(INVOICE_DUE_DATE - INVOICE_DATE) AS "How Many?"
-- FROM ap.invoices
-- GROUP BY "Difference in Days"
-- HAVING INVOICE_DUE_DATE < '09-JUL-08'
-- ORDER BY INVOICE_DUE_DATE - INVOICE_DATE DESC;


-- SELECT invoice_id, INVOICE_DUE_DATE - INVOICE_DATE AS "Difference in Days"
-- FROM ap.invoices
-- ORDER BY "Difference in Days" DESC;

-- SELECT invoice_id, invoice_due_date, INVOICE_DUE_DATE - INVOICE_DATE AS "Difference in Days"
-- FROM ap.invoices
-- ORDER BY "Difference in Days" DESC;



-- SELECT invoice_id, invoice_due_date, INVOICE_DUE_DATE - INVOICE_DATE AS "Difference in Days"
-- FROM ap.invoices
-- ORDER BY "Difference in Days" DESC;


-- SET SERVEROUTPUT ON;
-- declare
--   due_date DATE;
--   payment_date DATE;
-- begin
--    SELECT MAX(invoice_due_date)
--    INTO due_date
--    FROM ap.invoices;
--    DBMS_OUTPUT.put_line('The latest due date is ' || due_date); 
-- end;


-- select * from ap.invoices where payment_date < '19-JUL-08';

-- SET SERVEROUTPUT ON;
-- declare
--   due_date DATE;
--   payment_date DATE;
-- begin
--    SELECT invoice_id
--    INTO due_date
--    FROM ap.invoices
--    WHERE payment_date < '19-JUL-08';

--    If due_date < '19-JUL-08'
--    DBMS_OUTPUT.put_line('overdue' || due_date); 
-- end;

-- SET SERVEROUTPUT ON;
-- declare
--   due_date DATE;
--   payment_date DATE;
-- begin
--    SELECT payment_date
--    INTO due_date
--    FROM ap.invoices
--    IF payment_date < '19-JUL-08';
--    DBMS_OUTPUT.put_line('The latest due date is ' || due_date); 
-- end;


-- SET SERVEROUTPUT ON;
-- declare
--   due DATE;
--   payment DATE;
-- begin
--    SELECT payment_date
--    INTO payment
--    FROM ap.invoices
--    GROUP BY payment_date
--    HAVING payment_date <= '09-JUL-08';
--    If payment_date < '19-JUL-08' THEN
--    DBMS_OUTPUT.put_line('The latest due date is ok'); 
--    end if;
-- end;


-- SET SERVEROUTPUT ON;
-- declare
--   first_due DATE;
--   latest_date DATE;
-- begin
--    SELECT MIN(invoice_due_date), MAX(invoice_due_date)
--    INTO first_due, latest_date
--    FROM ap.invoices
--    WHERE invoice_total - payment_total - credit_total > 0;
--    IF first_due < SYSDATE() THEN
--    DBMS_OUTPUT.put_line('Jevum!'); 
--    IF latest_date < '19-JUL-08' THEN
--    DBMS_OUTPUT.put_line('The latest due date is overdue!' || latest_date);
--    end if;
-- end;

SET SERVEROUTPUT ON;
declare
  first_due DATE;
  latest_date DATE;
  datevar DATE;
begin
   datevar := '19-July-08';
   SELECT MIN(invoice_due_date), MAX(invoice_due_date)
   INTO first_due, latest_date
   FROM ap.invoices
   WHERE invoice_total - payment_total - credit_total > 0;
   IF latest_date >= datevar THEN
   DBMS_OUTPUT.put_line('The latest due date is overdue!' || latest_date);
   ELSE
     DBMS_OUTPUT.put_line('Ok');
   end if;
end;
/

-- Problem 6 (4 pts)
-- Display information concerning the state where customer_id of 15 lives
-- Use the om.customers table
-- You must use a CASE statement
-- For Wisconsin customers
   -- Display Cold Winters
-- For California customers
   -- Display Moderate Winters
-- For all other customers
   -- Display No information on type of Winters.


SET SERVEROUTPUT ON;

DECLARE
  terms_id_var NUMBER;
  states_id_var VARCHAR2(10);
  
BEGIN
  SELECT customer_id, customer_state 
  INTO terms_id_var, states_id_var
  FROM om.customers
  WHERE customer_id = 15;

CASE states_id_var

  WHEN 'WI' THEN
    DBMS_OUTPUT.put_line('Cold Winters');
  WHEN 'CA' THEN
    DBMS_OUTPUT.put_line('Moderate Winters');
  ELSE
  DBMS_OUTPUT.put_line('Nona');
  END CASE;
END;
/

-- Problem 7 (3 pts)
-- -- Create a FOR loop that will display the numbers 1 through 3 inclusive

SET SERVEROUTPUT ON;
DECLARE
i INTEGER;

BEGIN
  FOR i IN 1..3 LOOP
     DBMS_OUTPUT.put_line('i: ' || i);
  END LOOP;
END;


-- -- Create a FOR loop that will display the numbers 3 through 1 inclusive
-- -- neat lil' function => http://www.techonthenet.com/oracle/loops/for_loop.php

SET SERVEROUTPUT ON;
DECLARE
i INTEGER;

BEGIN
  FOR i IN REVERSE 1..3 LOOP
     DBMS_OUTPUT.put_line('i: ' || i);
  END LOOP;
END;


-- -- Create a WHILE loop that will display the numbers 1 through 3 inclusive

SET SERVEROUTPUT ON;

DECLARE
i INTEGER := 1;

BEGIN
  While i < 4 LOOP
     DBMS_OUTPUT.put_line('i: ' || i);
     i := i + 1;
  END LOOP;
END;


-- -- Create a WHILE loop that will display the numbers 3 through 1 inclusive

SET SERVEROUTPUT ON;
DECLARE
i INTEGER := 3;

BEGIN

  While i > 0 LOOP
     DBMS_OUTPUT.put_line('i: ' || i);
     i := i - 1;
  END LOOP;
END;


-- -- Create LOOP that will display the numbers 3 through 1 inclusive
-- SET SERVEROUTPUT ON;
--  DECLARE
--  i INTEGER := 1;

-- BEGIN

-- LOOP
--    DBMS_OUTPUT.put_line('i: ' || i);
--    i := i + 1;
--    EXIT WHEN i >= 4;
-- END LOOP;
-- END;

SET SERVEROUTPUT ON;
 DECLARE
 i INTEGER := 3;

BEGIN

LOOP
   DBMS_OUTPUT.put_line('i: ' || i);
   i := i - 1;
   EXIT WHEN i = 0;
END LOOP;
END;



-- Problem 8 (3 pts)
-- -- Write a query to find an employee named Sally
-- -- Use the student.employee table
-- -- Include the exception handling
-- -- Provide a useful error message to the user

SET SERVEROUTPUT ON
DECLARE 
salary_sally NUMBER; 
title_sally VARCHAR2(10);

BEGIN

SELECT salary, title
INTO salary_sally, title_sally
FROM student.employee
WHERE NAME = 'Sally';
DBMS_OUTPUT.put_line('Sally is ' || title_sally || ' and has a salary of ' || salary_sally ||' .');
exception
  WHEN NO_DATA_FOUND THEN
  DBMS_OUTPUT.put_line('We are sorry- the query you are trying to structure is no longer available or outside the table area- please check the code and type again; message  number ORA 01403.');
end;









