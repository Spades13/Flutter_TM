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
                      Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyAuth()));
                      
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
