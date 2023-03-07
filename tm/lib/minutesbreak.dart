import 'package:flutter/material.dart';

class BMinutes extends StatelessWidget {
  int bmins;

  BMinutes({required this.bmins});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
          child: Center(
        child: Text(bmins.toString(),
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold,
            )),
      )),
    );
  }
}
