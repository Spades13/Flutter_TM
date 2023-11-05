//here all the theme constants are set so that we can reference these variables, that will change depending on the selected theme(light/dark)
//This is used mainly for the text and backgrounds in our app(that need to change color)
import 'package:flutter/material.dart';
//import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color.fromARGB(255, 5, 4, 51),
    secondaryHeaderColor: Color.fromRGBO(234, 245, 132, 12),
    datePickerTheme: DatePickerThemeData(
        dividerColor: Colors.black,
        headerBackgroundColor: Color.fromRGBO(39, 39, 39, 0.957)),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
          color: Color.fromRGBO(234, 245, 132, 12),
          fontSize: 40,
          fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(
        fontSize: 25,
        color: Color.fromRGBO(234, 245, 132, 12),
        //Color.fromRGBO(255, 255, 255, 0.957),
        //color: Color.fromARGB(255, 30, 217, 230),
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: TextStyle(
        fontSize: 60,
        color: Color.fromRGBO(234, 245, 132, 12),
        //color: Color.fromARGB(255, 30, 217, 230),
        fontWeight: FontWeight.bold,
      ),
      labelSmall: TextStyle(
        fontSize: 15,
        color: Color.fromRGBO(234, 245, 132, 12),
        //color: Color.fromARGB(255, 30, 217, 230),
      ),
      titleSmall: TextStyle(
          color: Color.fromRGBO(234, 245, 132, 12),
          fontSize: 40,
          fontWeight: FontWeight.bold),
      titleLarge: TextStyle(
        fontSize: 60,
        color: Color.fromRGBO(234, 245, 132, 12),
        //color: Color.fromARGB(255, 30, 217, 230),
        fontWeight: FontWeight.bold,
      ),
    ));

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color.fromARGB(255, 240, 237, 219),
  secondaryHeaderColor: Color.fromRGBO(39, 39, 39, 0.957),

  datePickerTheme: DatePickerThemeData(
      dividerColor: Colors.black,
      headerBackgroundColor: Color.fromRGBO(39, 39, 39, 0.957)),
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
      color: Color.fromRGBO(92, 91, 91, 0.957),
      //color: Color.fromARGB(255, 30, 217, 230),
      fontWeight: FontWeight.bold,
    ),
    labelSmall: TextStyle(
      fontSize: 15,
      color: Color.fromRGBO(92, 91, 91, 0.957),
      //color: Color.fromARGB(255, 30, 217, 230),
    ),
    titleSmall: TextStyle(
        color: Color.fromRGBO(234, 245, 132, 12),
        fontSize: 40,
        fontWeight: FontWeight.bold),
    titleLarge: TextStyle(
      fontSize: 60,
      color: Color.fromRGBO(234, 245, 132, 12),
      //color: Color.fromARGB(255, 30, 217, 230),
      fontWeight: FontWeight.bold,
    ),
  ),

  //textTheme for numbers
);
