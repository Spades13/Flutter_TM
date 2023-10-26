import 'package:flutter/material.dart';
import 'package:tm/pages/graphic.dart';
import 'package:tm/pages/loading.dart';
import 'minutesstudy.dart';
import 'hoursstudy.dart';
import 'minutesbreak.dart';
import 'hoursbreak.dart';
import 'startbutton.dart';
import 'timer.dart';
//import 'pages/settings.dart';
import 'pages/userhomepage.dart';
import 'pages/graphic.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'main.dart';
import 'theme/theme_constants.dart';

import 'package:tm/globals.dart' as globals;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  //const HomePag({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    UserHome(),
    Settings(),
    Graphs(),
  ];

  selectIndex() {
    if (globals.current_index == 2) {
      globals.current_index = 2;
      //Navigator.push(context,
      //MaterialPageRoute(builder: (context) => FutureBuilderExample()));
      return globals.current_index;
    } else {
      return globals.current_index;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[globals.current_index],
      //backgroundColor: Color.fromARGB(255, 5, 4, 51),
      bottomNavigationBar: GNav(
        selectedIndex: selectIndex(),
        onTabChange: (index) {
          setState(() {
            globals.current_index = index;

            if (globals.current_index == 2) {
              globals.current_index = 2;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FutureBuilderX()));
              //return globals.current_index;
            } else {
              //return globals.current_index;
            }
          });
        },
        backgroundColor: Color.fromARGB(38, 0, 0, 0),
        activeColor: Colors.white,
        tabBackgroundColor: Color.fromARGB(22, 255, 255, 255),
        gap: 8,
        padding: EdgeInsets.all(23),
        tabs: const [
          GButton(
            icon: Icons.home,
            iconColor: Color.fromARGB(255, 255, 255, 255),
            text: 'Home',
          ),
          GButton(
              icon: Icons.settings,
              iconColor: Color.fromARGB(255, 255, 255, 255),
              text: 'Settings'),
          GButton(
              icon: Icons.auto_graph,
              iconColor: Color.fromARGB(255, 255, 255, 255),
              text: 'Stats'),
        ],
      ),
    );
  }
}
