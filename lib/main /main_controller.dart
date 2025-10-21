import 'package:effective_mobile_russia_test/helpers/globals.dart';
import 'package:effective_mobile_russia_test/main%20/main_model.dart';
import 'package:effective_mobile_russia_test/main%20/main_view.dart';
import 'package:flutter/material.dart';

class MainController extends StatefulWidget {
  const MainController({super.key});

  @override
  State<MainController> createState() => _MainControllerState();

  viewInit(MainView widget, BuildContext context) async {
    currentScreen = 'Main View';
  }
}

class _MainControllerState extends State<MainController> {
  MainModel mainViewData = MainModel(tabCurrentIndex: 0);

  @override
  Widget build(BuildContext context) {
    return MainView(
      mainViewData: mainViewData,
      mainController: MainController(),
    );
  }
}
