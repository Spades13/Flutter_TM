import 'package:flutter/material.dart';
//import 'countDown.dart';
import 'tracking.dart';

class Startbutton extends StatelessWidget {
  const Startbutton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 223, 67, 67),
      body: Container(
        width: 150,
        height: 80,
        alignment: Alignment.center,
        padding: EdgeInsets.all(5),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              minimumSize: Size(150, 80),
              textStyle: TextStyle(fontSize: 35),
              primary: Color.fromARGB(255, 7, 193, 226), //button color
              //foregroundColor: Colors.black, //text color
              side: BorderSide(
                  width: 3, color: Color.fromARGB(255, 7, 193, 226))),
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
