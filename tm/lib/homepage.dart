import 'package:flutter/material.dart';
import 'package:tm/pages/graphic.dart';
import 'appbarour.dart';
import 'minutesstudy.dart';
import 'hoursstudy.dart';
import 'minutesbreak.dart';
import 'hoursbreak.dart';
import 'startbutton.dart';
import 'tracking.dart';
import 'pages/settings.dart';
import 'pages/userhomepage.dart';
import 'pages/graphic.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages=[
    UserHome(),
    Settings(),
    Graphs(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: _pages[_currentIndex],  

    backgroundColor: Color.fromARGB(255, 5, 4, 51),

    bottomNavigationBar: GNav(
      selectedIndex: _currentIndex,
      onTabChange: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      backgroundColor: Color.fromARGB(38, 0, 0, 0),
      activeColor: Colors.white,
      tabBackgroundColor: Color.fromARGB(22, 255, 255, 255),
      gap: 8,
      padding: EdgeInsets.all(23),
      tabs: const [
        GButton(icon: Icons.home,
        iconColor: Color.fromARGB(255, 255, 255, 255),
        text: 'Home',
        ),
        GButton(icon: Icons.settings,
        iconColor: Color.fromARGB(255, 255, 255, 255),
        text: 'Settings'),
        GButton(icon: Icons.auto_graph,
        iconColor: Color.fromARGB(255, 255, 255, 255),
        text: 'Stats'),

      ],
    ),
    );
  }
}
