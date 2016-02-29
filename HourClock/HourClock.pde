/** HourClock functions as our programs main method. In processing, main is split into a setup method and a draw method.
*
*
* @author Ashley Hutton, Hannah Johnson, Rabel Marte
*/

Menu mainMenu;
ClockFace clock;
DateCalendar date;
Timer timer;
int radius;

int seconds = 0;
int minutes = 0;
int hours = 0;
int k = 1;
int j = 1;


void setup() {

  size(1100, 1120);
  fill(255);
  
  mainMenu = new Menu();
  clock = new ClockFace();
  date = new DateCalendar();
  timer = new Timer();
    
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
    update(mouseX, mouseY);
    background(255);

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

    mainMenu.displayMenu();
    
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