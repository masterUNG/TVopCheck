import 'package:flutter/material.dart';

class MyConstant {
  static Color primary = const Color.fromARGB(255, 12, 199, 130);
  static Color dark = Color.fromARGB(255, 58, 71, 5);
  static Color light = const Color(0xffecff85);

  BoxDecoration normalBox() => BoxDecoration(color: light.withOpacity(0.5));

  TextStyle h1Style() => TextStyle(
        fontSize: 30,
        color: dark,
        fontWeight: FontWeight.bold,
      );

  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        color: dark,
        fontWeight: FontWeight.w700,
      );

  TextStyle h3Style() => TextStyle(
        fontSize: 14,
        color: dark,
        fontWeight: FontWeight.normal,
      );
}
