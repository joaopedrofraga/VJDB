import 'package:flutter/material.dart';

class VJDBMaterial {
  static final VJDBMaterial _singleton = VJDBMaterial._internal();

  factory VJDBMaterial() {
    return _singleton;
  }

  VJDBMaterial._internal();

  static const String title = 'VJDB';

  static Color get primaryColor => const Color.fromARGB(255, 0, 97, 164);

  static Widget get getLogo => ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: Image.asset('assets/images/logo.png'));

  static ThemeData get getTheme => ThemeData(
      scaffoldBackgroundColor: const Color.fromARGB(255, 241, 241, 241),
      colorSchemeSeed: Colors.blue,
      appBarTheme:
          AppBarTheme(backgroundColor: primaryColor, centerTitle: true),
      fontFamily: 'Lato');
}
