import 'package:flutter/material.dart';
import "homepage.dart";
import 'tracking.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}


//Color.fromARGB(255, 5, 4, 51),
//234, 245, 132, 12
//