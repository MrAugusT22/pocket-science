import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyThemeData extends ChangeNotifier {
  late bool _isDarkMode;
  late ThemePreferences _themePreferences;

  MyThemeData() {
    _isDarkMode = true;
    _themePreferences = ThemePreferences();
    getPreferences();
  }

  bool get getDarkMode {
    return _isDarkMode;
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    _themePreferences.setTheme(_isDarkMode);
    notifyListeners();
  }

  void getPreferences() async {
    _isDarkMode = await _themePreferences.getTheme();
    notifyListeners();
  }
}

class ThemePreferences {
  static const PREF_KEY = "pref_key";

  setTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(PREF_KEY, value);
  }

  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(PREF_KEY) ?? false;
  }
}
