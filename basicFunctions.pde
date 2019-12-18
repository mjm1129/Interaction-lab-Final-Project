//import processing.serial.*;

int NUM_OF_VALUES = 2;  /** YOU MUST CHANGE THIS ACCORDING TO YOUR PROJECT **/

//Serial myPort;
String myString;

// This is the array of values you might want to send to Arduino.
int values[] = new int[NUM_OF_VALUES]; // [freq, duration]

int duration = 1;

void loadScreens(){
  // screen load
  screensLoad[0] =  loadImage("images/default.png");
  screensIndex.set("default", 0);
  
  //screensLoad[1] =  loadImage("images/wechat_Outside.png");
  //screensIndex.set("wechat_outside", 1);
  
  //screensLoad[2] = loadImage("images/camera.png");
  //screensIndex.set("camera", 2);
  
  screensLoad[3] = loadImage("images/message.png");
  screensIndex.set("message", 3);
  
  screensLoad[4] = loadImage("images/message_inside.png");
  screensIndex.set("message_inside", 4);
  
  loadCallScreens();
}

void loadSound(){
  backgroundMusic = new SoundFile(this, "audio/background.mp3");
  ringtone = new SoundFile(this, "audio/ringtone.mp3");
  phonecallRingtone = new SoundFile(this, "audio/phoneCall.mp3");
  calling = new SoundFile(this, "audio/call.mp3");
  breakingSound = new SoundFile(this, "audio/glassBreak.mp3");
}

void APPcheck(){
    int iconSize = 50;
    String currentKey;
    int currentValue;
    String clickedKey = "";
      
    for(int i = 0; i < iconXPosDict.size(); i++){
      currentKey = iconXPosDict.keyArray()[i];
      currentValue = iconXPosDict.get(currentKey);
      
    
      if (pmouseX > (currentValue  * ratioX) - 50 && pmouseX < ((currentValue + iconSize) * ratioX) + 50 &&
          pmouseY > ((573 * ratioY) + 50) && pmouseY < ((573+iconSize) * ratioY) + 50){
            mode = currentKey;
            clickedKey = currentKey;
       }
    }
    
    APPPressedTime = elapseSeconds();
}

void generatePhoneNum(int numBully){
  // set random numbers for bullying
  for(int i = 0; i < numBully; i++){
    String tempNum = "+86-";
    tempNum += str(int(random(17,19)));
    tempNum += str(int(random(1, 10)));
    tempNum += "-";
    for(int j = 0; j < 4; j++){
      tempNum += str(int(random(0, 9)));
    }
    tempNum += "-";
    
    for(int j = 0; j < 4; j++){
      tempNum += str(int(random(0, 9)));
    }
    numbersDict.set(tempNum, 0);
  }
}

void touchStarted(){
  touchMode = "touch";
}

void touchMoved(){
  
  if (mode == "message" && abs(mouseY - pmouseY) > 20){
    touchMode = "scroll";
  }
}

void touchEnded(){
  if(touchMode != "scroll"){
    touchMode = "touch";
  } else {
    dist += -pmouseY + mouseY;
    if ((float(screenMsg[0][5]) + (-pmouseY + mouseY)) > 87 * ratioY){
      dist = float(screenMsg[0][5]) - (87 * ratioY);
    }
  }
  touchEnded = true;
}

void notifications(){
  if (mode == "default" || mode == "camera"){
    drawNotification(28 * ratioX, 108 * ratioY);
  }  
}

void drawNotification(float xPos, float yPos){
  fill(255);
  rect(xPos, yPos, 300 * ratioX, 100* ratioY, 7* ratioY);
  image(notificationIcon, xPos + (15.5 * ratioX), yPos + (25 * ratioY));

  if (screenMsg[0][2].length() > 36){
    textSize(15 * ratioY);
    fill(0);
    text(screenMsg[0][1], xPos + (72.5 * ratioX), yPos + (35 * ratioY));
    
    textSize(12 * ratioY);
    fill(150);
    text(screenTextProcess(screenMsg[0][2])[0], xPos + (75.5 * ratioX), yPos + (55 * ratioY));
    text(screenTextProcess(screenMsg[0][2])[1], xPos + (75.5 * ratioX), yPos + (75 * ratioY));
  } else {
    textSize(15 * ratioY);
    fill(0);
    text(screenMsg[0][1], xPos + (74.5 * ratioX) , yPos + (42 * ratioY));
    
    textSize(12 * ratioY);
    fill(150);
    text(screenTextProcess(screenMsg[0][2])[0], xPos + (75.5 * ratioX), yPos + (66 * ratioY));
  }
}

boolean notificationClicked(){
  boolean touched = false;
  
  if (mousePressed && pmouseX >= (28 * ratioX) - 50 && pmouseX <= (28 * ratioX) + (300 * ratioX) + 50 &&
      pmouseY >= (108 * ratioY) - 50 && pmouseY <= (108 * ratioY) + (100* ratioY) + 50){
    touched = true;
  }
  
  return touched;
}

void initialize(){
  
  
}
