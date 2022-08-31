import 'package:flutter/material.dart';

class CounterViewModel extends ChangeNotifier {
  int _counter1 = 0;
  int _counter2 = 0;
  int _counter3 = 0;
  int _counter4 = 0;
  int _counter5 = 0;
  int _counter6 = 0;

  int get counter1 => _counter1;

  int get counter2 => _counter2;

  int get counter3 => _counter3;

  int get counter4 => _counter4;

  int get counter5 => _counter5;

  int get counter6 => _counter6;

  void incrementCounter1() {
    _counter1++;
    notifyListeners();
  }

  void incrementCounter2() {
    _counter2++;
    notifyListeners();
  }

  void incrementCounter3() {
    _counter3++;
    notifyListeners();
  }

  void incrementCounter4() {
    _counter4++;
    notifyListeners();
  }

  void incrementCounter5() {
    _counter5++;
    notifyListeners();
  }

  void incrementCounter6() {
    _counter6++;
    notifyListeners();
  }
}
