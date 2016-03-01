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
  
  public void startStopWatch()
  {
    SW_Start = true;
    SW_Stop = false;
    SW_Reset = false;
  }
  public void stopStopWatch()
  {
     SW_Stop = true;
  }
  public void resetStopWatch()
  {
    SW_Reset = true;
    SW_Stop = true;
    SW_Start = false;
  }
  
   //Stopwatch Display function
  public void displayStopWatch(){
    //TODO
  }
}