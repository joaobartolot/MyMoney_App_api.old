import 'package:flutter/foundation.dart';

class MenuState with ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => _currentPage;
  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }

  int _animationDuration = 0;

  int get animationDuration => _animationDuration;
  set animationDuration(int value) {
    _animationDuration = value;
    notifyListeners();
  }
}
