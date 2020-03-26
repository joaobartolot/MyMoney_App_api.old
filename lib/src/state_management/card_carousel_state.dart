import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class CardCarouselState with ChangeNotifier {
  final expensePageController = PageController(initialPage: 0);

  double _currentCard;

  double get currentCard => _currentCard;

  set currentCard(double value) {
    _currentCard = value;
    expensePageController.jumpToPage(value.floor());
    notifyListeners();
  }
}
