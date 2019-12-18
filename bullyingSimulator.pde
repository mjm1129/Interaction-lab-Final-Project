import processing.sound.*;
SoundFile backgroundMusic;
SoundFile ringtone;
SoundFile phonecallRingtone;
SoundFile calling;
SoundFile breakingSound;

import java.util.Arrays;

String mode = "default";
String prevMode = "default";
String touchMode = "touch"; // touch or scroll

// Screens
IntDict screensIndex = new IntDict();
PImage[] screensLoad = new PImage[6];

long startedTime, currentTime, finishedTime;

float ratioX, ratioY;

float dist;

PImage notificationIcon;
PImage backNotification;

long callStartedTime, callEndedTime;

boolean[] functionsEnded = {false, false};

boolean attemptQuit = false;

boolean seenMsg = false;

boolean endRecorded = false;
//int finishedSec = 0;

void setup(){
  // adjust the screen sizes and get the ratio to optimize for each phones
  size(1080, 2220);  
  orientation(PORTRAIT);
  ratioX = width / 335;
  ratioY = height / 690;
  
  // check the starting time
  startedTime = System.currentTimeMillis();
  
  loadSound();
  setDefaultIcons();
  setNavigationBars();
  loadScreens();
  setMessages();
  loadEnding();
  backNotification = loadImage("images/backNotification.png");
  
  backgroundMusic.loop();
  
  randomInt = int(random(numberBully));
  randomNumber = numbersDict.keyArray()[randomInt];
  
  //printArray(Serial.list());
  //myPort = new Serial(this, Serial.list()[ 5 ], 9600);
  //// check the list of the ports,
  //// find the port "/dev/cu.usbmodem----" or "/dev/tty.usbmodem----" 
  //// and replace PORT_INDEX above with the index of the port

  //myPort.clear();
  //// Throw out the first reading,
  //// in case we started reading in the middle of a string from the sender.
  //myString = myPort.readStringUntil( 10 );  // 10 = '\n'  Linefeed in ASCII
  //myString = null;
}

void draw() {
  //Bundle bundle;
  //onCreate(bundle);
  if (functionsEnded[0] && functionsEnded[1]){
    if(!endRecorded){
      finishedTime = System.currentTimeMillis();
      endRecorded = true;
    }
    ending();
  } else {
    drawScreen(mode);
    
    if (mode != "call" && !attemptQuit && mode != "message_inside"){
      autoTransfer();
    }
  }
  if(elapseSeconds() > 10){
    if(!functionsEnded[0]){
        mode = "call";
    }
  }
 
}    

void drawScreen(String screenMode){
  if (screenMode == "default"){
    defaultScreen();
  } 
  //else if (screenMode == "camera"){
  //  //showCamera();
  //} 
  else if (screenMode == "message"){
    showMsg();
    seenMsg = true;
  } 
  else if (screenMode == "message_inside"){
    showInsideMsg();
  }
  if (screenMode == "call"){
    //if(!functionsEnded[0]){
    //  mode = "default";
      
    //}
    callStart();
  } 
    

  
}

void mousePressed(){
  if(mode == "default"){
    APPcheck();
  }
  //navigationBarChecked();
  //println(pmouseX, pmouseY);
}
