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
  
  public void startStopWatch()
  {
    SW_Start = true;
    SW_Stop = false;
    SW_Reset = false;
    startTime = millis();
    counter = SW_Milliseconds;
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
    startTime = millis();
  }
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
   //Stopwatch Display function
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