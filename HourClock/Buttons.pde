/** Buttons class handles functionality of menu buttons that change clock settings
*
*
* @author Ashley Hutton, Hannah Johnson, Rabel Marte
*/
boolean overPower       = false;

boolean overClock       = false;
boolean overChangeMode  = false;
boolean overChangeTime  = false;
boolean overChangeFace  = false;
boolean overSetDate     = false;

boolean overZoomIn      = false;
boolean overZoomOut     = false;

boolean overStopWatch       = false;
boolean overStopWatchStart  = false;
boolean overStopWatchStop   = false;
boolean overStopWatchReset  = false;

boolean overTimer           = false;
boolean overTimerStart      = false;
boolean overTimerStop       = false;
boolean overTimerReset      = false;

int index = 1;
clockDesigns currentDesign;

/**
*  @pre none
*  @post executes the action of the button that is pressed
*  @return none
*/
void mousePressed() {
  //Power

  
  //Check clock 
  if(overClock){
    clock.clockFaceMode = true;
    stpWatch.stopWatchMode = false;
    timer.timerMode = false;
    
  }
  
  if (overChangeMode) {
    /**set mode to opposite the current mode */
    mainMenu.setView(!mainMenu.getView());
  }
  
  if (overChangeTime){

    /** call menu's set time function to update the time */
    /** Calculates the differnce in time between user input and current time (12 & 24 mode) */
    if (mainMenu.getView())
    {
      mainMenu.set12HrTime();
      clock.calcDiff();
    }
    else
    {
      mainMenu.set24HrTime();
      clock.calcDiff();
    }
  }
  if (overChangeFace){
    /** change the clock face design */
    currentDesign = clockDesigns.values()[index];
    
    index++;

    if (index == 5){
      index = 0;
    }
  }
  
  if(overSetDate){
     //set date  
     date.setDateDialog();
     date.getDayOfTheWeek();
  }
  
  //Check zoom in and out
  if(overZoomIn){
      //increase radius
      clock.addRadius();
      timer.addTSize();
      stpWatch.addSWSize();
  }
  if(overZoomOut){
     //decrease radius 
     clock.subRadius();
     timer.subTSize();
     stpWatch.subSWSize();
  }
  
  //Check stopwatch
  if(overStopWatch){
    clock.clockFaceMode = false;
    stpWatch.stopWatchMode = true;
    timer.timerMode = false;
  }
  
  if(overStopWatchStart){
    stpWatch.startStopWatch();
  }
  
  if(overStopWatchStop){
    stpWatch.stopStopWatch();
  }
  
  if(overStopWatchReset){
    stpWatch.resetStopWatch();
  }
  
  //Check timer
  if(overTimer){
    //Set mode
    clock.clockFaceMode = false;
    stpWatch.stopWatchMode = false;
    timer.timerMode = true;
    
     //set timer 
     timer.setTimerDailog();
  }

  if(overTimerStart){
    timer.startTimer();
  }

  if(overTimerStop){
    timer.stopTimer();
  }

  if(overTimerReset){
    timer.resetTimer();
  }
}

