import 'package:flutter/material.dart';

class Styles {
  // Constants:
  static const String _fontFamily = 'JetBrains Mono';

  // Colors:
  static const Color _mainColor = Color(0xFF211950);
  static const LinearGradient _linearGradient =
      LinearGradient(colors: [_mainColor, Color(0xFF3A2E87)]);

  Color get mainColor => _mainColor;
  LinearGradient get linearGradient => _linearGradient;

  // Text styles:
  static const TextStyle _defaultTextStyle =
      TextStyle(color: Colors.black, fontFamily: _fontFamily);
  static const TextStyle _mediumTextStyle = TextStyle(
      color: Colors.black,
      fontFamily: _fontFamily,
      fontSize: 18.0,
      fontWeight: FontWeight.w500);
  static const TextStyle _largeTextStyle = TextStyle(
      color: Colors.black,
      fontFamily: _fontFamily,
      fontSize: 24.0,
      fontWeight: FontWeight.w900);

  TextStyle get defaultTextStyle => _defaultTextStyle;
  TextStyle get mediumTextStyle => _mediumTextStyle;
  TextStyle get largeTextStyle => _largeTextStyle;
}
