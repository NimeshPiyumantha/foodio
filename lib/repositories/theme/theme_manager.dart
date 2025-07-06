import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  ThemeManager() {
    loadThemeMode();
  }

  toggleTheme(ThemeMode tMode) {
    _themeMode = tMode;
    saveThemeMode(tMode);
    notifyListeners();
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', mode.toString().split('.').last);
  }

  Future<void> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    String themeString = prefs.getString('themeMode') ?? 'light';
    _themeMode = ThemeMode.values.firstWhere(
        (mode) => mode.toString().split('.').last == themeString,
        orElse: () => ThemeMode.light);
    notifyListeners();
  }
}
