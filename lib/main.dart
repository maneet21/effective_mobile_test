import 'package:effective_mobile_russia_test/effective_mobile_russia_test_provider.dart';
import 'package:effective_mobile_russia_test/helpers/theme_manager.dart';
import 'package:effective_mobile_russia_test/main%20/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/globals.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => EffectiveMobileRussiaTestProvider(),
      child: const EffectiveMobileRussiaTest(),
    ),
  );
}

class EffectiveMobileRussiaTest extends StatefulWidget {
  const EffectiveMobileRussiaTest({super.key});

  @override
  State<EffectiveMobileRussiaTest> createState() =>
      _EffectiveMobileRussiaTestState();
}

class _EffectiveMobileRussiaTestState extends State<EffectiveMobileRussiaTest> {
  @override
  void initState() {
    super.initState();

    appData().then((v) {
      themeData();
    });
  }

  Future<void> appData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var isFirstLaunch = prefs.getBool('isAppFirstLaunch1') ?? true;

    if (isFirstLaunch) {
      prefs.setBool('isAppFirstLaunch1', false);
      prefs.setString('Theme Selected', 'Light Theme');
      isAppFirstLaunch = true;
    } else {
      isAppFirstLaunch = false;
    }
  }

  void themeData() async {
    ThemeManager().navTabBar().then((v) {
      navTabBarColor = v;
    });

    ThemeManager().backgroundColor().then((v) {
      backgroundColor = v;
    });

    ThemeManager().listCell().then((v) {
      listCellColor = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainController(),
    );
  }
}
