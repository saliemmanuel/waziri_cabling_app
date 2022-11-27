import 'package:flutter/material.dart';

class TesteProvide extends ChangeNotifier {
  int counter = 0;

  increment() {
    counter += 1;
    notifyListeners();
  }

  decrement() {
    counter -= 1;
    notifyListeners();
  }
}
