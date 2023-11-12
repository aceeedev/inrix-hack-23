import 'package:flutter/material.dart';

class Styles {
  // Colors:
  static const Color _mainColor = Color(0xFF211950);
  static const LinearGradient _linearGradient =
      LinearGradient(colors: [_mainColor, Color(0xFF3A2E87)]);

  Color get mainColor => _mainColor;
  LinearGradient get linearGradient => _linearGradient;

  // Text styles:
  static const TextStyle _defaultTextStyle =
      TextStyle(color: Colors.black, fontFamily: 'JetBrains Mono');

  TextStyle get defaultTextStyle => _defaultTextStyle;
}
