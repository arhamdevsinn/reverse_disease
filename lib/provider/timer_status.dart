import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimerStatus extends ChangeNotifier{
bool staus=false;
void setTimerStatus (bool value)async{
 SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("timerstate",value);
    checkTimerStatus();
    // notifyListeners();
}
void checkTimerStatus ()async{
 SharedPreferences preferences = await SharedPreferences.getInstance();
   var timer =  preferences.getBool("timerstate");
   if(timer != null){
    staus = timer;

   }
    notifyListeners();
}
bool get timerStatusValue=>staus;
}