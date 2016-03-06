import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.Timer; 
import java.util.TimerTask; 
import static javax.swing.JOptionPane.*; 
import java.util.regex.*; 
import java.util.GregorianCalendar; 
import static javax.swing.JOptionPane.*; 
import java.util.regex.*; 
import static javax.swing.JOptionPane.*; 
import java.util.regex.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class HourClock extends PApplet {

/** HourClock functions as our programs main method. In processing, main is split into a setup method and a draw method.
*
*
* @author Ashley Hutton, Hannah Johnson, Rabel Marte
* @author Added Functionality by: Paul Charles, Purna Doddapaneni, Dilesh Fernando, Cheng-yeh Lee
*/

//Variables for all class
Menu mainMenu      = new Menu();;
ClockFace clock    = new ClockFace();
StopWatch stpWatch = new StopWatch();
CountBackTimer timer = new CountBackTimer();
DateCalendar date  = new DateCalendar();
Power  power= new Power();
int radius;

int seconds = 0;
int minutes = 0;
int hours = 0;

public void setup() {
  //Set window size and the window
  
  fill(255);
  
  mainMenu.toggleView();

  /** Calculates the differnce in time between user input and current time (12 & 24 mode) */
  if (mainMenu.getView())
  {
   mainMenu.setInit12HrTime();
   clock.calcDiff();
  }
  else
  {
   mainMenu.setInit24HrTime();
   clock.calcDiff();
  }

}

public void draw() {
    //Get mouse click info
    update(mouseX, mouseY);
    //Set the backgroun color of the main window
    background(255);
    
    //Display POWER button
    PImage Power = loadImage("POWER.png");
    Power.resize(60, 60);
    image(Power, 0, 0);
    
    //Display the Mian menu
    mainMenu.displayMenu();
    //Display the slected functionality
    if(clock.clockFaceMode == true){
      //Set radius
      radius = clock.getRadius();
  
      /** Check if clock rolls over from AM/PM */
      seconds = second() + secDiff;
      //System.out.println(seconds);
      date.displayDateCalendar();
      
      if (seconds%60==0){
        minutes++;
      }
      if(minutes == 60)
      {
         minutes=0; 
      }
      if (minutes %60==0){
        hours++;
      }
      
      if (hours == 24){
        hours = 0;
        date.incrementDay();
      }
      
      if (hours >= 12){           
        mainMenu.setTimeOfDay(false);
      }
      else if (hours < 12){
        mainMenu.setTimeOfDay(true);
      }
  
      /** Repeatedly prints the clock and its hands as they tick (12 & 24 mode) */
      if (mainMenu.getView()) {
  
          clock.display12Hour(clock.getRadius(), currentDesign);
          clock.displayAMPM(clock.getRadius(), currentDesign);
          clock.display12Hands(clock.getRadius(), currentDesign);
      }
      else {
  
          clock.display24Hour(clock.getRadius(), currentDesign);
          clock.display24Hands(clock.getRadius(), currentDesign);
      }
    }
    else if(stpWatch.stopWatchMode == true){
      //StopWatch is selected
      stpWatch.displayStopWatch();
    }
    else if(timer.timerMode == true){
      //Timer is selected
      timer.displayTimer();
    }
    else if(power.powerMode == false){
         power.displayOff(); 
    }
}
/** Buttons class handles functionality of menu buttons that change clock settings
*
*
* @author Ashley Hutton, Hannah Johnson, Rabel Marte
* @author Added Functionality by: Paul Charles, Purna Doddapaneni, Dilesh Fernando, Cheng-yeh Lee
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
public void mousePressed() {
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
  
  if(overPower){
    if(power.powerMode==false)
    {
       clock.clockFaceMode=true;
       stpWatch.stopWatchMode=false;
       timer.timerMode = false;
       power.switchPowerMode();
    }
    else if(power.powerMode==true)
    {
         clock.clockFaceMode=false;
       stpWatch.stopWatchMode=false;
       timer.timerMode = false;
       power.switchPowerMode();
    }
  }
}

/**
*  @pre valid integers called x and y
*  @post updates boolean member variables that involve a button being clicked
*  @return none
*/
public void update(int x, int y) {
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
/**
*  @pre valid integers called x, y, width, and height
*  @post check if change mode is clicked
*  @return true if the button is clicked
*/
public boolean overPower(int x, int y, int width, int height) {
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
public boolean overClock(int x, int y, int width, int height) {
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
public boolean overChangeMode(int x, int y, int width, int height)  {

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
public boolean overChangeTime(int x, int y, int width, int height)  {

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
public boolean overChangeFace(int x, int y, int width, int height)  {

  /** checks if mouse clicks changeFace button */
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
public boolean overSetDate(int x, int y, int width, int height) {
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
public boolean overZoomIn(int x, int y, int width, int height) {
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
public boolean overZoomOut(int x, int y, int width, int height) {
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
public boolean overStopWatch(int x, int y, int width, int height) {
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
public boolean overStopWatchStart(int x, int y, int width, int height) {
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
public boolean overStopWatchStop(int x, int y, int width, int height) {
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
public boolean overStopWatchReset(int x, int y, int width, int height) {
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
public boolean overTimer(int x, int y, int width, int height) {
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
public boolean overTimerStart(int x, int y, int width, int height) {
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
public boolean overTimerStop(int x, int y, int width, int height) {
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
public boolean overTimerReset(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

int hourDiff;
int minDiff;
int secDiff;

/** ClockFace controls the display of clock faces and hands, as well as the clock geometry/ticking
*
*
* @author Ashley Hutton, Hannah Johnson, Rabel Marte
* @author Added Functionality by: Paul Charles, Purna Doddapaneni, Dilesh Fernando, Cheng-yeh Lee
*/
public class ClockFace {
  //keep tack of which mode is selected.
  //By default set the clock to display.
  boolean clockFaceMode = true;
  
  /** ---data members--- */

  /** related to clock */
  int m_xpos;
  int m_ypos;
  int m_radius;
  int c_radius=600;
  /** 
    @pre none
    @post none
    @return none
  */
  ClockFace(){

  }
  /** 
    @pre none
    @post none
    @return value of clock radius
  */
  public int getRadius()
  {
    return c_radius;
  }
  /** 
    @pre Zoom in button pressed
    @post Increments radius
    @return none
  */
  public void addRadius()
  {
    if(c_radius==600)
    {
      c_radius=600;
    }
    else
    {
      c_radius=radius+50;
    }
      
  }
  /** 
    @pre Zoom out button pressed
    @post decrements radius
    @return none
  */
  public void subRadius()
  {
    if(c_radius==300)
    {
      c_radius=300;
    }
    else
    {
      c_radius=radius-50;
    }
      
  }
  /** 
    @pre valid integers called xpos, ypox, radius, and valid enumerated type called cDesigns
    @post displays valid 12 hour clock face
    @return none
  */
  public void display12Hour(int radius, clockDesigns cDesigns) {

    /** load picture with 1-12 clockface */
     PImage hands12;
     hands12 = loadImage("hands12.png");
    int shifts= (600-radius)/2;
     
     
     
     /** check which face the user desires, load image accordingly */
     if(cDesigns == clockDesigns.BLACK) { hands12 = loadImage("hands12.png"); }
     else if(cDesigns == clockDesigns.GREEN) { hands12 = loadImage("hands12-green.png"); }
     else if(cDesigns == clockDesigns.BLUE) { hands12 = loadImage("hands12-blue.png"); }
     else if(cDesigns == clockDesigns.PINK) { hands12 = loadImage("hands12-pink.png"); }
     else if(cDesigns == clockDesigns.PIZZA) { hands12 = loadImage("hands12-pizza.png"); }
     

     /** resize photo to size of clock and move
     to same location as clock */
     hands12.resize(radius, radius);
     image(hands12, 250+shifts, 50+shifts);
    
  }

  /** 
    @pre valid integers called xpos, ypox, radius, and valid enumerated type called cDesigns
    @post displays valid 24 hour clock face
    @return none
  */
  public void display24Hour(int radius, clockDesigns cDesigns) {
    /** load picture with 1-24 clockface */
    PImage hands24;
    int shifts= (600-radius)/2;
    hands24 = loadImage("hands24.png");
    
     /** check which face the user desires, load image accordingly */
     if(cDesigns == clockDesigns.BLACK) { hands24 = loadImage("hands24.png"); }
     else if(cDesigns == clockDesigns.GREEN) { hands24 = loadImage("hands24-green.png"); }
     else if(cDesigns == clockDesigns.BLUE) { hands24 = loadImage("hands24-blue.png"); }
     else if(cDesigns == clockDesigns.PINK) { hands24 = loadImage("hands24-pink.png"); }
     else if(cDesigns == clockDesigns.PIZZA) { hands24 = loadImage("hands24-pizza.png"); }

    /** resize photo to size of clock and move
    to same location as clock */
    hands24.resize(radius, radius);
    image(hands24, 250+shifts, 50+shifts);

  }

  /** 
    @pre valid int called radius and valid enumerated type called cDesigns
    @post displays the correct hands for the 12 hour clock
    @return none
  */
  public void display12Hands(int radius, clockDesigns cDesigns) {

    /** Origin of the clock */
    float centerX = 550;
    float centerY = 350;
    float xAdjust=0;
    float yAdjust=0;

    /** coorelates time (seconds, minutes, hours) to radians)
    Subtract 1/2 PI so that 12 pm starts at 90 degrees instead of at 0 degrees (3 pm)
    Multiply 2PI in (hourToradians) by 2 because the clock makes two rounds. */
    float sTr = map(second() + secDiff, 0, 60, 0, TWO_PI) - HALF_PI;
    float mTr = map(minute()+ minDiff + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI;
    float hTr = map(hour() + hourDiff + norm(minute()+ minDiff , 0, 60), 0, 24, 0, TWO_PI*2) - HALF_PI;

    /** Set corresponding radius of each hand */
    float sRad = radius * .4f;
    float mRad = radius * .3f;
    float hRad = radius * .2f;

    /** Draws the hand (and its thickness) for each time component */
    stroke(0); /** color of hands is black */
    
     //** check which face the user desires, load image accordingly */
     if(cDesigns == clockDesigns.BLACK) { stroke(0); }
     else if(cDesigns == clockDesigns.GREEN) { stroke(27, 140, 41); }
     else if(cDesigns == clockDesigns.BLUE) { stroke(67, 96, 221); }
     else if(cDesigns == clockDesigns.PINK) { stroke(221, 67, 154); }
     else if(cDesigns == clockDesigns.PIZZA) { stroke (0); }

    strokeWeight(4); /**thickness of second hand */
    line(centerX, centerY, centerX + cos(sTr) * sRad, centerY + sin(sTr) * sRad);

    strokeWeight(6); /**thickness of minute hand */
    line(centerX, centerY, centerX + cos(mTr) * mRad, centerY + sin(mTr) * mRad);

    strokeWeight(10); /**thickness of hour hand */
    line(centerX,centerY, centerX + cos(hTr) * hRad, centerY + sin(hTr) * hRad);

  }

  /** 
    @pre valid int called radius and valid enumerated type called cDesigns
    @post displays the correct hands for the 24 hour clock
    @return none
  */
  public void display24Hands(int radius, clockDesigns cDesigns) {

    /** Origin of the clock */
    float centerX = 550;
    float centerY = 350;
    float xAdjust= 0;
    float yAdjust= 0;
    /** The corresponding radius of each hand */
    float sRad = radius * .4f;
    float mRad = radius * .3f;
    float hRad = radius * .2f;


    /**Relates time (seconds, minutes, hours) to radians)
    Subtract 1/2 PI so that 12 pm starts at 90 degrees instead of at 0 degrees (3 pm) */
    float sTr = map(second() + secDiff, 0, 60, 0, TWO_PI) - HALF_PI;
    float mTr = map(minute() + minDiff  + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI;
    float hTr = map(hour() + hourDiff + norm(minute() + minDiff, 0, 60), 0, 24, 0, TWO_PI) - HALF_PI;

    /**Draws the hand (and its thickness) for each time component */
    stroke(0);
    
     /** check which face the user desires, load image accordingly */
     if(cDesigns == clockDesigns.BLACK) { stroke(0); }
     else if(cDesigns == clockDesigns.GREEN) { stroke(27, 140, 41); }
     else if(cDesigns == clockDesigns.BLUE) { stroke(67, 96, 221); }
     else if(cDesigns == clockDesigns.PINK) { stroke(221, 67, 154); }
     else if(cDesigns == clockDesigns.PIZZA) { stroke (0); }

    strokeWeight(4); /**thickness of second hand */
    line(centerX, centerY, centerX + cos(sTr) * sRad, centerY + sin(sTr) * sRad);

    strokeWeight(6); /**thickness of minute hand */
    line(centerX, centerY, centerX + cos(mTr) * mRad, centerY + sin(mTr) * mRad);

    strokeWeight(10); /**thickness of hour hand */
    line(centerX,centerY, centerX + cos(hTr) * hRad, centerY + sin(hTr) * hRad);

  }


  /** 
    @pre none
    @post calculates the difference between the user requested and current time
    @return none
  */
  public void calcDiff() {
    /** If after 12 pm, clock is treated as in 24 hour mode */
    int add12 = 0;

    if (!mainMenu.getTimeOfDay() && mainMenu.getView()){
      add12 = 12;
    }

    hourDiff = mainMenu.getHour() - hour() + add12;
    minDiff = mainMenu.getMinute() - minute();
    secDiff = mainMenu.getSecond() - second();
  }
  
   /** 
    @pre valid int called radius and valid enumerated type called cDesigns
    @post displays "AM" or "PM" on 12 hour clock depending on time
    @return none
  */
  public void displayAMPM(int radius, clockDesigns cDesigns) {
    /**load am and pm photos */
    PImage am;
    am = loadImage("AM.png");
    PImage pm;
    pm = loadImage("PM.png");
    
    if(mainMenu.getTimeOfDay()) {
      
      /** check which face the user desires, load image accordingly */
      if(cDesigns == clockDesigns.BLACK) { am = loadImage("AM.png"); }
      else if(cDesigns == clockDesigns.GREEN) { am = loadImage("AM-green.png"); }
      else if(cDesigns == clockDesigns.BLUE) { am = loadImage("AM-blue.png"); }
      else if(cDesigns == clockDesigns.PINK) { am = loadImage("AM-pink.png"); }
      else if(cDesigns == clockDesigns.PIZZA) { am = loadImage("AM.png"); }
     
      am.resize(48, 34);
      image(am, 530, 370);
    }
    else {

      /** check which face the user desires, load image accordingly */
      if(cDesigns == clockDesigns.BLACK) { pm = loadImage("PM.png"); }
      else if(cDesigns == clockDesigns.GREEN) { pm = loadImage("PM-green.png"); }
      else if(cDesigns == clockDesigns.BLUE) { pm = loadImage("PM-blue.png"); }
      else if(cDesigns == clockDesigns.PINK) { pm = loadImage("PM-pink.png"); }
      else if(cDesigns == clockDesigns.PIZZA) { pm = loadImage("PM.png"); }
      
      
      pm.resize(48, 34);
      image(pm, 530, 370);
    }
  }     
}
/** CountBackTimer classes produces functionality to set, reset and pause a backwards counting clock
*
*
* @author Functionality by: Paul Charles, Purna Doddapaneni, Dilesh Fernando, Cheng-yeh Lee
*/





public class CountBackTimer {
  //keep tack of which mode is selected.
  boolean timerMode = false;
  
  //Variables for timer input from user
  private int hours = 0;
  private int minutes = 0;
  private int seconds = 0;
  //Variable for font size (Default)
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

    //display timer in proper format
    fill(0,0,0);
    textSize(fontSize);
    textAlign(CENTER);
    text(nf(displayHours,2,0) + ":" + nf(displayMinutes,2,0) + ":" + nf(displaySeconds,2,0),550,400);
  }
}
/** DateCalendar adds the day of the week to the clock face
*
*
* @author Functionality by: Paul Charles, Purna Doddapaneni, Dilesh Fernando, Cheng-yeh Lee
*/




/** DateCalendar is used to keep track of the actual date in MM/DD/YYY and display the corresponding day of the week
*
*
* @author Paul Charles, Purna Doddapaneni, Dilesh Fernando, Cheng-yeh Lee
*/

public class DateCalendar {
  //Variables for user input
  private int year = 0;
  private int month = 0;
  private int day = 0;
  
  //Variables patterm matching
  private Pattern patternDate;
  private Matcher matchDate;
  
  //Create instance of java.util GregorianCalendar
  GregorianCalendar calendar = new GregorianCalendar();
  
/** 
  @pre none
  @post none
  @return none
*/ 
  DateCalendar(){}
  
 /** 
    @pre inputDate
    @post none
    @return none
  */
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
 /** 
    @pre userDate
    @post none
    @return day of the week
  */
  public void setDateCalendar(int year, int month, int day){
    calendar.set(GregorianCalendar.YEAR, year);
    calendar.set(GregorianCalendar.MONTH, (month - 1));
    calendar.set(GregorianCalendar.DATE, day);
  }
  /** 
    @pre userDate
    @post none
    @return day of the week
  */ 
  public int getDayOfTheWeek(){
    return(calendar.get(GregorianCalendar.DAY_OF_WEEK));
  }
    /** 
    @pre none
    @post none
    @return day of the week
  */ 
  public void incrementDay(){
    calendar.add(GregorianCalendar.DAY_OF_MONTH, 1);
  }
    /** 
    @pre none
    @post none
    @return none
  */ 
  public void displayDateCalendar(){
    //Images that display the day of the week
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
/** Power class handles the turning on and off of the display
*
*
* @author Functionality by: Paul Charles, Purna Doddapaneni, Dilesh Fernando, Cheng-yeh Lee
*/
public class Power{
   
  boolean powerMode = true;
  /** 
    @pre Power Button is pressed
    @post switches boolean value of powerMode to turn screen off and on
    @return none
  */
  public void switchPowerMode(){
     if( powerMode == true)
     {
         powerMode=false;
     }
     else if(powerMode == false)
     {
         powerMode=true;
     }
  }
  /** 
    @pre powerMode is set to true
    @post Display a blank screen with button power
    @return none
  */
  public void displayOff(){
          background(255,255,255);
          PImage Power = loadImage("POWER.png");
          Power.resize(60, 60);
          image(Power, 0, 0);
  }
}
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
  public void settings() {  size(1100, 1120); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "HourClock" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
