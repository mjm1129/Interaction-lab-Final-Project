int numberBully = 13;
IntDict numbersDict = new IntDict();
String[][] screenMsg = new String[0][0];
int numMsg = 0;
int currentBully = 0;

int prevCheckedTime = 0;
int messagePoppedTime = 0;

float yPos = 87;
float shortSpacing;
float longSpacing;

int clickedUser = 0;
int screenUser = 0;

boolean touchEnded = false;

String[][] messages = {{"Why do you even live?", "You should be dead", "JUST KILL YOURSELF"},
                       {"You are just a total fag. Go back to your country"},
                       {"u r actually one of the worst human beings I've ever had the chance to meet"},
                       {"Were you dropped on your head or something?", "You’re so ugly", "Get your face fixed or some shit"},
                       {"I bet your parents are regretting having you"},
                       {"You’re the biggest idiot ever…kys"},
                       {"Nobody likes you"},
                       {"You are the worst kinda human"},
                       {"Dumb", "Slut"},
                       {"You better know everyone hates u"},
                       {"Bitch", "I feel bad for your parents"},
                       {"Just go and kill urself and then everybody will be happy u saddo."},
                       {"You deserve to die"},
                       {"Hey Loser. Watch your back"},
                       {"YOU ARE ABSOLUTE PIECE OF SHIT"},
                       {"Why do you even live?", "You should be dead", "JUST KILL YOURSELF"},
                       {"You are just a total fag. Go back to your country"},
                       {"u r actually one of the worst human beings I've ever had the chance to meet"},
                       {"Were you dropped on your head or something?", "You’re so ugly", "Get your face fixed or some shit"},
                       {"I bet your parents are regretting having you"},
                       {"You’re the biggest idiot ever…kys"},
                       {"Nobody likes you"},
                       {"You are the worst kinda human"},
                       {"Dumb", "Slut"},
                       {"You better know everyone hates u"},
                       {"Bitch", "I feel bad for your parents"},
                       {"Just go and kill urself and then everybody will be happy u saddo."},
                       {"You deserve to die"},
                       {"Hey Loser. Watch your back"},
                       {"YOU ARE ABSOLUTE PIECE OF SHIT"},
                       {"Why do you even live?", "You should be dead", "JUST KILL YOURSELF"},
                       {"You are just a total fag. Go back to your country"},
                       {"u r actually one of the worst human beings I've ever had the chance to meet"},
                       {"Were you dropped on your head or something?", "You’re so ugly", "Get your face fixed or some shit"},
                       {"I bet your parents are regretting having you"},
                       {"You’re the biggest idiot ever…kys"},
                       {"Nobody likes you"},
                       {"You are the worst kinda human"},
                       {"Dumb", "Slut"},
                       {"You better know everyone hates u"},
                       {"Bitch", "I feel bad for your parents"},
                       {"Just go and kill urself and then everybody will be happy u saddo."},
                       {"You deserve to die"},
                       {"Hey Loser. Watch your back"},
                       {"YOU ARE ABSOLUTE PIECE OF SHIT"}};
void setMessages(){
  // generate random numbers for bullying
  generatePhoneNum(numberBully);
  //printArray(numbersDict.keyArray());
  
  // initialize the screenMsg array
  screenMsg = new String[numberBully + 2][6];
  
  shortSpacing = 61 * ratioY;
  longSpacing = 74 * ratioY;
}

void transferMsg(int currentNum){
  ringtone.pause();
  ringtone.cue(0);
  
  int lastMsgIndex = 0;
  // generate a pair
  lastMsgIndex = messages[currentNum].length - 1;
  screenMsg[0][0] = str(currentNum);
  screenMsg[0][1] = numbersDict.keyArray()[currentNum];
  screenMsg[0][2] = messages[currentNum][lastMsgIndex];
  screenMsg[0][3] = currentTime();
  screenMsg[0][4] = str(color(random(0, 255), random(0, 255), random(0, 255)));
  screenMsg[0][5] = str(87 * ratioY);
    
  ringtone.play();
}

void autoAdjust(){
  int lastMsgIndex = messages[currentBully].length - 1;
  String newMsg = messages[currentBully][lastMsgIndex];
  
  for(int i = currentBully; i > 0; i--){
    screenMsg[i][0] = screenMsg[i-1][0];
    screenMsg[i][1] = screenMsg[i-1][1];
    screenMsg[i][2] = screenMsg[i-1][2];
    screenMsg[i][3] = screenMsg[i-1][3];
    screenMsg[i][4] = screenMsg[i-1][4];
    screenMsg[i][5] = screenMsg[i-1][5];
    
    if(newMsg.length() > 35){
      screenMsg[i][5] = str(int(screenMsg[i][5])+ longSpacing);
    } else {
      screenMsg[i][5] = str(int(screenMsg[i][5])+ shortSpacing);
    }
  }
}

