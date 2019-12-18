
PImage[] callScreen = new PImage[3];
int callMode = 0;

int APPPressedTime;

String randomNumber = "";
int randomInt;

void loadCallScreens(){
  callScreen[0] = loadImage("images/incomeCall_start.png");
  callScreen[1] = loadImage("images/incomeCall_mid.png");
  callScreen[2] = loadImage("images/incomeCall_end.png");
}

void callStart(){
  drawCallScreen();
  
  if(callMode == 0 && !phonecallRingtone.isPlaying()){
    phonecallRingtone.play();
  } 
  
  if(callMode != 0){
    phonecallRingtone.stop();
  }
  
  if(callMode == 2 && System.currentTimeMillis() - 1000 > callEndedTime){
    mode = "default";
    functionsEnded[0] = true;
  }
  
  if(callMode == 1 && calling.position() >= calling.duration() - 0.3){
    callMode = 2;
    callEndedTime = System.currentTimeMillis();
    calling.stop();
    
  }
  
  if (mousePressed){
    if (elapseSeconds() - 1 > APPPressedTime){
      if(callMode == 0 && pmouseY > 541 * ratioY && pmouseY < 650 * ratioY && pmouseX > 0 * ratioX && pmouseX < 150 * ratioX){
        callMode = 1;
        callStartedTime = System.currentTimeMillis();
        APPPressedTime = elapseSeconds();
        calling.play();
      } else if (callMode == 1 && pmouseX > 130 * ratioX && pmouseX < 200 * ratioX 
          && pmouseY > 540 * ratioY && pmouseY < 650 * ratioY){
          callMode = 2;
          callEndedTime = System.currentTimeMillis();
          calling.stop();
        }
    }
    
  }
 
  
}

void drawCallScreen(){
  image(callScreen[callMode], 0, 0);
  
  if (callMode == 0){
    drawUpperBar("white");
    
    fill(255);
    textSize(30 * ratioY);
    text(randomNumber, 40 * ratioX, 182 * ratioY);
    
  } else if (callMode == 1){
    drawUpperBar("white");
    
    fill(255);
    textSize(30 * ratioY);
    text(randomNumber, 40 * ratioX, 182 * ratioY);
   
    fill(#15b76c);
    textSize(15 * ratioY);
    text(callElapseTime(callStartedTime, System.currentTimeMillis()), 162 * ratioX, 50 * ratioY);
  } else {
    fill(0);
    textSize(30 * ratioY);
    text(randomNumber, 50 * ratioX, 182 * ratioY);
    
    drawUpperBar("black");
    fill(#e96056);
    textSize(15 * ratioY);
    text(callElapseTime(callStartedTime, callEndedTime), 132 * ratioX, 50 * ratioY);
  }
  
}
/*
y:
1742 ~ 1978

x1 
86 ~ 320

x2
751 ~
*/
