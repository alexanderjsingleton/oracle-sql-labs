import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import java.sql.*;

public class JavaLab2 {

  /**
   * @param args
   */
  public static void main(String[] args) 
  {
    try

     {

      Connection conn = DriverManager.getConnection(
          "jdbc:oracle:thin:@classdb.jccc.edu:1521:cisdb", "", "");

      System.out.println("connected!");
      
      Statement stmt = conn.createStatement();
      
      System.out.println();
      System.out.println("*** Problem 1 ***");
      
      // Problem 1a
      ResultSet rs = stmt.executeQuery("DROP TABLE employee_copy");
      
      
      while(rs.next())
      {
        System.out.println("Problem 1 number of students in student_copy: ");
    
      }
      
      System.out.println();
      
      // Problem 1a
      ResultSet rs = stmt.executeQuery("DROP TABLE employee_copy");
      
      
      while(rs.next())
      {
        System.out.println("Problem 2 number of students in student_copy: ");
    
      }
      
      System.out.println();
                  
      System.out.println("*** Problem 2 ***");

 // Part 2

    import java.sql.Connection;
    import java.sql.DriverManager;
    import java.sql.Statement;

    import java.sql.*;

    public class JavaLab2 {

    /**
    * @param args
    */
    public static void main(String[] args) 
    {
      try

    {

    Connection conn = DriverManager.getConnection(
    "jdbc:oracle:thin:@classdb.jccc.edu:1521:cisdb", "", "");

    System.out.println("connected!");

    Statement statement = conn.createStatement();

    System.out.println();
    System.out.println("*** Problem 1 ***");

  // Part A
    String insertStatement = "INSERT INTO employee_copy(employee_id,name,salary,title)" + "VALUES ('1','Bill','12345','Manager')";

    int count = statement.executeUpdate(insertStatement);

    System.out.println("*** Problem 2b ***");

    // Part B
    ResultSet rs = statement.executeQuery("Select count(*) From employee_copy");

    while(rs.next())
    {
      System.out.println("Problem 1 number of employee_copy: " + rs.getInt(1));
    }

    System.out.println();
    System.out.println("*** break ***");

    String insertStatement2 = "INSERT INTO employee_copy(employee_id,name,salary,title)" + "VALUES ('2','Mary','54321','Director')";

    int count2 = statement.executeUpdate(insertStatement2);
  }
  catch(Exception e)
  {
    e.printStackTrace( );
  }
 }
}




 // Problem 3

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import java.sql.*;

public class JavaLab2 {

  /**
   * @param args
   */
  public static void main(String[] args) 
  {
    try

     {

      Connection conn = DriverManager.getConnection(
          "jdbc:oracle:thin:@classdb.jccc.edu:1521:cisdb", "", "");

      System.out.println("connected!");
      
      Statement statement = conn.createStatement();
      
      System.out.println();
      System.out.println("*** Problem 1 ***");
      
      // Problem 1
      String insertStatement = "INSERT INTO enrollment_copy(student_id,section_id,enroll_date,final_grade,created_by,created_date,modified_by,modified_date)" + "VALUES ('1','2','31-mar-1998','85','mike','02-jun-1998','mike2','03-jun-1998')";
        
      int count = statement.executeUpdate(insertStatement);
      
      System.out.println("*** Problem 2b ***");
          
          // Problem 2
      ResultSet rs = statement.executeQuery("Select count(*) From enrollment_copy");
          
          while(rs.next())
          {
            System.out.println("Problem 1 number of employee_copy: " + rs.getInt(1));
          }
          
        System.out.println();
        System.out.println("*** break ***");
        
        String insertStatement2 = "INSERT INTO enrollment_copy(student_id,section_id,enroll_date,final_grade,created_by,created_date,modified_by,modified_date)" + "VALUES ('2','3','01-mar-1998','85','mike','02/jun/1998','mike2','02-jun-1998')";
        
        int count2 = statement.executeUpdate(insertStatement2);            
     }
     catch(Exception e)
     {
       e.printStackTrace( );
     }
  }
}


// Problem 4


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import java.sql.*;

public class JavaLab2 {

  /**
   * @param args
   */
  public static void main(String[] args) 
  {
    try

     {

      Connection conn = DriverManager.getConnection(
          "jdbc:oracle:thin:@classdb.jccc.edu:1521:cisdb", "", "");

      System.out.println("connected!");
      
      Statement statement = conn.createStatement();
      
      System.out.println();
      System.out.println("*** Problem 1 ***");
      
      // Problem 1
      String insertStatement = "ALTER TABLE employee_copy ADD country VARCHAR2(10) DEFAULT 'USA' NOT NULL";
      
      int count = statement.executeUpdate(insertStatement);
      
      System.out.println("*** Problem 2b ***");
          
          // Problem 2
      ResultSet rs = statement.executeQuery("Select count(*) From enrollment_copy");
          
          while(rs.next())
          {
            System.out.println("Problem 1 number of employee_copy: " + rs.getInt(1));
          }
          
        System.out.println();
        System.out.println("*** break ***");
                                  
     }
     catch(Exception e)
     {
       e.printStackTrace( );
     }
  }
}

// Problem4a

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import java.sql.*;




import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import java.sql.*;

public class JavaLab2 {

  /**
   * @param args
   */
  public static void main(String[] args) 
  {
    try

     {

      Connection conn = DriverManager.getConnection(
          "jdbc:oracle:thin:@classdb.jccc.edu:1521:cisdb", "", "");

      System.out.println("connected!");
      
      Statement statement = conn.createStatement();
      
      System.out.println();
      System.out.println("*** Problem 1 ***");
      
      // Problem 1
      String insertStatement = "UPDATE employee_copy SET salary='35000',title='DBA' WHERE name ='Bill'";
      
      int count = statement.executeUpdate(insertStatement);
      
      System.out.println("*** Problem 2b ***");
          
          // Problem 2
      ResultSet rs = statement.executeQuery("Select count(*) From enrollment_copy");
          
          while(rs.next())
          {
            System.out.println("Problem 1 number of employee_copy: " + rs.getInt(1));
          }
          
        System.out.println();
        System.out.println("*** break ***");
                                  
     }
     catch(Exception e)
     {
       e.printStackTrace( );
     }
  }
}























      
      