//default
String[] iconNames = {"call", "message"};
IntDict iconXPosDict = new IntDict();

IntDict iconIndex = new IntDict();
PImage[] iconLoad = new PImage[3];
PImage notification;

int space = 140;

void setDefaultIcons(){
  int xPos = 61;
  for(int i = 0; i < iconNames.length; i++){
    iconIndex.set(iconNames[i], i);
  }
  
  iconLoad[0] = loadImage("images/icons/call.png");
  iconLoad[1] = loadImage("images/icons/message.png");
  
  notification = loadImage("images/icons/notification.png");
  
  notificationIcon = loadImage("images/icons/messageNotification.png");
  
  // initialize
    for(int i = 0; i < iconNames.length; i++){
      iconXPosDict.set(iconNames[i], xPos);
      xPos += space;
    }
}


void defaultScreen(){
  int xPos = 75;
  background(150);
  //image(screensLoad[screensIndex.get("default")], 0, 0);
    
  //image(navigationBarLoad[navigationIndex.get("transparent")], 0, height-40);
  for(int i = 0; i < iconNames.length; i++){
    if(!functionsEnded[i]){
      image(iconLoad[iconIndex.get(iconNames[i])], xPos * ratioX, 573 * ratioY);
      xPos += space;
    } else {
      tint(255, 126);
      image(iconLoad[iconIndex.get(iconNames[i])], xPos * ratioX, 573 * ratioY);
      xPos += space;
      
      tint(255, 255);
    }
    
    if (!functionsEnded[1]){
      image(notification, (iconXPosDict.get("message")+50) * ratioX, 571 * ratioY);
      fill(255);
      textSize(11 *  ratioY);
          
        if(currentBully < 10){
          text(currentBully, 263 * ratioX, 583 * ratioY);
        } else if (currentBully < 20){
          text(currentBully, 260 * ratioX, 583 * ratioY);
        } else {
          text("99+", (iconXPosDict.get("message")+56) * ratioX, 582 * ratioY);
        }image(notification, (iconXPosDict.get("message")+50) * ratioX, 571 * ratioY);
      fill(255);
      textSize(11 *  ratioY);
          
        if(currentBully < 10){
          text(currentBully, 264 * ratioX, 583 * ratioY);
        } else if (currentBully < 100){
          text(currentBully, 261 * ratioX, 583 * ratioY);
        } else {
          text("99+", (iconXPosDict.get("message")+56) * ratioX, 583 * ratioY);
        }
    }
  }
    
  // show time and date
    fill(255);
    textSize(60 * ratioY);
    text(currentTime(), 60 * ratioX, 199 * ratioY);
    
    textSize(45 * ratioY);
    text(currentDate(), 168 * ratioX, 250 * ratioY);
    
  drawUpperBar("white");
  
  if (attemptQuit){
    askQuit();
  }

} 
