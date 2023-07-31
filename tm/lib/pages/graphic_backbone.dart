import 'package:flutter/material.dart';
import 'package:tm/pages/graphic.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tm/pages/loading.dart';
import 'package:tm/globals.dart' as globals;

@override
void initState() {
  int globalIndex = 0;
  globals.globalIndex = globalIndex;
}

class HomePag extends StatefulWidget {
  const HomePag({Key? key}) : super(key: key);

  @override
  _HomePagState createState() => _HomePagState();
}

class _HomePagState extends State<HomePag> {
  int currentGlobalIndex = 0;

  final List<Widget> _pages = [
    Graphs(),
    FutureBuilderExampleApp(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[currentGlobalIndex],
        floatingActionButton: FloatingActionButton(onPressed: () {
          setState(() {
            currentGlobalIndex = globals.globalIndex;
          });
        }));

    //backgroundColor: Color.fromARGB(255, 5, 4, 51),
  }
}
