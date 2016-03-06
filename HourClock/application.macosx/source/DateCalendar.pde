/** DateCalendar adds the day of the week to the clock face
*
*
* @author Functionality by: Paul Charles, Purna Doddapaneni, Dilesh Fernando, Cheng-yeh Lee
*/
import java.util.GregorianCalendar;

import static javax.swing.JOptionPane.*;
import java.util.regex.*;
/** DateCalendar is used to keep track of the actual date in MM/DD/YYY and display the corresponding day of the week
*
*
* @author Paul Charles, Purna Doddapaneni, Dilesh Fernando, Cheng-yeh Lee
*/

public class DateCalendar {
  //Variables for user input
  private int year = 0;
  private int month = 0;
  private int day = 0;
  
  //Variables patterm matching
  private Pattern patternDate;
  private Matcher matchDate;
  
  //Create instance of java.util GregorianCalendar
  GregorianCalendar calendar = new GregorianCalendar();
  
/** 
  @pre none
  @post none
  @return none
*/ 
  DateCalendar(){}
  
 /** 
    @pre inputDate
    @post none
    @return none
  */
  public void setDateDialog(){
    //temp local variables
    String inputDate;

    /** checks if date is entered correctly */
    Boolean dateIsValid = false;

    /** regular expression looking for the format "MM/DD/YYYY" */
    String datePattern = "^(0?[1-9]|1[012])/(0?[1-9]|[12][0-9]|3[01])/((19|20)\\d\\d)$";
    
    while(!dateIsValid){
      //prompt the user for date input
      inputDate = showInputDialog("Set Date\nEnter date in following format MM/DD/YYYY");

      if (inputDate == null){
        /** if user presses cancel:
         1) set time to computer clock time if user first opens program
         2) do not change time if user has already been running clock */
        dateIsValid = true;
      }

      else{

        /** compile and match regex to the given input */
        patternDate = Pattern.compile(datePattern);
        matchDate = patternDate.matcher(inputDate);

        if (matchDate.find()){

          dateIsValid = true;

          /** set moth to first group of regex */
          month = Integer.parseInt(matchDate.group(1));
          /** set day to second group of regex */
          day = Integer.parseInt(matchDate.group(2));
          /** set year to third group of regext */
          year = Integer.parseInt(matchDate.group(3));

        }
      }
    }
    
    setDateCalendar(year, month, day);
    
    System.out.println("year: " +year);
    System.out.println("month: " +month);
    System.out.println("day: " +day);
    System.out.println("day of the week: " + getDayOfTheWeek());
  }
 /** 
    @pre userDate
    @post none
    @return day of the week
  */
  public void setDateCalendar(int year, int month, int day){
    calendar.set(GregorianCalendar.YEAR, year);
    calendar.set(GregorianCalendar.MONTH, (month - 1));
    calendar.set(GregorianCalendar.DATE, day);
  }
  /** 
    @pre userDate
    @post none
    @return day of the week
  */ 
  public int getDayOfTheWeek(){
    return(calendar.get(GregorianCalendar.DAY_OF_WEEK));
  }
    /** 
    @pre none
    @post none
    @return day of the week
  */ 
  public void incrementDay(){
    calendar.add(GregorianCalendar.DAY_OF_MONTH, 1);
  }
    /** 
    @pre none
    @post none
    @return none
  */ 
  public void displayDateCalendar(){
    //Images that display the day of the week
    PImage Mon = loadImage("MON.png");
    PImage Tue = loadImage("TUE.png");
    PImage Wed = loadImage("WED.png");
    PImage Thu = loadImage("THU.png");
    PImage Fri = loadImage("FRI.png");
    PImage Sat = loadImage("SAT.png");
    PImage Sun = loadImage("SUN.png");
    
    int dayOfTheWeek = getDayOfTheWeek();
    
    if(dayOfTheWeek == 1)
    {
     Sun.resize(90, 60);
     image(Sun, 95, 320);
    }
    else if(dayOfTheWeek == 2)
    {
     Mon.resize(90, 60);
     image(Mon, 95, 320);
    }
    else if(dayOfTheWeek == 3)
    {
     Tue.resize(90, 60);
     image(Tue, 95, 320);
    }
    else if(dayOfTheWeek == 4)
    {
     Wed.resize(90, 60);
     image(Wed, 95, 320);
    }
    else if(dayOfTheWeek == 5)
    {
     Thu.resize(90, 60);
     image(Thu, 95, 320);
    }
    else if(dayOfTheWeek == 6)
    {
     Fri.resize(90, 60);
     image(Fri, 95, 320);
    }
    else if(dayOfTheWeek == 7)
    {
     Sat.resize(90, 60);
     image(Sat, 95, 320);
    }
  }
}//End of DateCalendar class