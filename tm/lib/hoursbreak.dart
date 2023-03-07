import 'package:flutter/material.dart';

class BHours extends StatelessWidget {
  int bhours;

  BHours({required this.bhours});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
          child: Center(
        child: Text(bhours.toString(),
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
