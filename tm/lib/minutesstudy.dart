import 'package:flutter/material.dart';

class SMinutes extends StatelessWidget {
  int smins;

  SMinutes({required this.smins});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
          child: Center(
        child: Text(smins.toString(),
            style: TextStyle(
              fontSize: 25,
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold,
            )),
      )),
    );
  }
}
