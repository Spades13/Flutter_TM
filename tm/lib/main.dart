import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "homepage.dart";
import 'timer.dart';
//import 'pages/settings.dart';
import 'theme/theme_manager.dart';
import 'theme/theme_constants.dart';
import 'utils/user_simple_preferences.dart';
import 'pages/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'globals.dart' as globals;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tm/globals.dart' as globals;
import '/theme/theme_manager.dart';
import '/theme/theme_constants.dart';
import 'dart:async';
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await UserSimplePreferences.init();

  runApp(MyApp());
}

ThemeManager _themeManager = ThemeManager();

class Test extends ChangeNotifier {
  //DateTime _date = DateTime.now();
  getBarData(variableDate) {
    StreamSubscription<QuerySnapshot>? _guestBookSubscription;

    final user = FirebaseAuth.instance.currentUser!;
    var user_email = user.email;
    var year = variableDate.year.toString();
    var month = variableDate.month.toString();
    var day = globals.date.day.toString();
    var weekday = variableDate.weekday.toString();

    List mean_eff_list = [];

    _guestBookSubscription = FirebaseFirestore.instance
        .collection(user_email!)
        .doc(year)
        .collection(month)
        .doc(day)
        .collection(weekday)
        // .orderBy('Time', descending: true)
        .snapshots()
        .listen((snapshot) {
      print("testyyyyy");
      snapshot.docs.forEach((document) {
        double mean_eff = document.get("Eff");
        double math_mean_eff = mean_eff * 100;
        mean_eff_list.add(math_mean_eff);

        // double math_eff = docSnapshot.get("Eff") * 100

        //print("test 709");
      });

      if (mean_eff_list.isEmpty) {
        mean_eff_list = [0.toDouble()];
      } else {
        mean_eff_list = mean_eff_list;
      }

      int len_mean_eff = mean_eff_list.length;
      double avg_eff = mean_eff_list.reduce((a, b) => a + b) / len_mean_eff;
      globals.avg_eff = avg_eff;
      print(len_mean_eff);

      notifyListeners();
    });
  }

  getData(variableDate) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      //pass
    } else {
      //setState(() {
      StreamSubscription<QuerySnapshot>? _guestBookSubscription;
      // List<GuestBookMessage> _guestBookMessages = [];
      //List<GuestBookMessage> get guestBookMessages => _guestBookMessages;

      //final user = FirebaseAuth.instance.currentUser!;
      var user_email = user.email;
      var year = variableDate.year.toString();
      var month = variableDate.month.toString();
      var day = globals.date.day.toString();
      var weekday = variableDate.weekday.toString();

      List _times = [];
      List _effs = [];
      //  print(day);

      //print("testy");

      print("firebase print");
      _guestBookSubscription = FirebaseFirestore.instance
          .collection(user_email!)
          .doc(year)
          .collection(month)
          .doc(day)
          .collection(weekday)
          // .orderBy('Time', descending: true)
          .snapshots()
          .listen((snapshot) {
        print("testyyyyy");
        snapshot.docs.forEach((document) {
          double hours_line = double.parse(document.get("Hours"));
          double minutes_line = double.parse(document.get("Minutes"));
          double eff_line = document.get("Eff");

          double math_time = hours_line + (minutes_line / 60);
          double math_eff = eff_line * 100;

          // double math_eff = docSnapshot.get("Eff") * 100
          _times.add(math_time);
          _effs.add(math_eff);

          //print("test 709");
        });
        //print(_times);
        //print(_effs);
        print("test 69");

        if (_effs.isEmpty || _times.isEmpty) {
          _times = [0.toDouble(), 24.toDouble()];
          _effs = [0.toDouble(), 0.toDouble()];
        } else {
          _times = _times;
          _effs = _effs;
        }

        globals.times_list = _times;
        globals.effs_list = _effs;

        print("Global Time: " + globals.times_list.toString());
        print("Local Time: " + _times.toString());
        //print(_effs);

        notifyListeners();
      });
    }
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    var _date = globals.date;
    Test().getData(_date);
    Test().getBarData(_date);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

// changes theme ON LOAD UP depending on the set preference
  setTheme() {
    if (UserSimplePreferences.getValue() == false) {
      return ThemeMode.light;
    } else {
      return ThemeMode.dark;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyAuth(),
      theme: darkTheme,
      darkTheme: lightTheme,
      themeMode: setTheme(),
    );
  }
}

class Settings extends StatefulWidget {
  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {
  List<Widget> lighticon = [
    Icon(Icons.dark_mode_sharp),
    Icon(Icons.light_mode_sharp)
  ];
  bool value = UserSimplePreferences.getValue() ?? false;
  final user = FirebaseAuth.instance.currentUser!;

//changes icon depending of the set preference
  setIcon() {
    if (UserSimplePreferences.getValue() == true) {
      return 1;
    }
    if (UserSimplePreferences.getValue() == false) {
      return 0;
    }
    if (UserSimplePreferences.getValue() == null) {
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    return Scaffold(
        //TODO : ADD SCROLL FUNCTION AND MAKE ALL THE SETTINGS WIDGETS(POP OUT SCREENS ETC) ONLY THEN START WORKING ON EACH
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Settings", style: _textTheme.headlineMedium),
              Row(
                children: [
                  Row(
                    children: const [
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ],
              ),
              Column(
                //one settigns widget
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 15),
                        Text("Dark/Light",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(width: 120),
                        lighticon[setIcon()],
                        SizedBox(width: 10),
                        CupertinoSwitch(
                            value: value,
                            onChanged: (value) => setState(() {
                                  this.value = value;
                                  if (value == true) {
                                    _themeManager.toggleTheme(true);
                                    //sets theme preference(bool)
                                    UserSimplePreferences.setValue(value);
                                  }
                                  if (value == false) {
                                    _themeManager.toggleTheme(false);
                                    //sets theme preference(bool)

                                    UserSimplePreferences.setValue(value);
                                  }
                                })),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                //one settigns widget
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      //color: Colors.black,
                      child: Column(
                    children: [
                      SizedBox(height: 20),
                      ExpansionTile(
                        title: Text(
                          'Sounds/Music',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        children: [Text('select sound')],
                      ),
                    ],
                  ))
                ],
              ),
              Column(
                //one settigns widget
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      //color: Colors.black,
                      child: Column(
                    children: [
                      ExpansionTile(
                        title: Text(
                          'Account',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                Text(
                                  'Email: ' + user.email!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ))
                ],
              ),
              Column(
                //one settigns widget
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      //color: Colors.black,
                      child: Column(
                    children: [
                      ExpansionTile(
                        title: Text(
                          'FAQ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        children: [Text('About us:'), Text("TM:")],
                      ),
                    ],
                  ))
                ],
              ),
              Divider(
                thickness: 1,
                color: Color.fromARGB(255, 129, 129, 129),
              ),
              SizedBox(height: 60),
              Column(
                //one settigns widget
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        primary: Color.fromARGB(127, 15, 6, 141)),
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Container(
                          child: Text(
                            'LOG OUT',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
