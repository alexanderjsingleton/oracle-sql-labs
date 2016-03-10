Lab 2 – SQL
Due February 11, 2016 by the start of class

Each problem is worth one point. No partial credit will be given. This lab is worth a total of 20 points.

Use the hostname: classdb.jccc.edu

Place all answers into ONE .sql file. Attach that file to the Dropbox for Lab 2 in D2L. Only one .sql file will be accepted.

1.    Explain the purpose of a WHERE clause? 
According to an article published by Oracle Magazine, the `WHERE` clause enables users to narrow the scope of the data a `SELECT` statement retrieves.  The `WHERE` clause specifies  criteria that must be satisfied before records are returned for a given query result-set.  Moreover, the `WHERE` clause must specify a `WHERE` clause condition (or conditions) that the database software evaluates to be true or false-alternatively, the software can determine the the absence of a value in conjunction with the use of conditional expressions.
        

*** Use the tables from the AP table space for the following questions ***
2.    Display all invoices where the vendor id equals 34. Use the invoices table.
   

`SELECT * FROM ap.invoices WHERE vendor_id=34;`

(SELECT all from ap.invoices table where vendor_id=34)
3.    Display all invoices where the total of the invoice is $356.48. Use the invoices table.

   
`SELECT invoice_id FROM ap.invoices WHERE invoice_total=356.48;`

(SELECT invoice_id from invoices table where the invoice = 356.48)

4.    Display all invoices where the invoice id is either 81, 82 or 90. You must use the IN 
        operator to receive credit. Use the invoices table.
(https://docs.oracle.com/cd/B19306_01/server.102/b14200/conditions013.htm)

   

EXACT RECON: `SELECT invoice_id, invoice_number, invoice_date FROM ap.invoices WHERE invoice_id IN(81, 82, 90);`
`SELECT * FROM ap.invoices WHERE invoice_id IN(81, 82, 90);`

    
5.    Display all invoices where the vendor id is less than or equal to 44. Use the invoices table.
   
EXACT RECON: `SELECT invoice_id, vendor_id FROM ap.invoices WHERE vendor_id <=44;`
`SELECT * FROM ap.invoices WHERE vendor_id <=44;`

6.    Display all invoices where the credit total is not equal to zero. Use the invoices table. 
   
EXACT RECON: `SELECT invoice_id, vendor_id, credit_total FROM ap.invoices WHERE credit_total !=0;`
`SELECT * FROM ap.invoices WHERE credit_total !=0;`
7.    Display all invoices where the invoice date is equal to May 1, 2008. Use the invoices table.
   
EXACT:`SELECT invoice_id, invoice_date FROM ap.invoices WHERE invoice_date=’01-MAY-08’;1

`SELECT * FROM ap.invoices WHERE invoice_date='01-MAY-08';`


8.    Display all invoices where the payment total is between 100 and 115, inclusive. Use the         invoices table.
(https://docs.oracle.com/cd/B19306_01/server.102/b14200/conditions008.htm)

   
`SELECT invoice_id, invoice_date, payment_total 
  FROM ap.invoices 
  WHERE payment_total BETWEEN 100 AND 115;`

9.    Display all invoices where the invoice date is between May 1, 2008 and May 8, 2008, 
        inclusive. You must use the Between operator to receive credit. Use the invoices table.
  Partial result set (15 rows total)
   
`SELECT invoice_id, invoice_date
  FROM ap.invoices 
  WHERE invoice_date BETWEEN '01-May-08' AND ’08-May-08’;`
 
`SELECT *
  FROM ap.invoices 
  WHERE invoice_date BETWEEN '01-May-08' AND '08-May-08';`

10.  Display all invoices where the invoice number starts with a capital P. Use the invoices table.
http://www.techonthenet.com/oracle/regexp_like.php

   
  
REGEX: `SELECT invoice_id, invoice_number
  FROM ap.invoices 
  WHERE REGEXP_LIKE (invoice_number, '^P(*)');`

11.    Display all invoices where the invoice number starts with a capital P followed by a dash 
          followed by a 3. Use the invoices table.

  `SELECT invoice_id, invoice_number
   FROM ap.invoices 
   WHERE invoice_number like ‘P-3%’;`
   
12.    Display all invoices where the invoice number ends with a –X (dash followed by a capital 
          X). Use the invoices table.
  `SELECT invoice_id, invoice_number
  FROM ap.invoices 
  WHERE invoice_number like ‘%-X’;`

   

13.    Display all invoices where the invoice number contains (does not start with or end with) 
          a double 7 (i.e. 77). Use the invoices table.

`SELECT invoice_id, invoice_number
  FROM ap.invoices 
  WHERE invoice_number like '%_77%_’;`
  
   

14.    Display all invoices where the invoice number has a zero as the second character and a 3 
          as the fourth character. Use the invoices table.

`SELECT invoice_id, invoice_number
  FROM ap.invoices 
  WHERE invoice_number like ‘_0_3%’;`


   



15.    Display all invoices where the payment date contains a null value. Use the invoices 
          table.

  Partial result set (40 rows total)

`SELECT invoice_id, payment_date
  FROM ap.invoices 
  WHERE payment_date is NULL;`
 


16.    Display all invoices where the payment date does not contain a null value. Use the 
          invoices table.

  Partial result set (74 rows total)

`SELECT invoice_id, payment_date
  FROM ap.invoices 
  WHERE payment_date IS NOT NULL;`

   

17.    Display all invoices where the payment total amount is zero and the invoice total is 
          greater than $100. Use the invoices table.

Partial result set (18 rows total)

`SELECT invoice_id, payment_total, invoice_total
  FROM ap.invoices 
  WHERE payment_total=0 AND invoice_total >= 100;`

   

-- 18.    Display all invoices where the payment total amount is between zero and $25, inclusive 
--           or the invoice total is greater than $100. Use the invoices table.

-- Partial result set (97 rows total)

`SELECT invoice_id, payment_total, invoice_total
  FROM ap.invoices 
  WHERE payment_total BETWEEN 0 AND 25 OR invoice_total >= 100;`

  

19.    Display all invoices where the terms id is not 1 or 2 or 3 or 4. You must use an IN 
          operator to receive credit. Use the invoices table.

 `SELECT invoice_id, terms_id
  FROM ap.invoices 
  WHERE terms_id NOT IN (1,2,3,4);`


    
20.    Display all invoices where the invoice date is either May 1, 2008 or May 17, 2008 and 
          payment total amount is zero. You must use the OR and AND operators to receive 
          credit. Use the invoices table.

`SELECT invoice_id, invoice_date, payment_total
  FROM ap.invoices 
  WHERE invoice_date= '01-May-08' OR invoice_date='17-May-08' AND payment_total=0;`




   

  

