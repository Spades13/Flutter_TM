import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tm/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
import 'package:confetti/confetti.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

ThemeManager _themeManager = ThemeManager();

void main() {
  runApp(Tracking());
}

class StudyDataMessage {
  StudyDataMessage({required this.time, required this.eff});
  final String time;
  final String eff;
}

class Tracking extends StatefulWidget {
  @override
  _TrackingState createState() => _TrackingState();
}

class _TrackingState extends State<Tracking> with WidgetsBindingObserver {
  final _controller = ConfettiController();

  late Timer timer;
  Duration count_study =
      Duration(hours: globals.study_hour, minutes: globals.study_minutes);
  bool active = true;

  late Timer break_timer;
  Duration count_break =
      Duration(hours: globals.break_hour, minutes: globals.break_minutes);
  bool active_break = false;

  late Timer total_timer;
  Duration count_total = Duration(hours: 0, minutes: 0, seconds: 0);

  late Timer active_timer;
  Duration count_active = Duration(hours: 0, minutes: 0, seconds: 1);
  bool active_active = true;
  final user = FirebaseAuth.instance.currentUser!;

  late Timer study_data_timer;
  Duration count_study_data = Duration(hours: 0, minutes: 0);

  late Timer break_data_timer;
  Duration count_break_data = Duration(hours: 0, minutes: 0);

//list to overlap timers
  //final audioPlayer = AudioPlayer();

