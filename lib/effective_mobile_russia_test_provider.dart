import 'package:effective_mobile_russia_test/helpers/globals.dart';
import 'package:flutter/cupertino.dart';

class EffectiveMobileRussiaTestProvider extends ChangeNotifier {
  String screen = '';
  String refreshUI = '';

  bool activityIndicatorLoading = true;

  Future<void> isLoading(bool activityIndicatorLoading1, String screen1) async {
    activityIndicatorLoading = activityIndicatorLoading1;
    screen = screen1;

    screen == currentScreen ? notifyListeners() : null;
  }

  Future<void> refresh(String refreshUI1, String screen1) async {
    refreshUI = refreshUI1;
    screen = screen1;

    screen == currentScreen ? notifyListeners() : null;
  }
}
