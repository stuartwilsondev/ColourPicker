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


void keyPressed()
{
  red = int(random(256));
  green = int(random(256));
  blue = int(random(256)); 
  setColour(red,green,blue);
  
  if (key == 'A') {
    loop(10);
  }
  
  if (key == 'P') {
    policeFlash();
  }
  
  if (key == 'T') {
    trafficLight();
  }
  
  if (key == 'R') {
     setColour(255,0,0);
  }
  
  if (key == 'G') {
     setColour(0,255,0);
  }
  
  if (key == 'B') {
     setColour(0,0,255);
  }
   
  if (key == 'W') {
     setColour(255,255,255);
  } 
  
  if (key == 'S') {
   strobe();
  } 
 
  
  
}

void loop(Integer amount)  
{
  while(amount < 50)
  {
    red = int(random(256));
    green = int(random(256));
    blue = int(random(256)); 
    
    background(red,green,blue); 
    setColour(red,green,blue);
    
    delay(600);
    amount++;
  }
  
}  

void policeFlash(){
  int flashes = 20;
 
  for(int i=0;i<flashes;i = i +1){
    setColour(255,0,0);
    delay(200);
    setColour(0,0,255);
    delay(200);
  }
}


void trafficLight()
{
  int i = 0;
  while(i < 10) {
    
    int[] go = {0,255,0};
    int[] stop = {255,0,0};
    int[] proceedIfOk = {255,140,0};
    
    int[][] options = { go, stop, proceedIfOk };
  
    int id = (int) random(options.length);
    println(id);
    int[] option = (options[id]);
    
    println(option[0]);
    println(option[1]);
    println(option[2]);
    
    setColour(option[0],option[1],option[2]);
      
    i++;
     
      
    delay(int(random(500,2000)));
  }
 
}

void strobe()
{
   int i = 0;
   while(i < 100) {
     setColour(255,255,255);
     delay(38);
     setColour(0,0,0);
     delay(40);
     i++;
   }
}