void autoTransfer(){
  int randomTime = int(random(1, 5));
  if (elapseSeconds()-randomTime > prevCheckedTime && currentBully < numberBully){
    autoAdjust();
    transferMsg(currentBully);
    currentBully++;
    prevCheckedTime = elapseSeconds();
    messagePoppedTime = elapseSeconds();
  }
  
  if (elapseSeconds()>= messagePoppedTime && elapseSeconds() <= messagePoppedTime + 1 && currentBully < numberBully){
    notifications();
    
    if (notificationClicked()){
      mode = "message";
      APPPressedTime = elapseSeconds();
      seenMsg = true;
    }
  }
  
  if (currentBully == numberBully && elapseSeconds() - 5 > APPPressedTime){    
    if(seenMsg){
      functionsEnded[1] = true;
    }
    ringtone.stop();
  }
}

void showMsg(){
  background(#f2f2f2);
  float messageyPos;
  for(int i = 0; i < currentBully; i++){
    messageyPos = float(screenMsg[i][5]) + dist;
    
    if (messageyPos  < (87 * ratioY)){
      messageyPos = 87 * ratioY;
    } 
    drawMsgBox(screenMsg[i][1], screenMsg[i][2], screenMsg[i][3], 0, messageyPos, int(screenMsg[i][4]));
  }
  image(screensLoad[screensIndex.get("message")], 0, 0);
  textSize(10* ratioY);
  fill(#83eaff);
  
  if(currentBully > 9){
    text(currentBully, 147 * ratioX , 668 * ratioY);
  } else {
    text(currentBully, 150 * ratioX , 668 * ratioY);
  }
  drawUpperBar("black");
  
  // touch Function
  if (mousePressed && elapseSeconds() - 1 > APPPressedTime && touchMode == "touch" && pmouseY > 80 * ratioY && pmouseY < 573 * ratioY){
    mode = "message_inside";
    for(int i = 0; i < currentBully; i++){
      if(pmouseY > float(screenMsg[i][5])){
        if (screenMsg[i+1][5] != null){
          if (pmouseY < float(screenMsg[i+1][5])){
            clickedUser = int(screenMsg[i][0]);
            screenUser = i;
            break;
          } 
        } else {
          clickedUser = int(screenMsg[i][0]);
            screenUser = i;
            break;
        }
      }
    }
    
  }
}

void showInsideMsg(){
  image(screensLoad[screensIndex.get("message_inside")], 0, 0);
  
  if (mousePressed && pmouseX < 60 * ratioX && pmouseY < 70 * ratioY){
    mode = "message";
    
    fill(255, 200);
    rect(0, 24 * ratioY, 60 * ratioX, 42 * ratioY);
  }
  
  // number
  fill(0);
  textSize(20 * ratioY);
  text(numbersDict.keyArray()[clickedUser], 54 * ratioX, 54 * ratioY);
  
  // date
  fill(#757575);
  textSize(12 * ratioY);
  text(currentDateWithYr(), 110 * ratioX, 130 * ratioY);
  
  // the message box
  //fill(0, 0, 255);
  //rect(54 * ratioX, 153 * ratioY, 210 * ratioX, 59 * ratioY, 15 * ratioY);
  
  //fill(#ededed);
  //rect(54 * ratioX, 153 * ratioY, 210 * ratioX, 43 * ratioY, 15 * ratioY);
  
  //fill(255, 0, 0);
  //rect(54 * ratioX, 153 * ratioY, 210 * ratioX, 27 * ratioY, 15 * ratioY);
  
  //float textYPos = 170 * ratioY;
  String[][] texts = new String[messages[clickedUser].length][4];
  float msgBoxYPos = 170 * ratioY;
  
  for(int i = 0; i < messages[clickedUser].length; i++){
    String[] temp = new String[4];
    temp[0] = str(clickedUser);
    temp[1] = screenMsg[screenUser][1];
    temp[2] = messages[clickedUser][i];
    temp[3] = screenMsg[screenUser][3];
    texts[i] = temp;
    //printArray(texts[i]);
  }
  
  fill(0);
  for(int i = 0; i < texts.length; i++){
    int validIndex = (texts[i][2].length()/36) + 1;
    String[] textArray = Arrays.copyOfRange(screenTextInsideProcess(texts[i][2]), 0, validIndex);
    
    drawInsideMsgSet(0, msgBoxYPos, textArray, int(texts[i][3]), screenMsg[screenUser][3]);
    msgBoxYPos += (17 * ratioY) +(30 + (16 * (textArray.length - 1))) * ratioY;
  }
  
  drawUpperBar("black");
}

void drawInsideMsgSet(float xPos, float yPos, String[] msgArray, color userColor, String msgTime){
  float msgBoxHeight = (30 + (16 * (msgArray.length - 1))) * ratioY;
  float msgYPos = yPos;
  // user
  drawUserFigure(xPos, yPos, userColor, "inside");
  
  float msgBoxWidth = 210 * ratioX;
  
  if(msgArray.length == 1 && msgArray[0].length() < 36){
    msgBoxWidth -= (36 - msgArray[0].length()) * (5 * ratioX);
  }
  
  // the message box
  fill(#ededed);
  rect(xPos + (54 * ratioX), yPos - 19 * ratioY, msgBoxWidth, msgBoxHeight, 15 * ratioY);
  
  fill(0);
  
  for(int i = 0; i < msgArray.length; i++){
    text(msgArray[i], 65 * ratioX, msgYPos);
    msgYPos += 15 * ratioY;
  }
  
  //               rectangle Pos            rect width
  float timeXPos = (xPos + (54 * ratioX)) + msgBoxWidth + (7 * ratioX);
  float timeYPos = yPos - 19 * ratioY     + msgBoxHeight - (3 * ratioY);
  
  fill(#757575);
  textSize(11 * ratioY);
  text(msgTime, timeXPos, timeYPos);
  
}

String[] screenTextProcess(String textMsg){
  // text message process
  String[] screenText = new String[2];
  String[] sentenceWords = split(textMsg, " ");
  int alphaNum = 0;
  screenText[0] = sentenceWords[0];
  screenText[1] = "";
  for(int i = 1; i < sentenceWords.length; i++){
    if(sentenceWords[i] != null){
      if(alphaNum + sentenceWords[i].length() + 1 < 36){
        screenText[0] += " " + sentenceWords[i];
        alphaNum += 1 + sentenceWords[i].length();
      } else if (alphaNum + sentenceWords[i].length() + 1 < 72){
        screenText[1] += " " + sentenceWords[i];
        alphaNum += 1 + sentenceWords[i].length();
      }
    }
  }
  
  if(screenText[1].length() > 0){
    screenText[1] = screenText[1].substring(1);
  }
  return screenText;
}

String[] screenTextInsideProcess(String textMsg){
  // text message process
  String[] screenText = new String[4];
  String[] sentenceWords = split(textMsg, " ");
  int alphaNum = 0;
  screenText[0] = sentenceWords[0] + " ";
  screenText[1] = "";
  for(int i = 1; i < sentenceWords.length; i++){
    if(sentenceWords[i] != "null"){
      if(alphaNum + sentenceWords[i].length() + 1 < 36){
        screenText[0] += sentenceWords[i] + " ";
        alphaNum += 1 + sentenceWords[i].length();
      } else if (alphaNum + sentenceWords[i].length() + 1 < 72){
        screenText[1] += sentenceWords[i] + " ";
        alphaNum += 1 + sentenceWords[i].length();
      } else if (alphaNum + sentenceWords[i].length() + 1 < 108){
        screenText[2] += sentenceWords[i] + " ";
        alphaNum += 1 + sentenceWords[i].length();
      } else if (alphaNum + sentenceWords[i].length() + 1 < 144){
        screenText[3] += sentenceWords[i] + " ";
        alphaNum += 1 + sentenceWords[i].length();
      } 
    }
  }
  
  for(int i = 1; i < 4; i++){
    if(screenText[i] != null && screenText[i] != ""){
      if (screenText[i].substring(0, 4) == "null"){
        screenText[i] = screenText[i].substring(5);
        
      }
    }
  }
  return screenText;
}

void drawMsgBox(String number, String textMsg, String time, float xPos, float yPos, color userColor){
  if (textMsg.length() > 35){
    fill(255);
    stroke(150, 100);
    rect(xPos, yPos, width, 74 * ratioY);
    drawUserFigure(xPos, yPos + 36 * ratioY, userColor, "outside");
  } else {
    fill(255);
    stroke(150, 100);
    rect(xPos, yPos, width, 61 * ratioY);
    drawUserFigure(xPos, yPos + 30 * ratioY, userColor, "outside");
  }
  
  fill(50);
  textSize(15 * ratioY);
  text(number, 61 * ratioX, yPos + 27*ratioY);
  
  fill(150);
  textSize(12 * ratioY);
  
  if (textMsg.length() > 32){
    text(screenTextProcess(textMsg)[0], (xPos + 63) * ratioX, yPos + 44*ratioY);
    text(screenTextProcess(textMsg)[1], (xPos + 63) * ratioX, yPos + 60*ratioY);
  } else {
    text(screenTextProcess(textMsg)[0], (xPos + 63) * ratioX, yPos + 46*ratioY);
  }
  
  text(time, (xPos + 290) * ratioX, yPos + 23*ratioY);
}

void drawUserFigure(float xPos, float yPos, color userColor, String userMode){
  ellipseMode(CENTER);
  
  if (userMode == "outside"){
    noStroke();
    fill(userColor);
    ellipse((xPos + 32)*ratioX, yPos, 30*ratioY, 30*ratioY);
    
    fill(#FFFFFF, 150);
    ellipse((xPos + 32)*ratioX, yPos - 5*ratioY, 6*ratioY, 6*ratioY);
    arc((xPos+32)*ratioX, yPos + 6*ratioY, 12*ratioY, 12*ratioY, PI, TWO_PI);
  } else {
    noStroke();
    fill(userColor);
    ellipse((xPos + 32)*ratioX, yPos, 30*ratioY, 30*ratioY);
    
    fill(#FFFFFF, 150);
    ellipse((xPos + 32)*ratioX, yPos - 5*ratioY, 6*ratioY, 6*ratioY);
    arc((xPos+32)*ratioX, yPos + 6*ratioY, 12*ratioY, 12*ratioY, PI, TWO_PI);
  }
}
