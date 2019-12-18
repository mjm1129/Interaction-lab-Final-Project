// Screens
IntDict navigationIndex = new IntDict();
PImage[] navigationBarLoad = new PImage[3];

PImage touched;
IntDict whichClicked = new IntDict();

PImage whiteBar;
PImage blackBar;

int msgNotif = 0;
int wechatNotif = 0;
int facebookNotic = 0;

void setNavigationBars(){
  setDefaultIcons();
  
  // screen load
  navigationBarLoad[0] =  loadImage("images/navigationBar/transparent.png");
  navigationIndex.set("transparent", 0);
  
  navigationBarLoad[1] =  loadImage("images/navigationBar/black.jpeg");
  navigationIndex.set("black", 1);
  
  navigationBarLoad[2] =  loadImage("images/navigationBar/white.jpeg");
  navigationIndex.set("white", 2);
  
  touched = loadImage("images/navigationBar/touched.png");
  
  whichClicked.set("slides", int(32 * ratioX));
  whichClicked.set("goDefault", int(125 * ratioX));
  whichClicked.set("previous", int(222 * ratioX));
  
  whiteBar = loadImage("images/upperBar/white.png");
  blackBar = loadImage("images/upperBar/black.png");
}

void navigationBarChecked(){
  float clickSize = 82 * ratioX;
  String currentKey = "";
  float currentValue;
  String clickedKey = "";
  
  for(int i = 0; i < whichClicked.size(); i++){
    currentKey = whichClicked.keyArray()[i];
    currentValue = whichClicked.get(currentKey);
    
    if (pmouseX > currentValue && pmouseX < (currentValue + clickSize) &&
          pmouseY > (654 * ratioY) && pmouseY < (683 * ratioY)){
            image(touched, currentValue, 654 * ratioY);
            clickedKey = currentKey;
            mode = currentKey;
       }
  }
  
  if(clickedKey == "goDefault"){
    mode = "default";
  }
}

void drawUpperBar(String mode){
  noStroke();
  if(mode == "white"){
    fill(255);
    fill(255, 10);
    rect(0, 0, width, 23 * ratioY);
    image(whiteBar, 265 * ratioX, 1 * ratioY);
    fill(255, 255);
  } else {
    fill(0);
    fill(0, 2);
    rect(0, 0, width, 23 * ratioY);
    fill(0, 255);
    image(blackBar, 265 * ratioX, 1 * ratioY);
  }
  textSize(12 * ratioY);
  text(currentTime(), 10 * ratioX, 16 * ratioY);
}
