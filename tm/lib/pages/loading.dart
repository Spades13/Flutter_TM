import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tm/globals.dart' as globals;
import '../homepage.dart';
import '/theme/theme_manager.dart';
import '/theme/theme_constants.dart';
import 'dart:async';
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:threading/threading.dart';
import 'graphic.dart';

void main() => runApp(const FutureBuilderExampleApp());

class FutureBuilderExampleApp extends StatelessWidget {
  const FutureBuilderExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FutureBuilderExample(),
    );
  }
}

class Test extends ChangeNotifier {
  //DateTime _date = DateTime.now();
  getData(variableDate) {
    //setState(() {
    StreamSubscription<QuerySnapshot>? _guestBookSubscription;
    // List<GuestBookMessage> _guestBookMessages = [];
    //List<GuestBookMessage> get guestBookMessages => _guestBookMessages;

    final user = FirebaseAuth.instance.currentUser!;
    var user_email = user.email;
    var year = variableDate.year.toString();
    var month = variableDate.month.toString();
    var day = globals.date.day.toString();
    var weekday = variableDate.weekday.toString();

    List _times = [];
    List _effs = [];
    //  print(day);

    //print("testy");

    print("firebase print");
    _guestBookSubscription = FirebaseFirestore.instance
        .collection(user_email!)
        .doc(year)
        .collection(month)
        .doc(day)
        .collection(weekday)
        // .orderBy('Time', descending: true)
        .snapshots()
        .listen((snapshot) {
      print("testyyyyy");
      snapshot.docs.forEach((document) {
        double hours_line = double.parse(document.get("Hours"));
        double minutes_line = double.parse(document.get("Minutes"));
        double eff_line = document.get("Eff");

        double math_time = hours_line + (minutes_line / 60);
        double math_eff = eff_line * 100;

        // double math_eff = docSnapshot.get("Eff") * 100
        _times.add(math_time);
        _effs.add(math_eff);

        //print("test 709");
      });
      //print(_times);
      //print(_effs);
      print("test 69");

      if (_effs.isEmpty || _times.isEmpty) {
        _times = [0.toDouble(), 24.toDouble()];
        _effs = [0.toDouble(), 0.toDouble()];
      } else {
        _times = _times;
        _effs = _effs;
      }

      globals.times_list = _times;
      globals.effs_list = _effs;

      print("Global Time: " + globals.times_list.toString());
      print("Local Time: " + _times.toString());
      //print(_effs);

      notifyListeners();
    });
  }
}

@override
void initState() async {
  Test().getData(globals.date);

  var thread = Thread(_FutureBuilderExampleState().update());
  thread.start();
  //super.initState();
}

class FutureBuilderExample extends StatefulWidget {
  const FutureBuilderExample({super.key});

  @override
  State<FutureBuilderExample> createState() => _FutureBuilderExampleState();
}

class _FutureBuilderExampleState extends State<FutureBuilderExample> {
  final Future<int> globalIndex = Future<int>.delayed(
    const Duration(seconds: 3),
    () => 0,
  );

  update() async {
    await Thread.sleep(500);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      textAlign: TextAlign.center,
      child: FutureBuilder<int>(
        future: globalIndex,

        // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          List<Widget> children;

          if (snapshot.hasData) {
            //  globals.globalIndex = snapshot.data!;

            /*Navigator.pop(
                context,
                MaterialPageRoute(
                    builder: (context) => FutureBuilderExample()));*/
            children = <Widget>[
              /* Container(
                  child: ElevatedButton(
                      child: Icon(Icons.face),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                     })),*/
              const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Result: ${snapshot.data}'),
              ),
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Fetching data...'),
              ),
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}
