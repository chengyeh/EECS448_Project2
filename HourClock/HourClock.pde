/** HourClock functions as our programs main method. In processing, main is split into a setup method and a draw method.
*
*
* @author Ashley Hutton, Hannah Johnson, Rabel Marte
*/

//Variables for all class
Menu mainMenu      = new Menu();;
ClockFace clock    = new ClockFace();
StopWatch stpWatch = new StopWatch();
Timer timer        = new Timer();
DateCalendar date  = new DateCalendar();

int radius;

int seconds = 0;
int minutes = 0;
int hours = 0;
int k = 1;
int j = 1;


void setup() {
  //Set window size and the window
  size(1100, 1120);
  fill(255);
  
  mainMenu.toggleView();

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

void draw() {
    //Get mouse click info
    update(mouseX, mouseY);
    
    //Set the backgroun color of the main window
    background(255);
    
    //Display the Mian menu
    mainMenu.displayMenu();

    //Display the slected functionality
    if(clock.clockFaceMode == true){
      //Clock is selected
      radius = clock.getRadius();
  
      /** Check if clock rolls over from AM/PM */
      seconds = second() + secDiff;
         
      if (seconds == (60 * k)){
        minutes++;
        k++;
      }
      if (minutes == (60 * j)){
        hours++;
        j++;
      }
      if (hours == 24){
        hours = 0;
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
    }
    else if(timer.timerMode == true){
      //Timer is selected
    }
}