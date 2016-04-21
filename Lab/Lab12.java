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
			
			// Problem 1
			ResultSet rs = stmt.executeQuery("Select count(*) From student.student");
			
			while(rs.next())
			{
				System.out.println("Problem 1 number of students: " + rs.getInt(1));
			}
			
			System.out.println();
			System.out.println("*** Problem 2 ***");
			
			// Problem 2
			rs = stmt.executeQuery("Select first_name, last_name From student.student Where last_name like 'Z%' or last_name like 'Y%' Order By last_name");
			
			while(rs.next())
			{
				System.out.println("Problem 2 student name: " + rs.getString(2) + ", " + rs.getString(1));
			}
			
			System.out.println();
			System.out.println("*** Problem 3 ***");
			
			// Problem 3
			rs = stmt.executeQuery("Select employee_id, name, salary, title From student.employee");
						
			while(rs.next())
			{
				int emp_id = rs.getInt("employee_id");
				String name = rs.getString("name");
				int salary = rs.getInt("salary");
				String title = rs.getString("title");
				System.out.println("Problem 3 employee info: " + emp_id + " : " + name +  " : " + salary + " : " + title);
			}
			
			System.out.println();
			System.out.println("*** Problem 4 ***");
			
			// Problem 4
			rs = stmt.executeQuery("Select employee_id, name, salary, title From student.employee");
									
			while(rs.next())
			{
				int emp_id = rs.getInt(1);
				String name = rs.getString(2);
				int salary = rs.getInt(3);
				String title = rs.getString(4);
				System.out.println("Problem 4 employee info: " + emp_id + " : " + name +  " : " + salary + " : " + title);
			}
			
			System.out.println();
			System.out.println("*** Problem 5 ***");
			
			// Problem 5
			rs = stmt.executeQuery("Select student_id as \"Registered on Jan 30, 2007\" From student.student Where registration_date = '30-jan-2007'");
			
			int student_total = 0;
			
			while(rs.next())
			{
				int student_id = rs.getInt("Registered on Jan 30, 2007");
				student_total += 1;
			}
			
			System.out.println("Problem 5 number of students that registered on Jan 30, 2007: " + student_total);
		
			
		 }
		 catch(Exception e)
		 {
			 e.printStackTrace( );
		 }

	}

}
