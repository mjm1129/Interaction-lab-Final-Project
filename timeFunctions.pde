import java.util.Calendar;
Calendar cal = Calendar.getInstance();
 
int[] elapseTime(long start, long end){
  long elapsed = end - start;
  int elapseMin = int(elapsed / 60000);
  int elapseSec = int((elapsed - (elapseMin * 60000))/1000);
  int[] elapseTimeArray = {elapseMin, elapseSec};
  return elapseTimeArray;
}

String elapseTimeString(long start, long end){
  long elapsed = end - start;
  int elapseMin = int(elapsed / 60000);
  int elapseSec = int((elapsed - (elapseMin * 60000))/1000);
  
  String msg = "";
  if (elapseMin < 10){
    msg += "0";
  }
  msg += str(elapseMin) + " min ";
  
  if (elapseSec < 10){
    msg += "0";
  }
  msg += str(elapseSec);
      
  return msg;
}

int elapseSeconds(){
  long elapsed = System.currentTimeMillis() - startedTime;
  int elapseSec = int(elapsed/1000);
  return elapseSec;
}

String currentTime(){
    String msg = "";
    String time = "";
    if (hour() > 12){
        msg+= str(hour()-12);
        time = "PM";
    } else {
        msg += str(hour());
        time = "AM";
    }
    
    if (int(msg) < 10){
        msg = "0" + msg;
    }
    msg += ":";
    
    if (minute() < 10){
        msg += "0";
    }
    
    msg += str(minute());
    msg += " " + time;
    return msg;
}

String currentDate(){
  String[] monthLetter = {"Jan", "Feb", "March", "Apr", "May", "June", "July", "Aug", "Sept", "Oct", "Nov", "Dec"};
  String msg = "";
  msg += monthLetter[month()-1];
  msg += ". ";
  msg += day(); 
  return msg;
}

String currentDateWithYr(){
  String[] weekdays = {"Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"};
  String[] monthLetter = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
  String msg = "";
  
  msg += weekdays[cal.get(Calendar.DAY_OF_WEEK)];
  msg += ", ";
  msg += monthLetter[month()-1];
  msg += " ";
  msg += day(); 
  msg += ", ";
  msg += year();
  return msg;
}

String callElapseTime(long start, long end){
  long elapsed = end - start;
  int elapseMin = int(elapsed / 60000);
  int elapseSec = int((elapsed - (elapseMin * 60000))/1000);
  
  String msg = "";
  if (elapseMin < 10){
    msg += "0";
  }
  msg += str(elapseMin) + ":";
  
  if (elapseSec < 10){
    msg += "0";
  }
  msg += str(elapseSec);
      
  return msg;
}
