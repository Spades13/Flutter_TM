import 'package:flutter/material.dart';
import 'package:tm/globals.dart' as globals;

class Graphs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;

    return Container(
        /*decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(255, 5, 4, 76),
              Color.fromARGB(255, 5, 4, 76),
              Color.fromARGB(255, 5, 4, 51),
              Color.fromARGB(255, 5, 4, 26),
              Color.fromARGB(255, 5, 4, 26),
            ])),*/
        child: Scaffold(
          
          
          body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                    child: Text(
                        "${(globals.count_study.inHours).toString().padLeft(2, "0")}:${(globals.count_study.inMinutes % 60).toString().padLeft(2, "0")}:${(globals.count_study.inSeconds % 60).toString().padLeft(2, "0")}",
                        style: _textTheme.headlineLarge/*TextStyle(
                            color: Color.fromRGBO(234, 245, 132, 12),
                            fontSize: 60,
                            fontWeight: FontWeight.bold))*/)),
                Center(
                    child: Text(
                        "${(globals.count_break.inHours).toString().padLeft(2, "0")}:${(globals.count_break.inMinutes % 60).toString().padLeft(2, "0")}:${(globals.count_break.inSeconds % 60).toString().padLeft(2, "0")}",
                        style: _textTheme.headlineLarge)),
              ]),
        ));
  }
}