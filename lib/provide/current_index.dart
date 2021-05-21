import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrentIndexProvider with ChangeNotifier {
  int currentIndex = 0;

  changeIndex(int index) {
    if (index > 3) {
      return;
    }
    currentIndex = index;
    notifyListeners();
  }
}
