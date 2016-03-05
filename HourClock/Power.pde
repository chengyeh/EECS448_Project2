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