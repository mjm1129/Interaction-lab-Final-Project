void backPressed(){
  if (mode == "default"){
    attemptQuit = true;
  } else if (mode == "message"){
    mode = "default";
  } else if (mode == "message_inside"){
    mode = "message";
  }
}

void askQuit(){
  image(backNotification, 19 * ratioX, 187 * ratioY);
  
  //fill(255, 0, 0, 100);
  //rect(19 * ratioX, 442 * ratioY, 340 * ratioX - 19 * ratioX, 491.28 * ratioY - 441 * ratioY);
  
  //fill(0, 0, 255, 100);
  //rect(19 * ratioX, 492 * ratioY, 340 * ratioX - 19 * ratioX, 538.52 * ratioY - 492 * ratioY);
  
  
  if(mousePressed){
    if(pmouseX > 19 * ratioX && pmouseX < 340 * ratioX && pmouseY > 442 * ratioY  && pmouseY < 492* ratioY){
      attemptQuit = false;
      //println("continue");
    } else if(pmouseX > 19 * ratioX && pmouseX < 340 * ratioX && pmouseY > 492 * ratioY && pmouseY < 538.52 * ratioY){
      exit();
    }
  }
}