  int cycle = globals.cycle_num;
  @override
  void initState() {
    //setAudio();
    super.initState();
    //for (int cycle = globals.cycle_num; cycle > 0; cycle--) {
    WidgetsBinding.instance.addObserver(this);
    //print(cycle);
    timer = Timer.periodic(Duration(seconds: 1), (tm) {
      if (active == true) {
        if (count_study > Duration(seconds: 0)) {
          setState(() {
            count_study -= Duration(seconds: 1);
          });
        } else {
          //timer.cancel();
          active_break = true;
          active = false;
          cycle--;
          if (cycle > 0) {
            //print(cycle);
            count_break = Duration(
                hours: globals.break_hour, minutes: globals.break_minutes);
          } else {
            count_break = Duration(hours: 0, minutes: 0);
            timer.cancel();
            checkend();
            //count_break = Duration(hours: 0, minutes: 0);
            //break_timer.cancel();
            // _controller.play();
          }

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
          //break_timer.cancel();
          active_break = false;
          active = true;
          //cycle--;
          if (cycle > 0) {
            //print(cycle);
            count_study = Duration(
                hours: globals.break_hour, minutes: globals.break_minutes);
          } else {
            count_study = Duration(hours: 0, minutes: 0);
            break_timer.cancel();
            checkend();

            // _controller.play();
          }

          /*count_study += Duration(
                  hours: globals.study_hour, minutes: globals.study_minutes);
              print(count_study);*/
        }
      }
    });

    study_data_timer = Timer.periodic(Duration(seconds: 1), (tm) {
      if (active == true) {
        setState(() {
          count_study_data += Duration(seconds: 1);
        });
      } else {
        //pass
      }
    });

    break_data_timer = Timer.periodic(Duration(seconds: 1), (tm) {
      if (active_break == true || active_active == false) {
        setState(() {
          count_break_data += Duration(seconds: 1);
        });
      } else {
        //pass
      }
    });

    if (count_study <= Duration(minutes: 15)) {
      int time_block = count_study.inSeconds;
      double full_block = 0;

      globals.time_block = time_block;
    } else {
      double block_amount = count_study.inMinutes / 15;
      int int_block_amount = block_amount.ceil();
      int time_block = 900;

      globals.time_block = time_block;

      /*if (int_block_amount < block_amount) {
        double ratio = block_amount - int_block_amount;
        double full_block = block_amount - ratio;
        int time_block = 15;
        int time_block1 = (ratio * 15).ceil();

        globals.ratio = ratio;
        globals.full_block = full_block;
        globals.time_block = time_block;
        globals.time_block1 = time_block1;
      } else if (int_block_amount > block_amount) {
        double ratio = 1 - (int_block_amount - block_amount);
        double full_block = block_amount - ratio;
        int time_block = 15;
        int time_block1 = (ratio * 15).ceil();

        globals.ratio = ratio;
        globals.full_block = full_block;
        globals.time_block = time_block;
        globals.time_block1 = time_block1;
      } else if (int_block_amount == block_amount) {
        double ratio = 0;
        double full_block = block_amount;
        int time_block = 15;
        int time_block1 = (ratio * 15).ceil();

        globals.ratio = ratio;
        globals.full_block = full_block;
        globals.time_block = time_block;
        globals.time_block1 = time_block1;
      }*/
    }

    total_timer = Timer.periodic(Duration(seconds: 1), (tm) {
      if (active_break == true) {
        //pass, meaning nothing is added
      } else {
        setState(() {
          count_total += Duration(seconds: 1);
          print("Total: ");
          print(count_total);
          //print(count_total);
        });

        int time_block = globals.time_block;

        /*if (cycle == 0 &&
            count_study.inSeconds == 0 /*count_total.inSeconds != 0*/) {
          int time_worked = count_active.inSeconds;
          double total_eff = (time_worked / (count_total.inSeconds));
          print("complete");
          print(total_eff);
          var time = DateTime.now();
          print(time.hour.toString() + ":" + time.minute.toString());
          print("Weekday: " + time.weekday.toString());
          print("Day: " + time.day.toString());
          print("Month: " + time.month.toString());
          print("Year: " + time.year.toString());

          FirebaseFirestore.instance
              .collection(user.email!)
              .doc(time.year.toString() +
                  "/" +
                  time.month.toString() +
                  "/" +
                  time.day.toString() +
                  "/" +
                  time.weekday.toString() +
                  "/" +
                  time.hour.toString().padLeft(2, "0") +
                  ":" +
                  time.minute.toString().padLeft(2, "0"))
              .set({
            "Hours": time.hour.toString(),
            "Minutes": time.minute.toString(),
            "Weekday": time.weekday.toString(),
            "Day": time.day.toString(),
            "Month": time.month.toString(),
            "Year": time.year.toString(),
            "Eff": total_eff,
            "TT": count_total.inSeconds,
            "Study Time": count_study_data.inSeconds,
            "Break Time": count_break_data.inSeconds,
            "userId": FirebaseAuth.instance.currentUser!.uid,
          });

          count_study_data = Duration(seconds: 0);
          count_break_data = Duration(seconds: 0);

          study_data_timer.cancel();
          break_data_timer.cancel();
          total_timer.cancel();
          active_timer.cancel();*/
        //} else {
        print(time_block);
        if (count_total >= Duration(seconds: time_block)) {
          int time_worked = count_active.inSeconds;
          double total_eff = (time_worked / (time_block));
          print("finished");
          print(total_eff);
          var time = DateTime.now();
          print(time.hour.toString() + ":" + time.minute.toString());
          print("Weekday: " + time.weekday.toString());
          print("Day: " + time.day.toString());
          print("Month: " + time.month.toString());
          print("Year: " + time.year.toString());

          FirebaseFirestore.instance
              .collection(user.email!)
              .doc(time.year.toString() +
                  "/" +
                  time.month.toString() +
                  "/" +
                  time.day.toString() +
                  "/" +
                  time.weekday.toString() +
                  "/" +
                  time.hour.toString().padLeft(2, "0") +
                  ":" +
                  time.minute.toString().padLeft(2, "0"))
              .set({
            "Hours": time.hour.toString(),
            "Minutes": time.minute.toString(),
            "Weekday": time.weekday.toString(),
            "Day": time.day.toString(),
            "Month": time.month.toString(),
            "Year": time.year.toString(),
            "Eff": total_eff,
            "TT": count_total.inSeconds,
            "Study Time": count_study_data.inSeconds.toString(),
            "Break Time": count_break_data.inSeconds.toString(),
            "userId": FirebaseAuth.instance.currentUser!.uid,
          });
          count_study_data = Duration(seconds: 0);
          count_break_data = Duration(seconds: 0);

          count_total = Duration(seconds: -1);
          count_active = Duration(seconds: -1);
        } else {
          //pass
        }
      }
    }
        //}
        /*}*/);

    active_timer = Timer.periodic(Duration(seconds: 1), (tm) {
      if (active_break == true) {
        //pass, meaning timer isnt working
      } else {
        if (active_active == true) {
          setState(() {
            count_active += Duration(seconds: 1);
            print("Active:");
            print(count_active);
          });
        } else if (active_active == false) {
          print("Not Working");
        }
      }
    });

    //here//
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

  /*Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.release);
    final player = AudioCache(prefix: 'assets/audio/');
    final url = await player.load(selectSound());
    audioPlayer.setSourceUrl(url.path);
    //audioPlayer.resume();
  }*/

  //check if break and assign music to it
  /*selectSound() {
    if (checkTimer() == 0) {
      return 'rain2.mp3';
    } else {
      return 'lofi.mp3';
    }
  }*/

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
    break_timer.cancel();
    total_timer.cancel();
    active_timer.cancel();
    study_data_timer.cancel();
    break_data_timer.cancel();
    WidgetsBinding.instance.removeObserver(this);
    //audioPlayer.dispose();
    _controller.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (active == true && active_break == false) {
      if (state == AppLifecycleState.resumed) {
        active = true;
        //active_break = true;
        //print("Resumed");
      } else if (state == AppLifecycleState.inactive) {
        active = false;
        //active_break = false;
        //print("Inactive");
      } else if (state == AppLifecycleState.detached) {
        active = false;
        //active_break = false;
        //print("Paused");
      } else if (state == AppLifecycleState.paused) {
        active = false;
        //active_break = false;
        //print("Paused");
      }
    }

    if (active == false && active_break == false) {
      if (state == AppLifecycleState.resumed) {
        active = true;
        //active_break = true;
        //print("Resumed");
      } else if (state == AppLifecycleState.inactive) {
        active = false;
        //active_break = false;
        //print("Inactive");
      } else if (state == AppLifecycleState.detached) {
        active = false;
        //active_break = false;
        //print("Paused");
      } else if (state == AppLifecycleState.paused) {
        active = false;
        //active_break = false;
        //print("Paused");
      }
    }

    if (active_break == true && active == false) {
      if (state == AppLifecycleState.resumed) {
        active_break = true;
        //print("Resumed");
      } else if (state == AppLifecycleState.inactive) {
        active_break = true;
        //active_break = false;
        //print("Inactive");
      } else if (state == AppLifecycleState.detached) {
        active_break = true;
        //active_break = false;
        //print("Paused");
      } else if (state == AppLifecycleState.paused) {
        active_break = true;
        //active_break = false;
        //print("Paused");
      }
    }

    if (active_active == true) {
      if (state == AppLifecycleState.resumed) {
        active_active = true;
        //print("Resumed");
      } else if (state == AppLifecycleState.inactive) {
        active_active = false;
        //active_break = false;
        //print("Inactive");
      } else if (state == AppLifecycleState.detached) {
        active_active = false;
        //active_break = false;
        //print("Paused");
      } else if (state == AppLifecycleState.paused) {
        active_active = false;
        //active_break = false;
        //print("Paused");
      }
    }

    if (active_active == false) {
      if (state == AppLifecycleState.resumed) {
        active_active = true;
        //print("Resumed");
      } else if (state == AppLifecycleState.inactive) {
        active_active = false;
        //active_break = false;
        //print("Inactive");
      } else if (state == AppLifecycleState.detached) {
        active_active = false;
        //active_break = false;
        //print("Paused");
      } else if (state == AppLifecycleState.paused) {
        active_active = false;
        //active_break = false;
        //print("Paused");
      }
    }
  }

