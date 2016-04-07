// #1 Find the sum of 15 to 337, inclusive, using a for loop. (2 pts)

public class test1 {
  public static void main(String[] args) {
    int total = 0;
    for(int i=15; i<=337; i++)
    {
      total += i;
    }
    System.out.println("The sum of this problem is:  " + total);  
  }
}

// #2 Do problem 1 using a while loop. (2 pts)

public class test1 {
  public static void main(String[] args) {
    int total = 0;
    int i=15;
    while( i<=337 ) {
      i++;
      total += i;
    }
    System.out.println("The sum of this problem is:  " + total);
  }
}

// #3 Using an if statement only, determine if a grade is below 70. If it is, display 
// “Grade is below 70. The actual grade was xx.” Where xx is the actual grade value. Use 
//  a hard-coded grade value of your choosing. (2 pts)

public class test1 {
  public static void main(String[] args) {
    int grade = 69;
    if (grade < 70)
    {
      System.out.println("Grade is below 70.  The actual grade was " + grade + ".");
    }
  }
}

// #4 Using an if statement with an else clause, determine if a grade is below 70. If it
// is, display “Grade is below 70.”. If it is at least 70, display “Grade is a C or 
// better”. (2 pts)

public class test1 {
  public static void main(String[] args) {
    int grade = 84;
    if (grade >= 70)
    {
      System.out.println("Grade is C or better.");
    }
    else
    {
      System.out.println("Grade is below 70.");
    }
  }
}


// #5 Using an if statement with the appropriate else if or else clauses, determine if
// a number if positive, negative or equal to zero. Display an appropriate message
// for each case. (3 pts) 

public class test1 {
    public static void main(String[] args) {
      int number = 0;
      if (number > 0)
      {
        System.out.println("Number is positive.");
      }
      if (number < 0 )
      {
        System.out.println("Number is negative.");
      }
      else if (number == 0)
      System.out.println("Number is 0.");
    }
  }
}


// #6 Using a for loop, display all odd numbers between 2 and 21, inclusive.

public class test1 {
  public static void main(String[] args) {
    int limit = 21;
    System.out.println("Display all odd numbers between 2 and " + limit + ".");
    for(int i=2; i <= limit; i++){
      if( i % 2 != 0){
        System.out.print(i + " ");
      }
    }
  }
}

// #7 Populate an array with the numbers 6, 11.7, and 10 (you may use any technique you wish). 
// Find and display the average. (3 pts)

// https://docs.oracle.com/javase/tutorial/java/nutsandbolts/for.html
// http://www.java2s.com/Book/Java/0020__Language-Basics/Calculate_Average_value_of_Array_elements.htm

public class test1 {
  public static void main(String[] args) {

    double[] intArray = new double[] { 6, 11.7, 10 };
    double sum = 0;
    for (int i = 0; i < intArray.length; i++){
      sum = sum + intArray[i];
    }
    double average =  sum / intArray.length;

    System.out.println("average: " + average);
  }
}

// #8 Populate an array using a for statement, with the numbers 1 through 101. Calculate 
// the sum of the numbers by processing the array with a for statement. Display the sum. (4 pts)

// http://stackoverflow.com/questions/409784/whats-the-simplest-way-to-print-a-java-array
// http://pirate.shu.edu/~wachsmut/Teaching/CSAS2214/Virtual/Lectures/lecture2a.html
// http://www.informit.com/articles/article.aspx?p=101766&seqNum=10

public class test1 {
public static void main(String[] args)
   {
      int A[] = new int[102];        // initializing the array
      for (int i = 1; i < 102; i++)
         A[i] = i+1;                 // why the i + 1 as opposed to just i ?
      int sum = 0;
      for (int i = 1; i < 102; i++)
         sum += A[i];               // shortcut for sum = sum + A[i]
      // int sqsum = 0;
      // for (int i = 1; i < 101; i++)
      //    sqsum += A[i]*A[i];        // shortcut for sqsum = sqsum + A[i]*A[i]
      System.out.println("Sum of numbers 1 to 101 is " + sum + ".");
      // System.out.println("Sum of first 100 square numbers is " + sqsum);
   }
}


// #9 Use the range of numbers from 9 through 1497 within a for statement. Display all numbers
// divisible by 11. In addition, after the for statement, display a count of the total numbers found that were divisible by 11. (4 pts)

// http://javadevnotes.com/java-print-array-examples

public class test1 {
  public static void main(String[] args)
  {
    int count = 0;
    for (int number = 9; number <=1497; number ++)
    {
      if (number%11 == 0) {count++;}
    }
    System.out.println(count);
    int limit = 1497;
    for (int i = 9; i < limit; i++){
      if( i % 11 == 0){
        System.out.print(i + " ");
      }
    }          
  }
}
