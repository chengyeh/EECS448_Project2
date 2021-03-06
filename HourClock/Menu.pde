import static javax.swing.JOptionPane.*;
import java.util.regex.*;

/** Menu displays the buttons and popup windows that allow the user to 
 *  set the time and 12hr vs 24hr mode
 *
 * @author Ashley Hutton, Hannah Johnson, Rabel Marte
 * @author Functionality by: Paul Charles, Purna Doddapaneni, Dilesh Fernando, Cheng-yeh Lee
 */
public class Menu {

  Boolean m_12Hour;
  Boolean m_isAM;
  int m_hour;
  int m_minute;
  int m_second;

  private Pattern pattern12;
  private Pattern pattern24;

  private Matcher match12;
  private Matcher match24;


  Menu(){

    m_12Hour = true;
    m_isAM = true;

    m_hour = 0;
    m_minute = 0;
    m_second = 0;

  }

  /**
	*  @pre none
	*  @post set boolean member variables to true, numerical member variables to 0
	*  @return none
	*/
  public void displayMenu(){

    PImage switchTo12;
    PImage switchTo24;
    PImage changeTime;
    PImage changeFace;
    PImage SetDate;
    PImage ClockButton;
    PImage StopWatch;
    PImage StopWatch_Reset;
    PImage StopWatch_Start;
    PImage StopWatch_Stop;
    PImage Timer_Reset;
    PImage Timer;
    PImage Timer_Start;
    PImage Timer_Stop;
    PImage Plus;
    PImage Minus;
    

    switchTo12 = loadImage("switchTo12.png");
    switchTo24 = loadImage("switchTo24.png");
    changeTime = loadImage("changeTime.png");
    changeFace = loadImage("switchFace.png");
    SetDate  = loadImage("SetDate.png");
    ClockButton = loadImage("Clock.png");
    StopWatch = loadImage("StopWatch.png");
    StopWatch_Reset = loadImage("StopWatch_Reset.png");
    StopWatch_Start = loadImage("StopWatch_Start.png");
    StopWatch_Stop = loadImage("StopWatch_Stop.png");
    Timer_Reset = loadImage("Timer_Reset.png");
    Timer = loadImage("Timer.png");
    Timer_Start = loadImage("Timer_Start.png");
    Timer_Stop = loadImage("Timer_Stop.png");
    Plus = loadImage("PLUS.png");
    Minus = loadImage("MINUS.png");
    
    
    //Position the buttons
    Plus.resize(60, 60);
    image(Plus, 945, 290);
    
    Minus.resize(60, 60);
    image(Minus, 945, 360);

    ClockButton.resize(150, 60);
    image(ClockButton, 220, 760);

    changeTime.resize(150, 60);
    image(changeTime, 390, 760);

    if (getView()){
      switchTo24.resize(150, 60);
      image(switchTo24, 560, 760);
    }
    else{
      switchTo12.resize(150, 60);
      image(switchTo12, 560, 760);
    }

    SetDate.resize(150, 60);
    image(SetDate, 730, 760);
    
    StopWatch.resize(150, 60);
    image(StopWatch, 220, 850);
    
    StopWatch_Start.resize(150, 60);
    image(StopWatch_Start, 390, 850);
    
    StopWatch_Stop.resize(150, 60);
    image(StopWatch_Stop, 560, 850);
    
    StopWatch_Reset.resize(150, 60);
    image(StopWatch_Reset, 730, 850);
    
    Timer.resize(150, 60);
    image(Timer, 220, 940);
    
    Timer_Start.resize(150, 60);
    image(Timer_Start, 390, 940);
    
    Timer_Stop.resize(150, 60);
    image(Timer_Stop, 560, 940);
    
    Timer_Reset.resize(150, 60);
    image(Timer_Reset, 730, 940);
  }

