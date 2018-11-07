import processing.serial.*;
import processing.sound.*;

SoundFile file;
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
int fail = 10;
int vobbleValue = 0;
boolean vobbleIncrease = true;
boolean isRunning = true;
boolean winCheck = false;
boolean loseCheck = false;
float deflationRateFloat = 0;
int gameState = 0;
float realValue;
PFont america;
PFont pixel;
PImage[] win = new PImage[75];
PImage[] lose = new PImage[10];
int difficulty = 1;
float gameDif = 15;
boolean playMusicOnce = true;
float backgroundColor = 0;


void setup(){
  //Basics
  size (1200, 900);
  background (#222222);

  america = createFont("AMERICA.TTF", 100);
  pixel = createFont("pixel.ttf", 75);
  textAlign(CENTER, CENTER);
 
  //Arduino communication
  myPort = new Serial(this, Serial.list()[1], 115200);
  myPort.bufferUntil(lineFeed);

  //Define images
  imageMode(CENTER);
  img=loadImage("trump.png");
  img.resize(diameter, diameter);
  
  //Images for win gif
  win[0] = loadImage("win/frame_00_delay-0.07s.gif");
  win[1] = loadImage("win/frame_01_delay-0.06s.gif");
  win[2] = loadImage("win/frame_02_delay-0.07s.gif");
  win[3] = loadImage("win/frame_03_delay-0.07s.gif");
  win[4] = loadImage("win/frame_04_delay-0.06s.gif");
  win[5] = loadImage("win/frame_05_delay-0.07s.gif");
  win[6] = loadImage("win/frame_06_delay-0.07s.gif");
  win[7] = loadImage("win/frame_07_delay-0.06s.gif");
  win[8] = loadImage("win/frame_08_delay-0.07s.gif");
  win[9] = loadImage("win/frame_09_delay-0.07s.gif");
  win[10] = loadImage("win/frame_10_delay-0.06s.gif");
  win[11] = loadImage("win/frame_11_delay-0.07s.gif");
  win[12] = loadImage("win/frame_12_delay-0.07s.gif");
  win[13] = loadImage("win/frame_13_delay-0.06s.gif");
  win[14] = loadImage("win/frame_14_delay-0.07s.gif");
  win[15] = loadImage("win/frame_15_delay-0.07s.gif");
  win[16] = loadImage("win/frame_16_delay-0.06s.gif");
  win[17] = loadImage("win/frame_17_delay-0.07s.gif");
  win[18] = loadImage("win/frame_18_delay-0.07s.gif");
  win[19] = loadImage("win/frame_19_delay-0.06s.gif");
  win[20] = loadImage("win/frame_20_delay-0.07s.gif");
  win[21] = loadImage("win/frame_21_delay-0.07s.gif");
  win[22] = loadImage("win/frame_22_delay-0.06s.gif");
  win[23] = loadImage("win/frame_23_delay-0.07s.gif");
  win[24] = loadImage("win/frame_24_delay-0.07s.gif");
  win[25] = loadImage("win/frame_25_delay-0.06s.gif");
  win[26] = loadImage("win/frame_26_delay-0.07s.gif");
  win[27] = loadImage("win/frame_27_delay-0.07s.gif");
  win[28] = loadImage("win/frame_28_delay-0.06s.gif");
  win[29] = loadImage("win/frame_29_delay-0.07s.gif");
  win[30] = loadImage("win/frame_30_delay-0.07s.gif");
  win[31] = loadImage("win/frame_31_delay-0.06s.gif");
  win[32] = loadImage("win/frame_32_delay-0.07s.gif");
  win[33] = loadImage("win/frame_33_delay-0.07s.gif");
  win[34] = loadImage("win/frame_34_delay-0.06s.gif");
  win[35] = loadImage("win/frame_35_delay-0.07s.gif");
  win[36] = loadImage("win/frame_36_delay-0.07s.gif");
  win[37] = loadImage("win/frame_37_delay-0.06s.gif");
  win[38] = loadImage("win/frame_38_delay-0.07s.gif");
  win[39] = loadImage("win/frame_39_delay-0.07s.gif");
  win[40] = loadImage("win/frame_40_delay-0.06s.gif");
  win[41] = loadImage("win/frame_41_delay-0.07s.gif");
  win[42] = loadImage("win/frame_42_delay-0.07s.gif");
  win[43] = loadImage("win/frame_43_delay-0.06s.gif");
  win[44] = loadImage("win/frame_44_delay-0.07s.gif");
  win[45] = loadImage("win/frame_45_delay-0.07s.gif");
  win[46] = loadImage("win/frame_46_delay-0.06s.gif");
  win[47] = loadImage("win/frame_47_delay-0.07s.gif");
  win[48] = loadImage("win/frame_48_delay-0.07s.gif");
  win[49] = loadImage("win/frame_49_delay-0.06s.gif");
  win[50] = loadImage("win/frame_50_delay-0.07s.gif");
  win[51] = loadImage("win/frame_51_delay-0.07s.gif");
  win[52] = loadImage("win/frame_52_delay-0.06s.gif");
  win[53] = loadImage("win/frame_53_delay-0.07s.gif");
  win[54] = loadImage("win/frame_54_delay-0.07s.gif");
  win[55] = loadImage("win/frame_55_delay-0.06s.gif");
  win[56] = loadImage("win/frame_56_delay-0.07s.gif");
  win[57] = loadImage("win/frame_57_delay-0.07s.gif");
  win[58] = loadImage("win/frame_58_delay-0.06s.gif");
  win[59] = loadImage("win/frame_59_delay-0.07s.gif");
  win[60] = loadImage("win/frame_60_delay-0.07s.gif");
  win[61] = loadImage("win/frame_61_delay-0.06s.gif");
  win[62] = loadImage("win/frame_62_delay-0.07s.gif");
  win[63] = loadImage("win/frame_63_delay-0.07s.gif");
  win[64] = loadImage("win/frame_64_delay-0.06s.gif");
  win[65] = loadImage("win/frame_65_delay-0.07s.gif");
  win[66] = loadImage("win/frame_66_delay-0.07s.gif");
  win[67] = loadImage("win/frame_67_delay-0.06s.gif");
  win[68] = loadImage("win/frame_68_delay-0.07s.gif");
  win[69] = loadImage("win/frame_69_delay-0.07s.gif");
  win[70] = loadImage("win/frame_70_delay-0.06s.gif");
  win[71] = loadImage("win/frame_71_delay-0.07s.gif");
  win[72] = loadImage("win/frame_72_delay-0.07s.gif");
  win[73] = loadImage("win/frame_73_delay-0.06s.gif");
  win[74] = loadImage("win/frame_74_delay-0.06s.gif");
  //frameRate( 10 );
  
  //Images for lose gif
  lose[0] = loadImage("lose/frame_00_delay-0.1s.gif");
  lose[1] = loadImage("lose/frame_01_delay-0.1s.gif");
  lose[2] = loadImage("lose/frame_02_delay-0.1s.gif");
  lose[3] = loadImage("lose/frame_03_delay-0.1s.gif");
  lose[4] = loadImage("lose/frame_04_delay-0.1s.gif");
  lose[5] = loadImage("lose/frame_05_delay-0.1s.gif");
  lose[6] = loadImage("lose/frame_06_delay-0.1s.gif");
  lose[7] = loadImage("lose/frame_07_delay-0.1s.gif");
  lose[8] = loadImage("lose/frame_08_delay-0.1s.gif");
  lose[9] = loadImage("lose/frame_09_delay-0.1s.gif");

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
  background(backgroundColor, 0, 0);
  //Show the start screen
  if (gameState == 0) {
    
   textFont(america);
   text("Pump The Trump", 600, 300 );
   
   textFont(pixel);
   
   text("Start", 600, 450 );
   text("Settings", 600, 525 );
   text("Quit", 600, 600 );
   
   float startX = 510;
   float startY = 440;
   float settingsX = 510;
   float settingsY = 515;
   float quitX = 510;
   float quitY = 590;
   float w = 175;
   float h = 50;
   //rect(startX,startY,w,h);
   //rect(settingsX,settingsY,w,h);
   //rect(quitX,quitY,w,h);
   
   if(mousePressed){ 
    if(mouseX > startX && mouseX < startX+w && mouseY > startY && mouseY < startY+h){
     gameState = 2; 
     println("The mouse is pressed and over the button");
     fill(0);
     //do stuff
      } else if(mouseX > settingsX && mouseX < settingsX+w && mouseY > settingsY && mouseY < settingsY+h){
      gameState = 1;
      } else if(mouseX > quitX && mouseX < quitX+w && mouseY > quitY && mouseY < quitY+h){
      exit();
      }
      
    } 
    
  }
  
  //Show the settings screen
  if (gameState == 1) {
    
   textFont(america);
   text("Pump The Trump", 600, 300 );
   
   textFont(pixel);
   
   if (difficulty == 1) {
        text("->", 500, 450);
        gameDif = 15;
   }
   if (difficulty == 2) {
        text("->", 480, 525);
        gameDif = 10;
   }
   if (difficulty == 3) {
        text("->", 500, 600);
        gameDif = 8;
   }
   
   text("Easy", 600, 450 );
   text("Medium", 600, 525 );
   text("Hard", 600, 600 );
   text("Go back", 600, 700 );
   
   
    float easyX = 530;
    float easyY = 440;
    float mediumX = 510;
    float mediumY = 515;
    float hardX = 520;
    float hardY = 590;
    float goBackX = 510;
    float goBackY = 685;
    float w = 175;
    float h = 50;
    //rect(easyX,easyY,w,h);
    //rect(goBackX,goBackY,w,h);
    //rect(mediumX,mediumY,w,h);
    //rect(hardX, hardY, w, h);

    if(mousePressed){
    
    if(mouseX>easyX && mouseX <easyX+w && mouseY>easyY && mouseY <easyY+h){
        difficulty = 1;
     //do stuff
      } else if(mouseX>mediumX && mouseX <mediumX+w && mouseY>mediumY && mouseY <mediumY+h){
        difficulty = 2;
        println("medium");
      } else if(mouseX>hardX && mouseX <hardX+w && mouseY>hardY && mouseY <hardY+h){
        difficulty = 3;
      } else if (mouseX>goBackX && mouseX <goBackX+w && mouseY>goBackY && mouseY <goBackY+h){
        gameState = 0;
      } 
    } 
  }
  
  //Show the in-game screen
  if (gameState == 2) {
    if(playMusicOnce){
         playMusic();
         playMusicOnce = false;
    }
    backgroundColor = map(diameter,10,900,0, 255);

    image(img, 500, 500, diameter + vobbleValue, diameter + vobbleValue);
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
        winCheck = true;
      }
      
      if(diameter < fail) {
        isRunning = false;
        loseCheck = true;  
      }
  
  
    }

    if(loseCheck){
      //image(loseImg, 600, 450, 1200, 900);
      image( lose[frameCount%10], 600, 450, 1200, 900 );
      
    }
    
    if(winCheck){
      //image(winImg, 600, 450, 1200, 900)
      image( win[frameCount%75], 600, 450, 1200, 900);
      stopMusic();
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
   realValue = map(value,810,1023,0, gameDif);
   diameter += realValue;
   println(value);
 
 }
}

void playMusic(){
    file = new SoundFile(this, "pumpitup.mp3");
    file.play();
}

void stopMusic(){
  file.stop();
}
