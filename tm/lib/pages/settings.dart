import 'package:flutter/material.dart';
import 'package:tm/theme/theme_manager.dart';
import 'package:tm/theme/theme_constants.dart';
//import 'package:flutter_settings_screens/flutter_settings_screens.dart';

ThemeManager _themeManager = ThemeManager();

class Settings extends StatefulWidget {
  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {
  int _currentIcon = 0;

  List<bool> isSelected = [false];
  List<bool> isSelected2 = [true];
  List<Widget> lighticon = [
    Icon(Icons.lightbulb),
    Icon(Icons.lightbulb_outline)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [Switch(value: _themeManager.themeMode == ThemeMode.dark, onChanged: (newValue){
        _themeManager.toggleTheme(newValue);
      })]),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text("Settings",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Row(
                    children: const [
                      Text("Dark/Light", style: TextStyle(fontSize: 15)),
                    ],
                  ),
                  ToggleButtons(
                    // ignore: sort_child_properties_last
                    children: <Widget>[
                      lighticon[_currentIcon],
                    ],
                    isSelected: isSelected,
                    onPressed: (int newIndex) {
                     
                      //print(newIndex);
                      setState(() {
                        for (int index = 0;
                            index < isSelected.length;
                            index++) {
                          if (index == newIndex) {
                            isSelected2[index] = !isSelected2[index];
                          }
                          if (isSelected2[index] == true) {
                            _currentIcon = 0;
                            //_themeManager.toggleTheme(true);
                          }
                          if (isSelected2[index] == false) {
                            _currentIcon = 1;
                            //_themeManager.toggleTheme(false);
                          }
                        } //when clicked it returns: 0
                        // MAKE ICON CHANGE WHEN TAPPED WITH THE NEW LISTS I MADE
                      });
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
