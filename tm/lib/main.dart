import 'package:flutter/material.dart';
import "homepage.dart";
import 'tracking.dart';
//import 'pages/settings.dart';
import 'theme/theme_manager.dart';
import 'theme/theme_constants.dart';

void main() {
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
      setState(() {
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: darkTheme,
      darkTheme: lightTheme,
      themeMode: _themeManager.themeMode,
    );
  }
}
int _currentIcon = 0;
class Settings extends StatefulWidget {
  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {
  

  List<bool> isSelected = [false];
  List<bool> isSelected2 = [true];
  List<Widget> lighticon = [
    Icon(Icons.lightbulb),
    Icon(Icons.lightbulb_outline)
  ];

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    return Scaffold(
    //TODO : ADD SCROLL FUNCTION AND MAKE ALL THE SETTINGS WIDGETS(POP OUT SCREENS ETC) ONLY THEN START WORKING ON EACH   
      body: SafeArea(
      
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text("Settings",
                  style: _textTheme.headlineMedium ),
              Row(
                children: [
                  Row(
                    children: const [
                      Text("Dark/Light", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
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
                            _themeManager.toggleTheme(false);
                          }
                          if (isSelected2[index] == false) {
                            _currentIcon = 1;
                            _themeManager.toggleTheme(true);
                          }
                        } //when clicked it returns: 0
                        // MAKE ICON CHANGE WHEN TAPPED WITH THE NEW LISTS I MADE
                        //Make the themes work with true or false statments(TOGGLETHEME(FALSE)
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