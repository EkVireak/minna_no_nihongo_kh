String dateFormat(DateTime dt, {String format = "yyyy-m-d h:m:s"}){
  if( dt != null ){
    String month, day, hour, minute, second;
    if(dt.month<10)
      month = "0${dt.month}";
    else
      month = "${dt.month}";
    if(dt.day<10)
      day = "0${dt.day}";
    else
      day = "${dt.day}";
    if(dt.hour<10)
      hour = "0${dt.hour}";
    else
      hour = "${dt.hour}";
    if(dt.minute<10)
      minute = "0${dt.minute}";
    else
      minute = "${dt.minute}";
    if(dt.second<10)
      second = "0${dt.second}";
    else
      second = "${dt.second}";
    if( format == "Y-m-d h:m:s" ){
      return dt.year.toString()+"-"+month+"-"+day+" "+hour+":"+minute+":"+second;
    }
    else if( format == "Y-m-d" ){
      return dt.year.toString()+"-"+month+"-"+day;
    }
    else if( format == "d-m-Y h:m:s" ){
      return day+"-"+month+"-"+dt.year.toString()+" "+hour+":"+minute+":"+second;
    }
    else if( format == "d-m-Y" ){
      return day+"-"+month+"-"+dt.year.toString();
    }
    else
      return dt.year.toString()+"-"+month+"-"+day+" "+hour+":"+minute+":"+second;
  }
  else
    return "";
}