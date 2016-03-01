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
  
  //Total number of seconds that the user input
  private int totalSeconds = 0;
  
  //Variables for input pattern matching
  private Pattern patternTimer;
  private Matcher matchTimer;
  
  Timer timer;
  
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
  
  //Covert user input time to seconds
  public void convertTimeInSeconds(int hours, int minutes, int seconds){
    totalSeconds = (hours * 3600)+ (minutes * 60) + seconds;
  }
  
  //Start timer
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
  
  //Stop timer
  public void stopTimer(){
    //Stop the timer schedule
    timer.cancel();
  }
  
  //Reset timer
  public void resetTimer(){
    //Stop the timer schedule
    timer.cancel();
    //Reset the total number of second to the original #
    totalSeconds = (hours * 3600)+ (minutes * 60) + seconds;
    //Start the timer
    startTimer();
  }
  
  
  //Timer Display function
  public void displayTimer(){
    //Covert the total number seconds to hours, minutes, and seconds
    int displayHours = totalSeconds / 3600;
    int displayMinutes = (totalSeconds - (displayHours*3600)) / 60;
    int displaySeconds = (totalSeconds - (displayMinutes*60)) % 60;
    
    //display timer in proper format
    fill(0,0,0);
    textSize(100);
    text(nf(displayHours,2,0) + ":" + nf(displayMinutes,2,0) + ":" + nf(displaySeconds,2,0),340,360);
  }
}