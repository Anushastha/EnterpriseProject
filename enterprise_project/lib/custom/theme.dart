import 'package:flutter/material.dart';

class CustomTheme {
  static const Color backgroundColor = Color(000000);
  static const Color primaryColor = Color(0xFF535F61);
  static const Color secondaryColor = Color(0xFF32B891);
  static const Color whitetextColor = Color(0xFFAFFFFFF);
  static const Color textColor = Color(0xFF022539);

  final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: primaryColor,
    primaryColorDark: primaryColor,
    shadowColor: Colors.black,
    appBarTheme:
        const AppBarTheme(iconTheme: IconThemeData(color: primaryColor)),
    scaffoldBackgroundColor: backgroundColor,
    // iconTheme: const IconThemeData(color: darkerBlack),
    textTheme: TextTheme(
      headline1: TextStyle(
          color: whitetextColor, fontWeight: FontWeight.bold, fontSize: 20),

      // headline2: TextStyle(
      //     color: lightTextColor, fontWeight: FontWeight.bold, fontSize: 22),
      // headline3: TextStyle(
      //     color: lightTextColor, fontWeight: FontWeight.bold, fontSize: 20),
      // headline4: TextStyle(fontSize: 18, color: lightTextColor),
      // headline5: TextStyle(color: lightTextColor, fontSize: 16),
      // headline6: TextStyle(
      //     color: lightTextColor, fontSize: 14, fontWeight: FontWeight.w300),
      // caption: TextStyle(color: lightTextColor, fontSize: 8),
      // subtitle2: TextStyle(color: lightTextColor, fontSize: 12),
      // subtitle1: TextStyle(color: lightTextColor, fontSize: 10),
      // button: TextStyle(color: lightTextColor, fontSize: 12),
      // bodyText1: TextStyle(fontSize: 12, color: lightTextColor),
      // bodyText2: TextStyle(fontSize: 10, color: lightTextColor),
    ),
  );
}
