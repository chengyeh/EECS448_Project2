import java.util.GregorianCalendar;

import static javax.swing.JOptionPane.*;
import java.util.regex.*;

  public class DateCalendar {
  private int year = 0;
  private int month = 0;
  private int day = 0;
  
  private Pattern patternDate;
  private Matcher matchDate;
  
  DateCalendar(){}
  
  GregorianCalendar calendar = new GregorianCalendar();
  
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
  
  public void setDateCalendar(int year, int month, int day){
    calendar.set(GregorianCalendar.YEAR, year);
    calendar.set(GregorianCalendar.MONTH, (month - 1));
    calendar.set(GregorianCalendar.DATE, day);
  }
  
  public int getDayOfTheWeek(){
    return(calendar.get(GregorianCalendar.DAY_OF_WEEK));
  }
  
  public void incrementDay(){
    calendar.add(GregorianCalendar.DAY_OF_MONTH, 1);
  }
  
  public void displayDateCalendar(){
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