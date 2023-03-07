import 'package:flutter/material.dart';
//import 'countDown.dart';
import 'tracking.dart';

class Startbutton extends StatelessWidget {
  const Startbutton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 21, 142, 223),
      body: Container(
        
        alignment: Alignment.center,
        padding: EdgeInsets.all(0),
        child: ElevatedButton.icon(
          label: Text('Start'),
          icon: Icon(Icons.book),
          
          
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Tracking()));
          },
        ),
      ),
    );
  }
}
