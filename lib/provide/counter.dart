import 'package:flutter/material.dart';

class Counter with ChangeNotifier{
  int _value = 0;

  int get value  => _value;

  increment(){
    _value ++;
    notifyListeners();
  }

}
