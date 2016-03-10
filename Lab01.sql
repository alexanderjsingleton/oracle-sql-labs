CIS 260 - Lab 1 - SQL
Due February 11, 2016 by the start of class

Each problem is worth one point. No partial credit will be given. This lab is worth a total of 20 points.

Use the hostname: classdb.jccc.edu

Place all answers into ONE .sql file. Attach that file to the Dropbox for Lab 1 in D2L. Only one .sql file will be accepted.

  1.     An Oracle server stores information about all tables in a special set of relational tables called the data dictionary, in order to manager them. Explain the term “data dictionary”.
  1.  According to the Oracle Documentation, the “data dictionary” is one of the most important parts of an Oracle database, which is a read-only set of tables that provides information about the database.  A database dictionary includes the following:
  1.    The definitions of all schema objects in the database (tables, views, indexes, clusters, synonyms, sequences, procedures, functions, packages, triggers, and so on)
  2.  How much space has been allocated for, and is currently used by, the schema objects
  3.  Default values for columns
  4.  Integrity constraint information
  5.  Privileges and roles each user has been granted.
  6.   Auditing information, such as who has accessed or updated various schema objects
  7.   Auditing information, such as who has accessed or updated various schema objects.
  Concordantly, the data-dictionary is structured in tables and views, which for a given database are stored in that database’s SYSTEM tablespace.  The key-value pair is an essential relationship for not just database design, architecture, engineering but also in programming in general.  A key-value pair hash-table is sort of like a data-dictionary within database-work.  Accordingly, per documentation, “Not only is the data dictionary central to every Oracle database, it is an important tool for all users, from end users to application designers and database administrators.”
        
2.    Contrast and define the terms “metadata” and “data”. 
According to research, metadata is data about data, so naturally I think of analytics.   Metadata isn’t necessarily concerned with specific, but rather, the meta- or the general herd of data interactions defining a broader relationship or revelation.  Oracle databases store data about “the physical and logical structures of the database, such as the names, location and sizes of the database files as well as the instance )the memory structures and the background processes) and the operation of the database such as recently executed SQL statements, execution plans. etc.”  Furthermore, I’ve broadened by understanding by inquiring StackExchange DBA; as I understand, metadata is essentially data that describes your data.

3.    Explain the purpose of the DESCRIBE table command? 
The Oracle documentation provides an excellent definition of the DESCRIBE operation.  Evidently, database objects have various attributes that describe them, or particular schema information about an object obtainable by performing the DESCRIBE operation.  The result can be accessed as an object of the Metadata class by passing object attributes as arguments to the various methods of the Metadata class.

**** The following questions use tables from the Student table space ****

4.    Using the DESCRIBE table command, create the following result table using the student 
        employee table.
  `DESC student.employee`
     
5.    Can the SELECT statement be used to alter data within a table? Explain your answer.
  Experience suggests that the `SELECT` do not destroy or mutate data within a data.  The aforementioned is substantiated by the w3schools.com definition of the SELECT statement, stating that the “result is stored in a result table, called the result-set.”

6.    Display all rows and columns within the employee table.
  `SELECT * FROM student.employee;`
     
7.    List the students by last name followed by first name. Use the student table.
  Partial result set (total of 268 rows)
  `SELECT last_name, first_name  FROM STUDENT.STUDENT;`
   

8.    List the students by last name followed by first name. Assign the label “FN” for a 
        student’s first name and “LN” for a student’s last name. Use the student table.
  Partial result set (total of 268 rows)
  ` SELECT first_name AS "FN", last_name AS "LN" FROM student.student;`
9.    List all unique zip codes. Use the student table.
  Partial result set (total of 145 rows)
  
  `SELECT DISTINCT zip FROM student.student;`
   
  
10.    List the unique employers of the students and place them in ascending alphabetic order 
          (use the Order By clause). Use the student table.
  Partial result set (total of 161 rows)
  `SELECT DISTINCT employer FROM student.student
    ORDER BY employer ASC;`
   
  

11.    List all students last names without any capitalization. Use the student table.
  Partial result set (total of 268 rows)
  `SELECT LOWER(last_name) FROM student.student;
   

12.    List the first three characters of all course descriptions. Use the course table.
  Partial result table (total of 30 rows)
  `SELECT SUBSTR(description,1,3) FROM student.course;`
   
13.    List the last three characters of all course descriptions. Use the course table.
  Partial result table (total of 30 rows)
  `SELECT SUBSTR(description,-3) FROM student.course;`
 
**** The following questions use the dual table ****

14.    Explain what the dual table is used for.

According to the Oracle documentation, Dual is a table automatically created by Oracle Database along with the data dictionary.   Dual is in the schema of the user SYS but is accessible by the dual to all users.  Moreover, research on StackOverflow reveals the following: simply stated, “it’s a dummy table with a singlet record used for selecting when you’re not actually interested in the data, but instead want the results of some system function in a select statement- e.g. `select sysdate from dual`”.

15.    Display all columns and rows of the Dual table.
  `SELECT * FROM dual;`
   
16.    Display the sum of 2 + 4 using the DUAL table.
  `SELECT SUM (2+4) FROM dual;`
   


17.    Display 5 times 3, 5 minus 3, and 5 divided by 3. Use the Dual table.
  `SELECT  (5*3), (5-3), (5/3) FROM dual;`
   

18.    Display 5 divided by 3 as a rounded value as per the following result table. Use the Dual 
table. (Hint: to round to the number of decimal places, use (5/3,2) where the ,2 represents the number of places beyond the decimal point)
https://docs.oracle.com/cd/B19306_01/server.102/b14200/functions135.htm
`SELECT  ROUND(5/3,3) FROM dual;`
   
19.    List the current date using the Dual table.
  Of course, you need to display today’s current date.
  https://docs.oracle.com/cd/B19306_01/server.102/b14200/functions172.htm
  `SELECT SYSDATE FROM dual;`
   

20.    List yesterday’s date using the Dual table.
  Yesterday’s date based on today’s current date.
  `SELECT SYSDATE-1 FROM dual;`
   



    
  