  checkend() {
    if (cycle <= 0) {
      _controller.play();
    } else {
      _controller.stop();
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
    List<Widget> _breakorstudy = [
      Text('Study', style: _textTheme.headlineMedium),
      Text('Break', style: _textTheme.headlineMedium)
    ];
    //play music
    //audioPlayer.resume();
    //setAudio();
    //audioPlayer.resume();

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
              _breakorstudy[checkTimer()],
              Center(child: _timerstate[checkTimer()]),
              SizedBox(height: 80),
              ConfettiWidget(
                confettiController: _controller,
                blastDirection: -pi / 2,
                colors: [Colors.yellow, Colors.blue],
                gravity: 0.05,
                emissionFrequency: 0.1,
              ),
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
                      onPressed: () async {
                        //check if cycles are over and display confetti, if not just quit.
                        if (cycle == 0 && count_study.inSeconds == 0) {
                          int divider = count_total.inSeconds;
                          globals.divider = divider;
                          /*} else if (active_break = true) {
                          //pass
                          print("Nothing");*/
                        } else {
                          int divider = count_total.inSeconds + 1;

                          print("Divider");
                          print(divider);
                          double total_eff = count_active.inSeconds / (divider);
                          //print(total_eff);
                          var time = DateTime.now();
                          var user_email = user.email!;

                          FirebaseFirestore.instance
                              .collection(user.email!)
                              .doc(time.year.toString() +
                                  "/" +
                                  time.month.toString() +
                                  "/" +
                                  time.day.toString() +
                                  "/" +
                                  time.weekday.toString() +
                                  "/" +
                                  time.hour.toString().padLeft(2, "0") +
                                  ":" +
                                  time.minute.toString().padLeft(2, "0"))
                              .set({
                            "Hours": time.hour.toString(),
                            "Minutes": time.minute.toString(),
                            "Weekday": time.weekday.toString(),
                            "Day": time.day.toString(),
                            "Month": time.month.toString(),
                            "Year": time.year.toString(),
                            "Eff": total_eff,
                            "TT": count_total.inSeconds,
                            "Study Time": count_study_data.inSeconds.toString(),
                            "Break Time": count_break_data.inSeconds.toString(),
                            "userId": FirebaseAuth.instance.currentUser!.uid,
                          });
                          count_study_data = Duration(seconds: 0);
                          count_break_data = Duration(seconds: 0);

/////
/*
                          

                          FirebaseAuth.instance.userChanges().listen((user) {
                            
                            _studyData = FirebaseFirestore.instance
                                .collection(user_email)
                                .orderBy("Time", descending: true)
                                .snapshots()
                                .listen((snapshot) {
                              _studyDataMessages = [];
                              snapshot.docs.forEach((document) {
                                print(document.get("Time"));
                                print(document.get("Eff"));
                                print("test 1");
                                /*_studyDataMessages.add(StudyDataMessage(
                                  time: document.data()["Time"],
                                  eff: document.data()["Eff"],
                                ));*/
                              });
                              notifyListeners();
                            });
                          }); */ /////////////
                        }

                        if (cycle <= 0) {
                          Future.delayed(const Duration(seconds: 0), () {
                            Navigator.pop(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Tracking()));
                            //audioPlayer.stop();
                          });
                        } else {
                          Navigator.pop(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Tracking()));

                          //audioPlayer.stop();
                        }
                        //get rid of page and audio.stop is to stop music(duhh)
                      }),
                ],
              )
            ],
          )),
    );
  }
}