  /**
	*  @pre none
	*  @post allows user to switch between 12 and 24 hour mode
	*  @return none
	*/
  public void toggleView(){

    Object[] toggleOptions = { "12 Hour", "24 Hour"};
    int viewMode = showOptionDialog(null, "Select Clock Mode:", "",
    DEFAULT_OPTION, INFORMATION_MESSAGE,
    null, toggleOptions, toggleOptions[0]);

    /** set m_12Hour to true if user selects 12 hour*/
    if (viewMode == 0){
      m_12Hour = true;
    }
    /** set m_12Hour to false if user selects 24 hour*/
    else if (viewMode == 1){
      m_12Hour = false;
    }
    /** do nothing if user clicks cancel*/
  }

  /**
	*  @pre none
	*  @post none
	*  @return m_12Hour
	*/
  public Boolean getView(){
    return(m_12Hour);
  }

  /**
	*  @pre valid boolean variable called is12Hour
	*  @post sets m_12Hour to is12Hour
	*  @return None
	*/
  public void setView(Boolean is12Hour){
    /** set m_12Hour to true if clock is displayed in 12 hour*/
    /** set m_12Hour to false if clock is displayed in 24 hour*/
    m_12Hour = is12Hour;
  }

  /**
	*  @pre none
	*  @post none
	*  @return m_hour
	*/
  public int getHour(){
    return(m_hour);
  }

  /**
  *  @pre none
  *  @post none
  *  @return m_minute
  */
  public int getMinute(){
    return(m_minute);
  }

  /**
  *  @pre none
  *  @post none
  *  @return m_second
  */
  public int getSecond(){
    return(m_second);
  }

  /**
  *  @pre none
  *  @post none
  *  @return m_isAM
  */
  public Boolean getTimeOfDay(){
    /** return true if AM */
    /** return false if PM */
    return(m_isAM);
  }

  /**
	*  @pre none
	*  @post sets m_minute, m_hour, and m_second to user desired 12 hour time
	*  @return none
	*/
  public void setTimeOfDay(Boolean isAM){
    /** set true if AM */
    /** set false if PM */
    m_isAM = isAM;
  }


  /**
	*  @pre none
	*  @post sets m_minute, m_hour, and m_second to user desired 24 hour time
	*  @return none
	*/
  public void set12HrTime(){

    /** checks if time is entered correctly */
    Boolean timeIsValid = false;
    /** the string that the user inputs with the time */
    String currentTime;

    /** regular expression looking for the format "##:##:## AM/PM in 12hr */
    String timePattern_12hr = "(^[1-9]|1[0-2]):([0-5][0-9]):([0-5][0-9])[ ]?(?i)(am|pm)$";

    /** loop until the time entered matches the given regex */
    while (!timeIsValid){

      currentTime = showInputDialog("Enter Time\nExample of format: 1:15:45 AM");

      if (currentTime == null){
        /** if user presses cancel:
         1) set time to set time to computer clock time if user first opens program
         2) do not change time if user has already been running clock */
        timeIsValid = true;


        m_hour = 0;
        m_minute = 0;
        m_second = 0;

        
        m_hour = hour() + hourDiff;
        m_minute = minute() + minDiff;
        m_second = second() + secDiff;

        m_hour = 0;
        m_minute = 0;
        m_second = 0;
        m_hour = hour() + hourDiff;
        m_minute = minute() + minDiff;
        m_second = second() + secDiff;

      }
      else{

        /** compile and match regex to the given input */
        pattern12 = Pattern.compile(timePattern_12hr);
        match12 = pattern12.matcher(currentTime);

        /** matches found -- valid input */
        if (match12.find()){

          timeIsValid = true;

          /** set hours to first group of regex */
          m_hour = Integer.parseInt(match12.group(1));
          /** set minutes to second group of regex */
          m_minute = Integer.parseInt(match12.group(2));
          /** set seconds to third group of regext */
          m_second = Integer.parseInt(match12.group(3));

          /** set m_isAM to true if user inputs 'am' */
          if (match12.group(4).equalsIgnoreCase("am")){

            m_isAM = true;
            hours = m_hour;
          }
          else {

            m_isAM = false;
            hours = m_hour + 12;

          }

          minutes = m_minute;
        }
      }
    }
  }

