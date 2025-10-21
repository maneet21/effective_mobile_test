import 'dart:io';

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

  Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(''),
          content: SingleChildScrollView(
            child: ListBody(
              children: [Text('Theme will be applied when app is relaunched')],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                exit(2);
              },
            ),
          ],
        );
      },
    );
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
