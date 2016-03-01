import static javax.swing.JOptionPane.*;
import java.util.regex.*;

public class Timer {
  //keep tack of which mode is selected.
  boolean timerMode = false;
  
  //Variables for timer
  private int hours = 0;
  private int minutes = 0;
  private int seconds = 0;
  
  //Variables for input pattern matching
  private Pattern patternTimer;
  private Matcher matchTimer;
  
  public void startTimer(){}
  public void stopTimer(){}
  public void resetTimer(){}
  
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
        /** if user presses cancel:
         1) set time to computer clock time if user first opens program
         2) do not change time if user has already been running clock */
        timerIsValid = true;
      }

      else{

        /** compile and match regex to the given input */
        patternTimer = Pattern.compile(timerPattern);
        matchTimer = patternTimer.matcher(inputTimer);

        if (matchTimer.find()){

          timerIsValid = true;

          /** set hours to first group of regex */
          hours = Integer.parseInt(matchTimer.group(1));
          /** set minutes to second group of regex */
          minutes = Integer.parseInt(matchTimer.group(2));
          /** set seconds to third group of regext */
          seconds = Integer.parseInt(matchTimer.group(3));
        }
      }
    }
    
    System.out.println("hours: " + hours);
    System.out.println("minutes: " + minutes);
    System.out.println("seconds: " + seconds);
  }//End of setTimerDailog()
  
  //Timer Display function
  public void displayTimer(){
    //TODO
  }
}