  /**
  *  @pre none
  *  @post sets m_minute, m_hour, and m_second to user desired 24 hour time
  *  @return none
  */
  public void set24HrTime(){

    /** checks if time is entered correctly */
    Boolean timeIsValid = false;
    /** the string that the user inputs with the time */
    String currentTime;

    /** regular expression looking for the format "##:##:## in 24hr */
    String timePattern_24hr = "(^[01]?[0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$";

    while(!timeIsValid){

      currentTime = showInputDialog("Enter Time\nExample of format: 1:15:45");

      if (currentTime == null){
        /** if user presses cancel:
         1) set time to computer clock time if user first opens program
         2) do not change time if user has already been running clock */
        timeIsValid = true;

        m_hour = hour() + hourDiff;
        m_minute = minute() + minDiff;
        m_second = second() + secDiff;
      }

      else{

        /** compile and match regex to the given input */
        pattern24 = Pattern.compile(timePattern_24hr);
        match24 = pattern24.matcher(currentTime);

        if (match24.find()){

          timeIsValid = true;

          /** set hours to first group of regex */
          m_hour = Integer.parseInt(match24.group(1));
          /** set minutes to second group of regex */
          m_minute = Integer.parseInt(match24.group(2));
          /** set seconds to third group of regext */
          m_second = Integer.parseInt(match24.group(3));

          if (m_hour > 12){
            m_isAM = false;
          }
          if (m_hour <= 12){
            m_isAM = true;
          }

          minutes = m_minute;
          hours = m_hour;
        }
      }
    }
  }
  
  public void setInit12HrTime(){

    /** checks if time is entered correctly */
    Boolean timeIsValid = false;
    /** the string that the user inputs with the time */
    String currentTime;

    /** regular expression looking for the format "##:##:## AM/PM in 12hr */
    String timePattern_12hr = "(^[1-9]|1[0-2]):([0-5][0-9]):([0-5][0-9])[ ]?(?i)(am|pm)$";

    /** loop until the time entered matches the given regex */
    while (!timeIsValid){

      currentTime = showInputDialog("Enter Time\nExample of format: 1:15:45 AM");

      if (currentTime == null){
        /** if user presses cancel:
         1) clear input field and display input dialog again */
         
        timeIsValid = false;
      }
      else{

        /** compile and match regex to the given input */
        pattern12 = Pattern.compile(timePattern_12hr);
        match12 = pattern12.matcher(currentTime);

        /** matches found -- valid input */
        if (match12.find()){

          timeIsValid = true;

          /** set hours to first group of regex */
          m_hour = Integer.parseInt(match12.group(1));
          /** set minutes to second group of regex */
          m_minute = Integer.parseInt(match12.group(2));
          /** set seconds to third group of regext */
          m_second = Integer.parseInt(match12.group(3));

          /** set m_isAM to true if user inputs 'am' */
          if (match12.group(4).equalsIgnoreCase("am")){

            m_isAM = true;
            hours = m_hour;
          }
          else {

            m_isAM = false;
            hours = m_hour + 12;

          }

          minutes = m_minute;
        }
      }
    }
  }
  
  public void setInit24HrTime(){

    /** checks if time is entered correctly */
    Boolean timeIsValid = false;
    /** the string that the user inputs with the time */
    String currentTime;

    /** regular expression looking for the format "##:##:## in 24hr */
    String timePattern_24hr = "(^[01]?[0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$";

    while(!timeIsValid){

      currentTime = showInputDialog("Enter Time\nExample of format: 1:15:45");

      if (currentTime == null){
        /** if user presses cancel:
         1) clear input field and display input dialog again */
         
        timeIsValid = false;
      }

      else{

        /** compile and match regex to the given input */
        pattern24 = Pattern.compile(timePattern_24hr);
        match24 = pattern24.matcher(currentTime);

        if (match24.find()){

          timeIsValid = true;

          /** set hours to first group of regex */
          m_hour = Integer.parseInt(match24.group(1));
          /** set minutes to second group of regex */
          m_minute = Integer.parseInt(match24.group(2));
          /** set seconds to third group of regext */
          m_second = Integer.parseInt(match24.group(3));

          if (m_hour > 12){
            m_isAM = false;
          }
          if (m_hour <= 12){
            m_isAM = true;
          }

          minutes = m_minute;
          hours = m_hour;
        }
      }
    }
  }
 
}