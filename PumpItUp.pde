import processing.serial.*;

Serial myPort;
String val;
int lineFeed = 10;
float c = 0;
String inString;
boolean state = false;
PImage img;
PImage winImg;
PImage loseImg;
PGraphics mask;
int diameter = 600;
int goal = 900;
int fail = 100;
int vobbleValue = 0;
boolean vobbleIncrease = true;
boolean isRunning = true;
boolean win = false;
boolean lose = false;
float deflationRateFloat = 0;
int gameState = 2;
float realValue;

void setup(){
  //Basics
  size (1200, 900);
  background (#222222);
  
  //Arduino communication
  myPort = new Serial(this, Serial.list()[1], 115200);
  myPort.bufferUntil(lineFeed);


  //Define images
  imageMode(CENTER);
  img=loadImage("trump.png");
  img.resize(diameter, diameter);
  
  winImg=loadImage("win.gif");
  loseImg=loadImage("lose.gif");
  
  //Create the mask
  mask=createGraphics(diameter, diameter);//draw the mask object
  mask.beginDraw();
  mask.smooth();//this really does nothing, i wish it did
  mask.background(0);//background color to target
  mask.fill(255);
  mask.ellipse(diameter/2, diameter/2 , 540, 540);
  mask.endDraw();
  img.mask(mask);
}

void draw() {
  background (realValue);
  image(img, 500, 500, diameter + vobbleValue, diameter + vobbleValue);
  
  //Show the start screen
  if (gameState == 1) {
    
  
  }
  
  //Show the in-game screen
  if (gameState == 2) {
    
    if(isRunning){
    //println("win = " + win);
    //println("lose = " + lose);
  
    float deflationRateFloat = diameter/100;
    int deflationRateInt = (int)deflationRateFloat;
    
  if(diameter > 0){
    //diameter = diameter - deflationRate;
    //diameter = diameter - deflationRateInt;
    diameter-=5;
   
    if(vobbleValue >= 10) {
     vobbleIncrease = false;
    } 
    if(vobbleValue <= -10 ){
     vobbleIncrease = true;
    }
  
    if(vobbleIncrease){
     vobbleValue+=4;
    } else {
     vobbleValue-=2;
    }
    //println("DeflationFloat rate = " + deflationRateFloat + "%");
    //println("DeflationInt rate = " + deflationRateInt + "%");
    //println("Diameter = " + diameter);
   
    delay(100);
    
  }
  
  if(diameter > goal) {
    isRunning = false;
    win = true;
  }
  
  if(diameter < fail) {
    isRunning = false;
    lose = true;  
  }
  
  
}

  if(lose){
    image(loseImg, 600, 450, 1200, 900);
  }
  
  if(win){
    image(winImg, 600, 450, 1200, 900);
  }
  
  }


}

void keyPressed(  ) {
  if (key == ENTER) {
    diameter = diameter + 10;
  }
  if (key == BACKSPACE) {
    diameter = diameter -10;
  } 
}

void serialEvent(Serial port){
 inString = myPort.readStringUntil(lineFeed);
 if(inString != null) {
   inString = inString.trim();
   int value = int(inString);
   realValue = map(value,810,1023,0,20);
   diameter += realValue;
   println(realValue);
 
 }
}
