import 'package:flutter/material.dart';
//import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color.fromARGB(255, 5, 4, 51),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
          color: Color.fromRGBO(234, 245, 132, 12),
          fontSize: 40,
          fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(
        fontSize: 25,
        color: Color.fromRGBO(255, 255, 255, 0.957),
        //color: Color.fromARGB(255, 30, 217, 230),
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: TextStyle(
        fontSize: 60,
        color: Color.fromRGBO(234, 245, 132, 12),
        //color: Color.fromARGB(255, 30, 217, 230),
        fontWeight: FontWeight.bold,
      ),
    ));

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Color.fromARGB(255, 240, 237, 219),

  textTheme: const TextTheme(
    headlineMedium: TextStyle(
        color: Color.fromRGBO(39, 39, 39, 0.957),
        fontSize: 40,
        fontWeight: FontWeight.bold),
    headlineSmall: TextStyle(
      fontSize: 25,
      color: Color.fromRGBO(39, 39, 39, 0.957),
      //color: Color.fromARGB(255, 30, 217, 230),
      fontWeight: FontWeight.bold,
    ),
    headlineLarge: TextStyle(
      fontSize: 60,
      color: Color.fromRGBO(39, 39, 39, 0.957),
      //color: Color.fromARGB(255, 30, 217, 230),
      fontWeight: FontWeight.bold,
    ),
  ),

  //textTheme for numbers
);
