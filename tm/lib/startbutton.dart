import 'package:flutter/material.dart';
//import 'countDown.dart';
import 'tracking.dart';

class Startbutton extends StatelessWidget {
  const Startbutton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 5, 4, 51),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            minimumSize: Size(210, 80),
            textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            primary: Color.fromARGB(61, 21, 142, 223),
            onPrimary: Colors.white,
          ),
          child: Text('Start'),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Tracking()));
          },
        ),
      ),
    );
  }
}
