import 'package:flutter/material.dart';

class VJDBTextStyles {
  static final VJDBTextStyles _singleton = VJDBTextStyles._internal();

  factory VJDBTextStyles() {
    return _singleton;
  }

  VJDBTextStyles._internal();

  static TextStyle get getNormalStyle => const TextStyle(
        color: Colors.black,
        fontSize: 14,
      );

  static TextStyle get getNormalBoldStyle => getNormalStyle.copyWith(
        fontWeight: FontWeight.bold,
      );

  static TextStyle get getTitleStyle => getNormalBoldStyle.copyWith(
        fontSize: 24,
      );

  static TextStyle get getSmallStyle => getNormalStyle.copyWith(
        fontSize: 12,
      );
}