/**
*  @pre valid integers called x and y
*  @post updates boolean member variables that involve a button being clicked
*  @return none
*/
void update(int x, int y) {
  //Clock buttons
  if(overPower(0, 0, 60, 60)){
    /**Set button */
    overPower       = true; 
    
    overClock       = false;
    overChangeMode  = false;
    overChangeTime  = false;
    overChangeFace  = false;
    overSetDate     = false;
    
    overZoomIn      = false;
    overZoomOut     = false;
    
    overStopWatch       = false;
    overStopWatchStart  = false;
    overStopWatchStop   = false;
    overStopWatchReset  = false;
    
    overTimer           = false;
    overTimerStart      = false;
    overTimerStop       = false;
    overTimerReset      = false;
  }
  else if(overClock(220, 760, 150, 60)){
    /**Set button */
    overPower       = false;
    
    overClock       = true;
    overChangeMode  = false;
    overChangeTime  = false;
    overChangeFace  = false;
    overSetDate     = false;
    
    overZoomIn      = false;
    overZoomOut     = false;
    
    overStopWatch       = false;
    overStopWatchStart  = false;
    overStopWatchStop   = false;
    overStopWatchReset  = false;
    
    overTimer           = false;
    overTimerStart      = false;
    overTimerStop       = false;
    overTimerReset      = false;
  }
  else if ( overChangeMode(560, 760, 150, 60) ) {
     /** set overChangeMode true if button was pressed */
    overPower       = false;
    
    overClock       = false;
    overChangeMode  = true;
    overChangeTime  = false;
    overChangeFace  = false;
    overSetDate     = false;
    
    overZoomIn      = false;
    overZoomOut     = false;
    
    overStopWatch       = false;
    overStopWatchStart  = false;
    overStopWatchStop   = false;
    overStopWatchReset  = false;
    
    overTimer           = false;
    overTimerStart      = false;
    overTimerStop       = false;
    overTimerReset      = false;
  }
  else if (overChangeTime(390, 760, 150, 60) ){
     /** set changeTime true if button was pressed */
    overPower       = false;
    
    overClock       = false;
    overChangeMode  = false;
    overChangeTime  = true;
    overChangeFace  = false;
    overSetDate     = false;
    
    overZoomIn      = false;
    overZoomOut     = false;
    
    overStopWatch       = false;
    overStopWatchStart  = false;
    overStopWatchStop   = false;
    overStopWatchReset  = false;
    
    overTimer           = false;
    overTimerStart      = false;
    overTimerStop       = false;
    overTimerReset      = false;
  }
  //else if (overChangeFace(730, 760, 150, 60) ){
  //   /** set changeFace true if button was pressed */
  //   overChangeMode = false;
  //   overChangeTime = false;
  //   overChangeFace = true;
  //   overZoomIn= false;
  //   overZoomOut= false;
  //   overSetDate = false;
  //}
  else if (overSetDate(730, 760, 150, 60) ){
    /** set everything to false if not on button */
    overPower       = false;
    
    overClock       = false;
    overChangeMode  = false;
    overChangeTime  = false;
    overChangeFace  = false;
    overSetDate     = true;
    
    overZoomIn      = false;
    overZoomOut     = false;
    
    overStopWatch       = false;
    overStopWatchStart  = false;
    overStopWatchStop   = false;
    overStopWatchReset  = false;
    
    overTimer           = false;
    overTimerStart      = false;
    overTimerStop       = false;
    overTimerReset      = false;
  }
  //Zoom in and out button
  else if (overZoomIn(945, 290, 60, 60) ){
    /** set everything to false if not on button */
    overPower       = false;
    
    overClock       = false;
    overChangeMode  = false;
    overChangeTime  = false;
    overChangeFace  = false;
    overSetDate     = false;
    
    overZoomIn      = true;
    overZoomOut     = false;
    
    overStopWatch       = false;
    overStopWatchStart  = false;
    overStopWatchStop   = false;
    overStopWatchReset  = false;
    
    overTimer           = false;
    overTimerStart      = false;
    overTimerStop       = false;
    overTimerReset      = false;
  }
  else if (overZoomOut(945, 360, 60, 60) ){
    /** set everything to false if not on button */
    overPower       = false;
    
    overClock       = false;
    overChangeMode  = false;
    overChangeTime  = false;
    overChangeFace  = false;
    overSetDate     = false;
    
    overZoomIn      = false;
    overZoomOut     = true;
    
    overStopWatch       = false;
    overStopWatchStart  = false;
    overStopWatchStop   = false;
    overStopWatchReset  = false;
    
    overTimer           = false;
    overTimerStart      = false;
    overTimerStop       = false;
    overTimerReset      = false;
  }
  else if (overStopWatch(220, 850, 150, 60)){
    overPower       = false;
    
    overClock       = false;
    overChangeMode  = false;
    overChangeTime  = false;
    overChangeFace  = false;
    overSetDate     = false;
    
    overZoomIn      = false;
    overZoomOut     = false;
    
    overStopWatch       = true;
    overStopWatchStart  = false;
    overStopWatchStop   = false;
    overStopWatchReset  = false;
    
    overTimer           = false;
    overTimerStart      = false;
    overTimerStop       = false;
    overTimerReset      = false;
  }
  else if (overStopWatchStart(390, 850, 150, 60)){
    overPower       = false;
    
    overClock       = false;
    overChangeMode  = false;
    overChangeTime  = false;
    overChangeFace  = false;
    overSetDate     = false;
    
    overZoomIn      = false;
    overZoomOut     = false;
    
    overStopWatch       = false;
    overStopWatchStart  = true;
    overStopWatchStop   = false;
    overStopWatchReset  = false;
    
    overTimer           = false;
    overTimerStart      = false;
    overTimerStop       = false;
    overTimerReset      = false;
  }
  else if (overStopWatchStop(560, 850, 150, 60)){
    overPower       = false;
    
    overClock       = false;
    overChangeMode  = false;
    overChangeTime  = false;
    overChangeFace  = false;
    overSetDate     = false;
    
    overZoomIn      = false;
    overZoomOut     = false;
    
    overStopWatch       = false;
    overStopWatchStart  = false;
    overStopWatchStop   = true;
    overStopWatchReset  = false;
    
    overTimer           = false;
    overTimerStart      = false;
    overTimerStop       = false;
    overTimerReset      = false;
  }
  else if (overStopWatchReset(730, 850, 150, 60)){
    overPower       = false;
    
    overClock       = false;
    overChangeMode  = false;
    overChangeTime  = false;
    overChangeFace  = false;
    overSetDate     = false;
    
    overZoomIn      = false;
    overZoomOut     = false;
    
    overStopWatch       = false;
    overStopWatchStart  = false;
    overStopWatchStop   = false;
    overStopWatchReset  = true;
    
    overTimer           = false;
    overTimerStart      = false;
    overTimerStop       = false;
    overTimerReset      = false;
  }
  else if (overTimer(220, 940, 150, 60) ){
    /** set everything to false if not on button */
    overPower       = false;
    
    overClock       = false;
    overChangeMode  = false;
    overChangeTime  = false;
    overChangeFace  = false;
    overSetDate     = false;
    
    overZoomIn      = false;
    overZoomOut     = false;
    
    overStopWatch       = false;
    overStopWatchStart  = false;
    overStopWatchStop   = false;
    overStopWatchReset  = false;
    
    overTimer           = true;
    overTimerStart      = false;
    overTimerStop       = false;
    overTimerReset      = false;
  }
  else if (overTimerStart(390, 940, 150, 60)){
    overPower       = false;
    
    overClock       = false;
    overChangeMode  = false;
    overChangeTime  = false;
    overChangeFace  = false;
    overSetDate     = false;
    
    overZoomIn      = false;
    overZoomOut     = false;
    
    overStopWatch       = false;
    overStopWatchStart  = false;
    overStopWatchStop   = false;
    overStopWatchReset  = false;
    
    overTimer           = false;
    overTimerStart      = true;
    overTimerStop       = false;
    overTimerReset      = false;
  }
  else if (overTimerStop(560, 940, 150, 60)){
    overPower       = false;
    
    overClock       = false;
    overChangeMode  = false;
    overChangeTime  = false;
    overChangeFace  = false;
    overSetDate     = false;
    
    overZoomIn      = false;
    overZoomOut     = false;
    
    overStopWatch       = false;
    overStopWatchStart  = false;
    overStopWatchStop   = false;
    overStopWatchReset  = false;
    
    overTimer           = false;
    overTimerStart      = false;
    overTimerStop       = true;
    overTimerReset      = false;
  }
  else if (overTimerReset(730, 940, 150, 60)){
    overPower       = false;
    
    overClock       = false;
    overChangeMode  = false;
    overChangeTime  = false;
    overChangeFace  = false;
    overSetDate     = false;
    
    overZoomIn      = false;
    overZoomOut     = false;
    
    overStopWatch       = false;
    overStopWatchStart  = false;
    overStopWatchStop   = false;
    overStopWatchReset  = false;
    
    overTimer           = false;
    overTimerStart      = false;
    overTimerStop       = false;
    overTimerReset      = true;
  }
  else {
    /** set everything to false if not on button */
    overPower       = false;
    
    overClock       = false;
    overChangeMode  = false;
    overChangeTime  = false;
    overChangeFace  = false;
    overSetDate     = false;
    
    overZoomIn      = false;
    overZoomOut     = false;
    
    overStopWatch       = false;
    overStopWatchStart  = false;
    overStopWatchStop   = false;
    overStopWatchReset  = false;
    
    overTimer           = false;
    overTimerStart      = false;
    overTimerStop       = false;
    overTimerReset      = false;
  }
}

boolean overPower(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overClock(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

/**
*  @pre valid integers called x, y, width, and height
*  @post check if change mode is clicked
*  @return true if the button is clicked
*/
boolean overChangeMode(int x, int y, int width, int height)  {

  /** checks if mouse clicks 12hr button */
  if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

/**
*  @pre valid integers called x, y, width, and height
*  @post check if change time is clicked
*  @return true if the button is clicked
*/
boolean overChangeTime(int x, int y, int width, int height)  {

  /** checks if mouse clicks changeTime button */
  if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

/**
*  @pre valid integers called x, y, width, and height
*  @post check if change face is clicked
*  @return true if the button is clicked
*/
boolean overChangeFace(int x, int y, int width, int height)  {

  /** checks if mouse clicks changeFace button */
  if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overSetDate(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overZoomIn(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overZoomOut(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overStopWatch(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overStopWatchStart(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overStopWatchStop(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overStopWatchReset(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overTimer(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overTimerStart(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overTimerStop(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overTimerReset(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}