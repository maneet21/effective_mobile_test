import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager {
  Future<dynamic> backgroundColor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('Theme Selected') == 'Light Theme') {
      return Colors.white;
    } else if (prefs.getString('Theme Selected') == 'Dark Theme') {
      return Colors.grey;
    }

    return '';
  }

  Future<Color?> navTabBar() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('Theme Selected') == 'Light Theme') {
      return Colors.white;
    } else if (prefs.getString('Theme Selected') == 'Dark Theme') {
      return Colors.grey;
    }
    return Colors.white;
  }

  Future<Color> listCell() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('Theme Selected') == 'Light Theme') {
      return Colors.white;
    } else if (prefs.getString('Theme Selected') == 'Dark Theme') {
      return Colors.grey;
    }

    return Colors.white;
  }
}
