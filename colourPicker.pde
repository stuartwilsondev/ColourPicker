import processing.serial.*;
import java.net.*;
import java.io.*;
import cc.arduino.*;

//Arduino
Arduino arduino;

//initialise pin outs
int redPin = 11;
int greenPin = 10;
int bluePin = 9;

//pin values
int red = 0;
int green = 0;
int blue = 0;

// The serial port:
Serial myPort;


void setup() {
  
    //This creates a "box" on the pc to aid focus for keyboard inputs
    size(600,600);
    
    //create Arduino instance
    arduino = new Arduino(this, Arduino.list()[5], 57600);
      
    // set the pin modes
    arduino.pinMode(redPin,Arduino.OUTPUT);
    arduino.pinMode(greenPin,Arduino.OUTPUT);        
    arduino.pinMode(bluePin,Arduino.OUTPUT);
   
    //set initial colour to white
    setColour(255,255,255);
  
}

/**
 * Set the current colour
 */
void setColour(int red, int green, int blue)
{
   //subtract the current colour as this LED is common annode/cathode so the values are reversed
   red = 255 - red;
   green = 255 - green;  //Removed these if LED is reversed
   blue = 255 - blue;

   arduino.analogWrite(redPin, red); 
   arduino.analogWrite(greenPin, green); 
   arduino.analogWrite(bluePin, blue); 
}

/**
 * 
 */
void draw()
{
  //background(red,green,blue); 
}

/**
 * detect keypress and act accordingly
 */
void keyPressed()
{
    if (key == 'A') {
        loop(10);
    }
    else if (key == 'P') {
        policeFlash(20);
    }
    else if (key == 'T') {
        trafficLight(10);
    }
    else if (key == 'R') {
       setColour(255,0,0);
    }
    else if (key == 'G') {
       setColour(0,255,0);
    }
    else if (key == 'B') {
       setColour(0,0,255);
    }
    else if (key == 'W') {
       setColour(255,255,255);
    } 
    else if (key == 'S') {
       strobe(100, 38, 40);
    } 
    else {
       //if any other key is pressed pick a random clour
       red = int(random(256));
       green = int(random(256));
       blue = int(random(256)); 
       setColour(red,green,blue);
    }
}

/**
 * Loop for the specified iterations in a while loop
 * Set a random colour on each iteration
 */
void loop(Integer maxIterations)  
{
  int i = 0;
  
  while(i <= maxIterations)
  {
    //Set a random colour    
    setColour(
      int(random(256)),
      int(random(256)),
      int(random(256))
    );
    
    //pause
    delay(600);
    
    i++;
  }
  
  //set back to white
  setColour(255,255,255);
  
}  

/**
 * Flash Red and Blue with a slight pause in between 
 */
void policeFlash(Integer maxIterations){
  
  for(int i=0; i <= maxIterations; i++){
    setColour(255,0,0);
    delay(200);
    setColour(0,0,255);
    delay(200);
  }

  //set back to white
  setColour(255,255,255);
}

/**
 * Simulate a traffic light 
 * This is not a true traffic light as this can go straight from Red to Green and Green to Red.
 * Also the current colour is not detected so this could show the same colour each time.
 *
 * TODO Detect current colour. prevent the above issue.
 */
void trafficLight(Integer maxIterations)
{
  for(int i=0; i <= maxIterations; i++){
    
    //create Green, Red and amber (yellow)
    int[] go = {0,255,0};
    int[] stop = {255,0,0};
    int[] proceedIfOk = {255,140,0};
    
    //set these in an array
    int[][] options = { go, stop, proceedIfOk };
  
    //pick a random colour set from the options array
    int id = (int) random(options.length);
    int[] option = (options[id]);
    
    setColour(option[0],option[1],option[2]);
    
    //set a random delay
    delay(int(random(500,2000)));
     
  } 
  
    //set back to white
    setColour(255,255,255);
  
}

/**
 * Strobe
 * Flash white with a delay
 */
void strobe(Integer maxIterations, Integer whiteTime, Integer blackTime)
{
  
  for(int i=0; i <= maxIterations; i++){
      
     //Set white
     setColour(255,255,255);
     
     //Set the time white stays on
     delay(whiteTime);
     
     //set black
     setColour(0,0,0);
     
     set the time black stays on
     delay(blackTime);
    
  }
  
    //set back to white
    setColour(255,255,255);
}
