//This is the main file for the programm, and the entire app runs through this code. We also have the settings page built in main.dart
//because we needed to change the theme mode which is a main.dart feature

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
    } else if (UserSimplePreferences.getValue() == true) {
      return ThemeMode.dark;
    } else if (UserSimplePreferences.getValue() == null) {
      print("Value NULL");
      return ThemeMode.light;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyAuth(),
      theme: lightTheme,
      darkTheme: darkTheme,
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
    Icon(Icons.light_mode_sharp),
    Icon(Icons.dark_mode_sharp),
  ];
  bool value = UserSimplePreferences.getValue() ?? false;
  final user = FirebaseAuth.instance.currentUser;

//changes icon depending of the set preference
  setIcon() {
    if (UserSimplePreferences.getValue() == true) {
      return 1;
    }
    if (UserSimplePreferences.getValue() == false) {
      return 0;
    }
    if (UserSimplePreferences.getValue() == null) {
      return 0;
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
                        Text("Dark/Light", style: _textTheme.headlineSmall),
                        SizedBox(width: 90),
                        lighticon[setIcon()],
                        SizedBox(width: 10),
                        CupertinoSwitch(
                            value: value,
                            onChanged: (value) => setState(() {
                                  this.value = value;
                                  if (value == false) {
                                    _themeManager.toggleTheme(true);
                                    //sets theme preference(bool)
                                    UserSimplePreferences.setValue(value);
                                  }
                                  if (value == true) {
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
                      ExpansionTile(
                        title: Text(
                          'Account',
                          style: _textTheme.headlineSmall,
                        ),
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                Text(
                                  'Email: ${user?.email}',
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
                          style: _textTheme.headlineSmall,
                        ),
                        children: [
                          Text(
                              'About us: We are two students from Ecole Moser, and we decided to take on the challenge of making a study app'),
                          Text(
                              "App: This app uses the pommodoro technique in combination with data recording, to check if the user is distracted by their phone. Then feedback about efficiency is given on the stats page")
                        ],
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
                        primary: Color.fromARGB(61, 21, 142, 223)),
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
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => MyAuth()));
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
