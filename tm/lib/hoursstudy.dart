import 'package:flutter/material.dart';

class SHours extends StatelessWidget {
  int shours;

  SHours({required this.shours});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
          child: Center(
        child: Text(shours.toString(),
            style: TextStyle(
              fontSize: 25,
              color: Color.fromARGB(255, 255, 255, 255),
              //color: Color.fromARGB(255, 30, 217, 230),
              fontWeight: FontWeight.bold,
            )),
      )),
    );
  }
}
