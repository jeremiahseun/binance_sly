import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeData get themeData => _isDarkMode ? _darkTheme : _lightTheme;

  final ThemeData _lightTheme = ThemeData(
      brightness: Brightness.light, useMaterial3: true, fontFamily: 'Satoshi');

  final ThemeData _darkTheme = ThemeData(
      brightness: Brightness.dark, useMaterial3: true, fontFamily: 'Satoshi');

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
