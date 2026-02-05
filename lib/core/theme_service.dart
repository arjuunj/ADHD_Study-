import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService with ChangeNotifier {
  static const String _keyDarkMode = 'isDarkMode';
  static const String _keyBgColor = 'bgColor';
  static const String _keyTextColor = 'textColor';
  static const String _keyFontSize = 'fontSize';
  static const String _keyFontFamily = 'fontFamily';

  bool _isDarkMode = false;
  int _backgroundColor = 0xFFFFFFFF; // White default
  int _textColor = 0xFF000000; // Black default
  double _fontSize = 16.0;
  String _fontFamily = 'Roboto';

  bool get isDarkMode => _isDarkMode;
  Color get backgroundColor => Color(_backgroundColor);
  Color get textColor => Color(_textColor);
  double get fontSize => _fontSize;
  String get fontFamily => _fontFamily;

  ThemeService() {
    _loadSettings();
  }

  TextStyle get currentTextStyle {
    return GoogleFonts.getFont(
      _fontFamily,
      fontSize: _fontSize,
      color: textColor,
    );
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(_keyDarkMode) ?? false;
    _backgroundColor = prefs.getInt(_keyBgColor) ?? 0xFFFFFFFF;
    _textColor = prefs.getInt(_keyTextColor) ?? 0xFF000000;
    _fontSize = prefs.getDouble(_keyFontSize) ?? 16.0;
    _fontFamily = prefs.getString(_keyFontFamily) ?? 'Roboto';
    notifyListeners();
  }

  Future<void> toggleDarkMode(bool value) async {
    _isDarkMode = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyDarkMode, _isDarkMode);
    notifyListeners();
  }

  Future<void> updateBackgroundColor(Color color) async {
    _backgroundColor = color.value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyBgColor, _backgroundColor);
    notifyListeners();
  }

  Future<void> updateTextColor(Color color) async {
    _textColor = color.value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyTextColor, _textColor);
    notifyListeners();
  }

  Future<void> updateFontSize(double size) async {
    _fontSize = size;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_keyFontSize, _fontSize);
    notifyListeners();
  }

  Future<void> updateFontFamily(String family) async {
    try {
      GoogleFonts.getFont(
        family,
      ); // excessive check to see if valid, or just trust UI
      _fontFamily = family;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyFontFamily, _fontFamily);
      notifyListeners();
    } catch (e) {
      debugPrint("Invalid font family: $family");
    }
  }
}
