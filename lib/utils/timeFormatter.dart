import 'package:flutter/material.dart';

class TimeFormatter{
  TimeOfDay time = TimeOfDay.now();
  String? formattedTime;


  String formatTime(){
    String minutes=time.minute.toString();
    String hours=time.hourOfPeriod.toString();
    if(time.minute.toString().length < 2){
      minutes = "0${time.minute}";
    }
    if(time.hour.toString().length < 2){
      hours = "0${time.hourOfPeriod}";
    }
    return formattedTime="${hours}:${minutes}";
  }
}