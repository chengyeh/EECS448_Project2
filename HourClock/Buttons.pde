/** Buttons class handles functionality of menu buttons that change clock settings
*
*
* @author Ashley Hutton, Hannah Johnson, Rabel Marte
*/

boolean overChangeMode = false;
boolean overChangeTime = false;
boolean overChangeFace = false;
boolean overZoomIn=false;
boolean overZoomOut=false;
int index = 1;
clockDesigns currentDesign;

/**
*  @pre none
*  @post executes the action of the button that is pressed
*  @return none
*/
void mousePressed() {
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
  if(overZoomIn){
      //increase radius
  }
  if(overZoomOut){
     //decrease radius 
  }
}

/**
*  @pre valid integers called x and y
*  @post updates boolean member variables that involve a button being clicked
*  @return none
*/
void update(int x, int y) {
  if ( overChangeMode(560, 760, 150, 60) ) {
     /** set overChangeMode true if button was pressed */
    overChangeMode = true;
    overChangeTime = false;
    overChangeFace = false;
    overZoomIn= false;
    overZoomOut= false;
  }

  else if (overChangeTime(390, 760, 150, 60) ){
     /** set changeTime true if button was pressed */
     overChangeMode = false;
     overChangeTime = true;
     overChangeFace = false;
     overZoomIn= false;
     overZoomOut= false;
  }
  else if (overChangeFace(730, 760, 150, 60) ){
     /** set changeFace true if button was pressed */
     overChangeMode = false;
     overChangeTime = false;
     overChangeFace = true;
     overZoomIn= false;
     overZoomOut= false;
  }
  else if (overZoomIn(1040, 0, 60, 60) ){
    /** set everything to false if not on button */
    overChangeMode = false;
    overChangeTime = false;
    overChangeFace = false;
    overZoomIn= true;
    overZoomOut= false;
  }
  else if (overZoomOut(1040, 70, 60, 60) ){
    /** set everything to false if not on button */
    overChangeMode = false;
    overChangeTime = false;
    overChangeFace = false;
    overZoomIn= false;
    overZoomOut= true;
  }
  else {
    /** set everything to false if not on button */
    overChangeMode = false;
    overChangeTime = false;
    overChangeFace = false;
    overZoomIn= false;
    overZoomOut= false;
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