import 'package:flutter/material.dart';

class NavigationManager extends ChangeNotifier {
  bool isProductDetailsPage = false;
  bool isMyCartPage = false;

  void setIsProductDetailsPage(bool isActive) {
    isProductDetailsPage = isActive;
    notifyListeners();
    debugPrint(
        '${DateTime.now()} - isProductDetailsPage = $isProductDetailsPage');
  }

  void setIsMyCartPage(bool isActive) {
    isMyCartPage = isActive;
    notifyListeners();
    debugPrint(
        '${DateTime.now()} - isMyCartPage = $isMyCartPage');
  }
}
