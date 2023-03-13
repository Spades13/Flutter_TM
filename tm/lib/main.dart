import 'package:flutter/material.dart';
import "homepage.dart";
import 'tracking.dart';
import 'pages/settings.dart';
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
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
    );
  }
}


//Color.fromARGB(255, 5, 4, 51),
//234, 245, 132, 12
//