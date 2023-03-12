import 'package:flutter/material.dart';
import 'dart:async';
import 'package:usage_stats/usage_stats.dart';
//import 'package:permission_handler/permission_handler.dart';
import 'main.dart';
import 'package:flutter/services.dart';
import 'pages/userhomepage.dart';

void main() {
  runApp(Tracking());
}

class Tracking extends StatefulWidget {
  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> with WidgetsBindingObserver {
  late Timer timer;
  int count_study_seconds = 0;
  bool active = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    timer = Timer.periodic(Duration(seconds: 1), (tm) {
      if (active) {
        setState(() {
          count_study_seconds -= 1;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
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
      print("Inactive");
    } else if (state == AppLifecycleState.detached) {
      active = false;
      print("Paused");
    } else if (state == AppLifecycleState.paused) {
      active = false;
      print("Paused");
    }
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
              child: Text("$count_study_seconds",
                  style: TextStyle(
                      color: Color.fromRGBO(234, 245, 132, 12),
                      fontSize: 60,
                      fontWeight: FontWeight.bold)))),
    );
  }
}
