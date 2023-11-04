// Not used file that was used for development

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:usage_stats/usage_stats.dart';
//import 'package:permission_handler/permission_handler.dart';
import 'main.dart';
import 'package:flutter/services.dart';
import 'pages/userhomepage.dart' as userhomepage;
import 'globals.dart' as globals;

void main() {
  runApp(Timing());
}

class Timing extends StatefulWidget {
  @override
  _TimingState createState() => _TimingState();
}

class _TimingState extends State<Timing> with TickerProviderStateMixin {
  late AnimationController controller_timer;

  String get countText {
    Duration count = controller_timer.duration! * controller_timer.value;
    return '${count.inSeconds}';
  }

  @override
  void initState() {
    super.initState();
    controller_timer = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60),
    );
  }

  @override
  void dispose() {
    controller_timer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color.fromARGB(255, 5, 4, 76),
            Color.fromARGB(255, 5, 4, 76),
            Color.fromARGB(255, 5, 4, 51),
            Color.fromARGB(255, 5, 4, 26),
            Color.fromARGB(255, 5, 4, 26),
          ])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
              child: Text(countText,
                  style: TextStyle(
                      color: Color.fromRGBO(234, 245, 132, 12),
                      fontSize: 60,
                      fontWeight: FontWeight.bold)))),
    );
  }
}
