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
  }
}