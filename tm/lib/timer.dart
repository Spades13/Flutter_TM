import 'package:flutter/material.dart';
import 'dart:async';
import 'package:usage_stats/usage_stats.dart';
//import 'package:permission_handler/permission_handler.dart';
import 'main.dart';
import 'package:flutter/services.dart';
import 'pages/userhomepage.dart' as userhomepage;
import 'globals.dart' as globals;
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(Tracking());
}

class Tracking extends StatefulWidget {
  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> with WidgetsBindingObserver {
  late Timer timer;
  Duration count_study =
      Duration(hours: globals.study_hour, minutes: globals.study_minutes);
  bool active = true;

  late Timer break_timer;
  Duration count_break =
      Duration(hours: globals.break_hour, minutes: globals.break_minutes);
  bool active_break = false;
//list to overlap timers
  List<Widget> _timerstate = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    timer = Timer.periodic(Duration(seconds: 1), (tm) {
      if (active == true) {
        if (count_study > Duration(seconds: 0)) {
          setState(() {
            count_study -= Duration(seconds: 1);
          });
        } else {
          timer.cancel();
          active_break = true;
          active = false;
          count_break += Duration(
              hours: globals.break_hour, minutes: globals.break_minutes);
        }
      }
    });
    break_timer = Timer.periodic(Duration(seconds: 1), (tm) {
      if (active_break == true) {
        if (count_break > Duration(seconds: 0)) {
          setState(() {
            count_break -= Duration(seconds: 1);
          });
        } else {
          break_timer.cancel();
          active_break = false;
          active = true;
          count_study += Duration(
              hours: globals.study_hour, minutes: globals.study_minutes);
          print(count_study);
        }
      }
    });
  }
  //set var to  1 or 2 depending on break or study to change body:

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    break_timer.cancel();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      active = true;
      print("Resumed");
    } else if (state == AppLifecycleState.inactive) {
      active = false;
      active_break = false;
      print("Inactive");
    } else if (state == AppLifecycleState.detached) {
      active = false;
      active_break = false;
      print("Paused");
    } else if (state == AppLifecycleState.paused) {
      active = false;
      active_break = false;
      print("Paused");
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;

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
          body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                    child: Text(
                        "${(count_study.inHours).toString().padLeft(2, "0")}:${(count_study.inMinutes % 60).toString().padLeft(2, "0")}:${(count_study.inSeconds % 60).toString().padLeft(2, "0")}",
                        style: TextStyle(
                            color: Color.fromRGBO(234, 245, 132, 12),
                            fontSize: 60,
                            fontWeight: FontWeight.bold))),
                Center(
                    child: Text(
                        "${(count_break.inHours).toString().padLeft(2, "0")}:${(count_break.inMinutes % 60).toString().padLeft(2, "0")}:${(count_break.inSeconds % 60).toString().padLeft(2, "0")}",
                        style: TextStyle(
                            color: Color.fromRGBO(149, 132, 245, 0.957),
                            fontSize: 60,
                            fontWeight: FontWeight.bold))),
              ]),
        ));
  }
}
