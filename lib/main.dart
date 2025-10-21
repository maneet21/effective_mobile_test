import 'package:effective_mobile_russia_test/effective_mobile_russia_test_provider.dart';
import 'package:effective_mobile_russia_test/main%20/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => EffectiveMobileRussiaTestProvider(),
      child: const EffectiveMobileRussiaTest(),
    ),
  );
}

class EffectiveMobileRussiaTest extends StatelessWidget {
  const EffectiveMobileRussiaTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainController(),
    );
  }
}
