import 'package:flutter/widgets.dart';

class ProviderHourSelectd extends ChangeNotifier{
  String? hours;
  void selectedProtocl(value)  {
 hours = value;       
 notifyListeners();
  }
  String get housSelectd=>hours?? "14:10";
}