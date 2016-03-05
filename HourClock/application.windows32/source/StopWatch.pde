/** Stopwatch class handles the running of the stopWatch. The stopwatch can start,stop and reset. 
*
*
* @author Paul Charles, Purna Doddapaneni, Dilesh Fernando, Cheng-yeh Lee
*/

public class StopWatch {
  //keep tack of which mode is selected.
  boolean stopWatchMode = false;
  boolean SW_Start = false;
  boolean SW_Stop = true;
  boolean SW_Reset = false;
  
  int SW_Minutes;
  int SW_Seconds;
  int SW_HundredthsSeconds;
  int SW_Milliseconds;
  int startTime = 0;
  int counter;
  int fontSize=100;
  /** 
    @pre none
    @post Stopwatch starts decrementing
    @return none
  */
  public void startStopWatch()
  {
    SW_Start = true;
    SW_Stop = false;
    SW_Reset = false;
    startTime = millis();
    counter = SW_Milliseconds;
  }
  /** 
    @pre Stop button is pressed
    @post Stopwatch stops 
    @return none
  */
  public void stopStopWatch()
  {
     SW_Stop = true;
  }
    /** 
    @pre reset button is pressed
    @post Reset to inital time.
    @return none
  */
  public void resetStopWatch()
  {
    SW_Reset = true;
    SW_Stop = true;
    SW_Start = false;
    startTime = millis();
  }
    /** 
    @pre Zoom out button is pressed
    @post fontSize is increased by 10
    @return none
  */
  public void addSWSize()
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
    @pre Zoom in button is pressed
    @post fontSize is decreased by 10
    @return none
  */
  public void subSWSize()
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
    @pre none
    @post display the StopWatch
    @return none
  */
  public void displayStopWatch()
  {
    //TODO
    if(!SW_Stop)
    {
      SW_Milliseconds = (millis() - startTime);
      
      if(SW_Start)
      {
        SW_Milliseconds += counter;
      }
      
      SW_Seconds = SW_Milliseconds / 1000;
      SW_Minutes = SW_Seconds / 60;
      SW_Seconds = SW_Seconds % 60;
      SW_HundredthsSeconds = SW_Milliseconds / 10 % 100;
    }
    if(SW_Reset)
    {
      SW_Milliseconds = 0;
      SW_Minutes = 0;
      SW_Seconds = 0;
      SW_HundredthsSeconds = 0;
    }
    
    //display timer in proper format
    fill(0,0,0);
    textSize(fontSize);
    textAlign(CENTER);
    text(nf(SW_Minutes,2,0) + ":" + nf(SW_Seconds,2,0) + ":" + nf(SW_HundredthsSeconds,2,0),550,400);
  }
  
}