import 'package:flutter/material.dart';
import 'package:tm/hoursstudy.dart';
//import 'countDown.dart';
import 'tracking.dart';
import 'timer.dart';
import 'package:tm/globals.dart' as globals;



class Startbutton extends StatelessWidget {
  Startbutton({Key? key}) : super(key: key);
  bool isButtonActive = true;
  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
  
    return Scaffold(
      
      backgroundColor: Colors.transparent,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            minimumSize: Size(210, 80),
            textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            primary: Color.fromARGB(61, 21, 142, 223),
            onPrimary: Color.fromRGBO(234, 245, 132, 12),
          ),
          child: Text('Start'),
          onPressed: isButtonActive? () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Tracking()));
                

          }: null,
        ),
      ),
    );
  }
}
