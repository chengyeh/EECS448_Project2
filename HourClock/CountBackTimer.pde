import java.util.Timer;
import java.util.TimerTask;
import static javax.swing.JOptionPane.*;
import java.util.regex.*;

public class CountBackTimer {
  //keep tack of which mode is selected.
  boolean timerMode = false;
  
  //Variables for timer input from user
  private int hours = 0;
  private int minutes = 0;
  private int seconds = 0;
  
  private int fontSize=100;
  
  //Total number of seconds that the user input
  private int totalSeconds = 0;
  
  //Variables for input pattern matching
  private Pattern patternTimer;
  private Matcher matchTimer;
  
  Timer timer;
  /** 
    @pre Set Timer value button is pressed
    @post checks for valid input. If valid, sets timing variables according to input.
    @return none
  */
  public void setTimerDailog(){
    /** checks if time is entered correctly */
    Boolean timerIsValid = false;
    
    /** the string that the user inputs with the time */
    String inputTimer;

    /** regular expression looking for the format "##:##:## in 24hr */
    String timerPattern = "(^[01]?[0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$";

    while(!timerIsValid){
      inputTimer = showInputDialog("Set Timer\nEnter time for timer in following format HH:MM:SS");

      if (inputTimer == null){
        //user presses cancel
        timerIsValid = true;
      }
      else
      {
        //compile and match regex to the given input 
        patternTimer = Pattern.compile(timerPattern);
        matchTimer = patternTimer.matcher(inputTimer);

        if (matchTimer.find()){
          timerIsValid = true;

          //set hours to first group of regex
          hours = Integer.parseInt(matchTimer.group(1));
          //set minutes to second group of regex
          minutes = Integer.parseInt(matchTimer.group(2));
          //set seconds to third group of regext
          seconds = Integer.parseInt(matchTimer.group(3));
        }
      }
    }
    //Cover the user input time set global variable totalSeconds
    convertTimeInSeconds(hours, minutes, seconds);
  }//End of setTimerDailog()
  
  /** 
    @pre Obtain the hour minutes and second values after input
    @post Multiplies to obtain total number of seconds
    @return none
  */
  public void convertTimeInSeconds(int hours, int minutes, int seconds){
    totalSeconds = (hours * 3600)+ (minutes * 60) + seconds;
  }
  
  /** 
    @pre Start Timer button is pressed
    @post decrements totalSeconds at appropriate time intervals until zero
    @return none
  */
  public void startTimer(){ 
    //create timer object
    timer = new Timer();
    //Sehedule Timer to excecute every second
    timer.scheduleAtFixedRate(new TimerTask()
     {
         public void run()
         {
           if(totalSeconds > 0){
             totalSeconds--;
           }
           else{
             timer.cancel();
           }
         }
     }, 0, 1000);
  }
  
   /** 
    @pre Stop Timer button is pressed
    @post Cancels calling startTimer()
    @return none
  */
  public void stopTimer(){
    //Stop the timer schedule
    timer.cancel();
  }
  
   /** 
    @pre Reset Timer button is pressed
    @post Stops Timer and resets to inital value of reset timer
    @return none
  */
  public void resetTimer(){
    //Stop the timer schedule
    timer.cancel();
    //Reset the total number of second to the original #
    totalSeconds = (hours * 3600)+ (minutes * 60) + seconds;
    //Start the timer
    startTimer();
  }
  /** 
    @pre Zoom in button is pressed
    @post Increments text size to a max of 100
    @return none
  */
  public void addTSize()
  {
    if(fontSize==100)
    {
      fontSize=100;
    }
    else
    {
      fontSize=fontSize+10;
    }
      
  }
  /** 
    @pre Zoom out button is pressed
    @post decrements text size to a min of 50
    @return none
  */
  public void subTSize()
  {
    if(fontSize==50)
    {
      fontSize=50;
    }
    else
    {
      fontSize=fontSize-10;
    }
      
  }
  /** 
    @pre boolean value is set to true
    @post displays the background for the CountBackTimer based on various local variables.
    @return none
  */
  public void displayTimer(){
    //Covert the total number seconds to hours, minutes, and seconds
    int displayHours = totalSeconds / 3600;
    int displayMinutes = (totalSeconds - (displayHours*3600)) / 60;
    int displaySeconds = (totalSeconds - (displayMinutes*60)) % 60;
    int shifts=0;
    shifts=(fontSize-shifts)/2;
    //display timer in proper format
    fill(0,0,0);
    textSize(fontSize);
    text(nf(displayHours,2,0) + ":" + nf(displayMinutes,2,0) + ":" + nf(displaySeconds,2,0),340-shifts,260+shifts+shifts*2);
  }
}