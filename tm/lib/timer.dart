import 'package:flutter/material.dart';
import 'package:tm/homepage.dart';
import 'dart:async';
import 'package:usage_stats/usage_stats.dart';
//import 'package:permission_handler/permission_handler.dart';
import 'main.dart';
import 'package:flutter/services.dart';
import 'pages/userhomepage.dart' as userhomepage;
import 'globals.dart' as globals;
import 'package:audioplayers/audioplayers.dart';
import 'theme/theme_manager.dart';
import 'theme/theme_constants.dart';
import 'utils/user_simple_preferences.dart';

ThemeManager _themeManager = ThemeManager();

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
  final audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    //setAudio();
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
          /*count_break += Duration(
              hours: globals.break_hour, minutes: globals.break_minutes);*/
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
          /*count_study += Duration(
              hours: globals.study_hour, minutes: globals.study_minutes);
          print(count_study);*/
        }
      }
    });
  }

  checkTimer() {
    int index = 0;
    if (active == true) {
      index = 0;
      return index;
    } else {
      index = 1;
      return index;
    }
  }

  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    final player = AudioCache(prefix: 'assets/audio/');
    final url = await player.load(selectSound());
    audioPlayer.setSourceUrl(url.path);
    //audioPlayer.resume();
  }

  //check if break and assign music to it
  selectSound() {
    if (checkTimer() == 0) {
      return 'rain2.mp3';
    } else {
      return 'lofi.mp3';
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    break_timer.cancel();
    WidgetsBinding.instance.removeObserver(this);
    audioPlayer.dispose();
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

  checkBg() {
    if (UserSimplePreferences.getValue() == true) {
      return 'assets/lightmode.jpg';
    } else {
      return 'assets/lofi-cozy-house-rainy-night-thumb.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    List<Widget> _timerstate = [
      Text(
        "${(count_study.inHours).toString().padLeft(2, "0")}:${(count_study.inMinutes % 60).toString().padLeft(2, "0")}:${(count_study.inSeconds % 60).toString().padLeft(2, "0")}",
        style: _textTheme.headlineLarge,
      ),
      Text(
          "${(count_break.inHours).toString().padLeft(2, "0")}:${(count_break.inMinutes % 60).toString().padLeft(2, "0")}:${(count_break.inSeconds % 60).toString().padLeft(2, "0")}",
          style: _textTheme.headlineLarge),
    ];
    //play music
    //audioPlayer.resume();
    setAudio();
    audioPlayer.resume();

    /*decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(255, 5, 4, 76),
              Color.fromARGB(255, 5, 4, 76),
              Color.fromARGB(255, 5, 4, 51),
              Color.fromARGB(255, 5, 4, 26),
              Color.fromARGB(255, 5, 4, 26),
            ])),*/
    return Container(
      decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage(checkBg()), fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: _timerstate[checkTimer()]),
              SizedBox(height: 80),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        minimumSize: Size(110, 75),
                        textStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                        //primary: Color.fromARGB(500, 23, 228, 255),
                        primary: Color.fromARGB(61, 21, 142, 223),
                        onPrimary: Color.fromRGBO(234, 245, 132, 12),
                      ),
                      child: Text('QUIT'),
                      onPressed: () {
                        //get rid of page and audio.stop is to stop music(duhh)
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Tracking()));
                        audioPlayer.stop();
                      }),
                ],
              )
            ],
          )),
    );
  }
}
