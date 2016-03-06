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

void setup() {
  //Set window size and the window
  size(1100, 1120);
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

void draw() {
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