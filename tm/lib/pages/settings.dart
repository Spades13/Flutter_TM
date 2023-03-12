import 'package:flutter/material.dart';
//import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class Settings extends StatefulWidget {
  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {
  int _currentIcon = 0;

  List<bool> isSelected = [false];
  List<Widget> lighticon = [
    Icon(Icons.lightbulb_circle),
    Icon(Icons.lightbulb_circle_sharp)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text("Settings",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  ToggleButtons(
                    // ignore: sort_child_properties_last
                    children: <Widget>[
                      lighticon[_currentIcon],
                    ],
                    isSelected: isSelected,
                    onPressed: (int newIndex) {
                      print(newIndex);
                      //when clicked it returns:
                      // MAKE ICON CHANGE WHEN TAPPED WITH THE NEW LISTS I MADE
                    },
                    renderBorder: false,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
