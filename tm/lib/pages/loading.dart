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
  getBarData(variableDate) {
    StreamSubscription<QuerySnapshot>? _guestBookSubscription;

    final user = FirebaseAuth.instance.currentUser;
    var user_email = user?.email;
    var year = variableDate.year.toString();
    var month = variableDate.month.toString();
    var day = globals.date.day.toString();
    var weekday = variableDate.weekday.toString();

    List mean_eff_list = [];
    List study_time_list = [];
    List break_time_list = [];

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
        double mean_eff = document.get("Eff");

        double study_time = 3.00; //document.get("Study Time");

        double break_time = 3.00; //document.get("Break Time");

        double math_mean_eff = mean_eff * 100;
        double hours_study = study_time / 3600;
        double hours_break = break_time / 3600;

        mean_eff_list.add(math_mean_eff);
        study_time_list.add(hours_study);
        break_time_list.add(hours_break);

        // double math_eff = docSnapshot.get("Eff") * 100

        //print("test 709");
      });

      if (mean_eff_list.isEmpty) {
        mean_eff_list = [0.toDouble()];
      } else if (study_time_list.isEmpty) {
        study_time_list = [0.toDouble()];
      } else if (break_time_list.isEmpty) {
        break_time_list = [0.toDouble()];
      } else {
        mean_eff_list = mean_eff_list;
        study_time_list = study_time_list;
        break_time_list = break_time_list;
      }

      int len_mean_eff = mean_eff_list.length;
      double avg_eff = mean_eff_list.reduce((a, b) => a + b) / len_mean_eff;
      int avg_eff_int = avg_eff.ceil();

      double sum_study_time =
          study_time_list.reduce((value, element) => value + element);
      int sum_study_time_int = sum_study_time.ceil();

      double sum_break_time =
          break_time_list.reduce((value, element) => value + element);
      int sum_break_time_int = sum_break_time.ceil();

      globals.avg_eff = avg_eff;
      globals.avg_eff_int = avg_eff_int;

      globals.sum_break_time = sum_break_time;
      globals.sum_break_time_int = sum_break_time_int;

      globals.sum_study_time = sum_study_time;
      globals.sum_study_time_int = sum_study_time_int;
      print(len_mean_eff);

      notifyListeners();
    });
  }

  getData(variableDate) {
    //setState(() {
    StreamSubscription<QuerySnapshot>? _guestBookSubscription;
    // List<GuestBookMessage> _guestBookMessages = [];
    //List<GuestBookMessage> get guestBookMessages => _guestBookMessages;

    final user = FirebaseAuth.instance.currentUser;
    var user_email = user?.email;
    var year = variableDate.year.toString();
    var month = variableDate.month.toString();
    var day = globals.date.day.toString();
    var weekday = variableDate.weekday.toString();

    List _times = [];
    List _effs = [];

    List mean_eff_list = [];
    List study_time_list = [];
    List break_time_list = [];
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

        double study_time = double.parse(document.get("Study Time"));
        double break_time = double.parse(document.get("Break Time"));

        print("Global Time: " + globals.times_list.toString());
        print("Local Time: " + _times.toString());

        double math_mean_eff = eff_line * 100;
        double hours_study = study_time / 3600;
        double hours_break = break_time / 3600;

        mean_eff_list.add(math_mean_eff);
        study_time_list.add(hours_study);
        break_time_list.add(hours_break);

        //print("test 709");
      });
      //print(_times);
      //print(_effs);
      print("test 69");

      globals.times_list = _times;
      globals.effs_list = _effs;

      if (mean_eff_list.isEmpty) {
        globals.avg_eff = 0.0;
      } else {
        int len_mean_eff = mean_eff_list.length;
        double avg_eff = mean_eff_list.reduce((a, b) => a + b) / len_mean_eff;
        globals.avg_eff = double.parse(avg_eff.toStringAsFixed(2));
      }

      if (study_time_list.isEmpty) {
        globals.sum_study_time = 0.0;
      } else {
        double sum_study_time =
            study_time_list.reduce((value, element) => value + element);
        globals.sum_study_time =
            double.parse(sum_study_time.toStringAsFixed(2));
      }

      if (break_time_list.isEmpty) {
        globals.sum_break_time = 0.0;
      } else {
        double sum_break_time =
            break_time_list.reduce((value, element) => value + element);
        globals.sum_break_time =
            double.parse(sum_break_time.toStringAsFixed(2));
      }

      //print(len_mean_eff);
      List<double> weeklySummary = [
        globals.sum_study_time, //_int.toDouble(),
        globals.sum_break_time, //_int.toDouble(),
        globals.avg_eff, //_int.toDouble()
      ];

      //print(_effs);

      notifyListeners();
    });
  }
}

@override
void initState() async {
  Test().getData(globals.date);
  //Test().getBarData(globals.date);
  //super.initState();
}

class FutureBuilderExample extends StatefulWidget {
  const FutureBuilderExample({super.key});

  @override
  State<FutureBuilderExample> createState() => _FutureBuilderExampleState();
}

class _FutureBuilderExampleState extends State<FutureBuilderExample> {
  final Future<int> globalIndex = Future<int>.delayed(
    const Duration(seconds: 1),
    () => 0,
  );

  update() async {
    
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
              Expanded(
                child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                        child: Text("Tap the screen"),
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(0, 255, 145, 0)),
                        onPressed: () {
                          globals.current_index = 2;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        })),
              ),
              /*const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 60,
              ),*/
              /*Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Result: ${snapshot.data}'),
              ),*/
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
              /*Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Fetching data...'),
              ),*/
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
