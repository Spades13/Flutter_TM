import 'package:flutter/cupertino.dart';
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
  
  List<Widget> lighticon = [
    Icon(Icons.dark_mode_sharp),
    Icon(Icons.light_mode_sharp)
  ];
  bool value = false;
  int index = 0;
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
              Text("Settings",
                  style: _textTheme.headlineMedium ),
              Row(
                children: [
                  Row(
                    children: const [
                      SizedBox(height: 30,)
                    ],
                  ),
                
                ],
              ),

              Column(//one settigns widget 
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      
                      
                      
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        SizedBox(width: 15),
                        Text("Dark/Light", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(width: 120),

                        lighticon[index],
                        SizedBox(width: 10),
                        CupertinoSwitch(value: value, onChanged: (value)=> setState(() {
                          this.value = value;
                          if(value == true){
                            _themeManager.toggleTheme(true);
                            index = 1 ;

                          }
                          if(value == false){
                            _themeManager.toggleTheme(false);
                            index = 0;

                          }
                        })),
                        
                        ],),),],),

                      
                Column(//one settigns widget 
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container( 
                      //color: Colors.black,
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          ExpansionTile(
                        title: Text('Sounds/Music', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        children: [
                          Text('select sound')
                        ],
                        ),
                        ], ))], ),
                Column(//one settigns widget 
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container( 
                      //color: Colors.black,
                      child: Column(
                        children: [
                          ExpansionTile(
                        title: Text('Account', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        children: [
                          Text('account name and other thingfs')
                        ],
                        ),
                        ], ))], ),
                  Column(//one settigns widget 
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container( 
                      //color: Colors.black,
                      child: Column(
                        children: [
                          ExpansionTile(
                        title: Text('FAQ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        children: [
                          Text('About us:'),
                          Text("TM:")
                        ],
                        ),
                        ], ))], ),
                        


                  Column(//one settigns widget 
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
                    child: Container( 
                    child: Text('Button', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    
                    ))
                    ], )
                
            ],
          ),
        ),
      ),
      )
    );
  }
}