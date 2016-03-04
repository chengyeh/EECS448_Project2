public class Power{
   
  boolean powerMode = true;
  
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
  
  public void displayOff(){
          background(255,255,255);
          PImage Power = loadImage("POWER.png");
          Power.resize(60, 60);
          image(Power, 0, 0);
  }
}