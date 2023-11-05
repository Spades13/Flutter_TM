//Here we build the statistics page. First we read data from Firebase and put it in to multiple lists that get assigned to graphs, for display. Here there is also a calendar widget for date selection
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tm/globals.dart' as globals;
import '/theme/theme_manager.dart';
import '/theme/theme_constants.dart';
import 'dart:async';
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import '/pages/loading.dart';

ThemeManager _themeManager = ThemeManager();

class Graphs extends StatefulWidget {
  @override
  State<Graphs> createState() => _GraphsState();
  const Graphs({super.key});
}

class IndividualBar {
  final int x;
  final double y;

  IndividualBar({
    required this.x,
    required this.y,
  });
}

class BarData2 {
  final double eff;

  BarData2({required this.eff});

  List<IndividualBar> barData2 = [];

  void initializeBarData2() {
    barData2 = [IndividualBar(x: 2, y: eff)];
  }
}

class BarData {
  final double monAmount;
  final double tueAmount;

  BarData({
    required this.monAmount,
    required this.tueAmount,
  });

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = [
      IndividualBar(x: 0, y: monAmount),
      IndividualBar(x: 1, y: tueAmount),
    ];
  }
}

class Test extends ChangeNotifier {
  //DateTime _date = DateTime.now();
  getBarData(variableDate) {
    StreamSubscription<QuerySnapshot>? _guestBookSubscription1;

    final user = FirebaseAuth.instance.currentUser;

    var user_email = user?.email;
    var year = variableDate.year.toString();
    var month = variableDate.month.toString();
    var day = globals.date.day.toString();
    var weekday = variableDate.weekday.toString();

    List mean_eff_list = [];
    List study_time_list = [];
    List break_time_list = [];

    _guestBookSubscription1 = FirebaseFirestore.instance
        .collection(user_email.toString())
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

        double study_time = document.get("Study Time");
        double break_time = document.get("Break Time");

        double math_mean_eff = mean_eff * 100;
        double hours_study = study_time / 3600;
        double hours_break = break_time / 3600;

        mean_eff_list.add(math_mean_eff);
        study_time_list.add(hours_study);
        break_time_list.add(hours_break);

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
      List<double> weeklySummary = [
        globals.sum_study_time_int.toDouble(),
        globals.sum_break_time_int.toDouble(),
        1,
        2,
        globals.avg_eff_int.toDouble()
      ];

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
        .collection(user_email.toString())
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

        //double mean_eff = document.get("Eff");

        double study_time = double.parse(document.get("Study Time"));
        double break_time = double.parse(document.get("Break Time"));

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

      _times = _times;
      _effs = _effs;

      globals.times_list = _times;
      globals.effs_list = _effs;

      print("Global Time: " + globals.times_list.toString());
      print("Local Time: " + _times.toString());

      //print(_effs);

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

class GuestBookMessage {
  GuestBookMessage({required this.time, required this.eff});
  final String time;
  final String eff;
}

class _GraphsState extends State<Graphs> {
  //List<double> weeklySummary = [1, 2, 3, 4, 5, 6, 7];

  /*
    final user = FirebaseAuth.instance.currentUser!;
    var user_email = user.email;
    var year = variableDate.year.toString();
    var month = variableDate.month.toString();
    var day = globals.date.day.toString();
    var weekday = variableDate.weekday.toString();
    print(day);

    List _times = [];
    List _effs = [];
    print("test 1");
    final docRef = FirebaseFirestore.instance
        .collection(user_email!)
        .doc(year)
        .collection(month)
        .doc(day)
        .collection(weekday)
        .get()
        .then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        print("${docSnapshot.id} => ${docSnapshot.get("Eff")}");

        double hours_line = double.parse(docSnapshot.get("Hours"));
        double minutes_line = double.parse(docSnapshot.get("Minutes"));
        double eff_line = docSnapshot.get("Eff");

        double math_time = hours_line + (minutes_line / 60);
        double math_eff = eff_line * 100;

        // double math_eff = docSnapshot.get("Eff") * 100
        _times.add(math_time);
        _effs.add(math_eff);
        print(_times);
      }
    });

    globals.times_list = _times;
    globals.effs_list = _effs;

    print(_times);
  }
  */

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2060),
    ).then((value) {
      setState(() {
        DateTime _date = value!;
        print("Selected Day: " + value.toString());
        globals.date = _date;
        var day = _date.day.toString();
        globals.day = day;
        globals.globalIndex = 1;
        //  print(day);
        //  print(_date);
        Test().getData(_date);
        //Test().getBarData(_date);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FutureBuilderX()));
      });
    });
  }

  @override
  void initState() {
    //Test().getData(DateTime.now());
    var _date = DateTime.now();
    Test().getData(_date);
    //Test().getBarData(_date);
    super.initState();
  }
  /* Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {},
      );

      AlertDialog alert = AlertDialog(
        title: Text("My title"),
        content: Text(data.toString()),
        actions: [
          okButton,
        ],*/
  //);

  // show the dialog
  //  showDialog(
  //  context: context,
  //  builder: (BuildContext context) {
  //    return alert;
  //  },
  // );
  // ...
  //});

  //.orderBy("Time", descending: true)
  //.snapshots()
  //.listen((snapshot) {
  //_studyDataMessages = [];
  // snapshot.docs.forEach((document) {
  // print(document.get("Time"));
  //print(document.get("Eff"));
  //print(document.get("TT"));
  /*_studyDataMessages.add(StudyDataMessage(
                                  time: document.data()["Time"],
                                  eff: document.data()["Eff"],
                                ));*/

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    Color? mainColor = _textTheme.headlineLarge?.color!;
    Color? scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    globals.mainColor = mainColor;

    final List<FlSpot> datalist =
        List.generate(globals.times_list.length, (index) {
      return FlSpot(globals.times_list[index],
          double.parse((globals.effs_list[index]).toStringAsFixed(1)));
    });

    //print("before print");
    //Test().getData(globals.date);
    //Future.delayed(const Duration(seconds: 5), () {});

    //final Future<List<FlSpot>> datalist_ = Future<List<FlSpot>>.delayed(const Duration(seconds: 3), () => globals.datalist);

    print("After print");

    //Future.delayed(const Duration(seconds: 3), () {});

    print("Future Time" + globals.datalist.toString());
    //print(globals.times_list.length);
    //List<String>.generate(1000,(counter) => "Item $counter");
    BarData myBarData = BarData(
      monAmount: /*Test().getBarData(globals.date).weeklySummary[0]*/
          globals.sum_study_time.toDouble(),
      tueAmount: /*Test().getBarData(globals.date).weeklySummary[1]*/
          globals.sum_break_time.toDouble(),
    );

    BarData2 myBarData2 = BarData2(
      eff: globals.avg_eff.toDouble(),
    );

    myBarData.initializeBarData();
    myBarData2.initializeBarData2();

    return Scaffold(
      backgroundColor: scaffoldColor,
      body: SafeArea(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(80, 25, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            child: Text("Statistics",
                                style: _textTheme.headlineMedium),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          width: 60,
                          child: MaterialButton(
                            onPressed: _showDatePicker,
                            color: globals.mainColor,
                            shape: StadiumBorder(),
                            child: Icon(
                              Icons.calendar_month,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Container(
                      child: Text(
                          "Date: " +
                              globals.date.day.toString() +
                              " / " +
                              globals.date.month.toString() +
                              " / " +
                              globals.date.year.toString(),
                          style: _textTheme.labelSmall),
                    ),
                  ),
                  Container(
                    child: Text("Total Work Time",
                        style: _textTheme.headlineSmall),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  //    Row(
                  //  children: [

                  SizedBox(
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(65, 0, 0, 0),
                          child: SizedBox(
                            //height: 100,
                            width: 50,
                            child: BarChart(
                              BarChartData(
                                  alignment: BarChartAlignment.center,
                                  titlesData: FlTitlesData(
                                      show: true,
                                      topTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                              showTitles: true,
                                              getTitlesWidget: getTopTitles)),
                                      leftTitles: AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false)),
                                      rightTitles: AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false)),
                                      bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                              showTitles: true,
                                              getTitlesWidget:
                                                  getBottomTitles))),
                                  maxY: 24,
                                  minY: 0,
                                  groupsSpace: 95,
                                  gridData: FlGridData(show: false),
                                  borderData: FlBorderData(show: false),
                                  barGroups: myBarData.barData
                                      .map((data) => BarChartGroupData(
                                              x: data.x,
                                              barRods: [
                                                BarChartRodData(
                                                    toY: data.y,
                                                    width: 35,
                                                    color: _textTheme
                                                        .headlineLarge?.color!,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    backDrawRodData:
                                                        BackgroundBarChartRodData(
                                                      show: true,
                                                      toY: 24,
                                                      color:
                                                          const Color.fromRGBO(
                                                              39,
                                                              39,
                                                              39,
                                                              0.957),
                                                    )),
                                              ]))
                                      .toList()),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(145, 0, 0, 0),
                          child: SizedBox(
                            // height: 50,

                            width: 50,
                            child: BarChart(BarChartData(
                                alignment: BarChartAlignment.center,
                                titlesData: FlTitlesData(
                                    show: true,
                                    topTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                            showTitles: true,
                                            getTitlesWidget: getTopTitles)),
                                    leftTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false)),
                                    rightTitles: AxisTitles(
                                        sideTitles:
                                            SideTitles(showTitles: false)),
                                    bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                            showTitles: true,
                                            getTitlesWidget: getBottomTitles))),
                                maxY: 100,
                                minY: 0,
                                groupsSpace: 100,
                                gridData: FlGridData(show: false),
                                borderData: FlBorderData(show: false),
                                barGroups: myBarData2.barData2
                                    .map((data) =>
                                        BarChartGroupData(x: data.x, barRods: [
                                          BarChartRodData(
                                              toY: data.y,
                                              width: 35,
                                              color: _textTheme
                                                  .headlineLarge?.color!,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              backDrawRodData:
                                                  BackgroundBarChartRodData(
                                                show: true,
                                                toY: 100,
                                                color: const Color.fromRGBO(
                                                    39, 39, 39, 0.957),
                                              )),
                                        ]))
                                    .toList())),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /*BarChart(BarChartData(
                          alignment: BarChartAlignment.center,
                          titlesData: FlTitlesData(
                              show: true,
                              topTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: getTopTitles)),
                              leftTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: getBottomTitles))),
                          maxY: 100,
                          minY: 0,
                          groupsSpace: 5,
                          gridData: FlGridData(show: false),
                          borderData: FlBorderData(show: false),
                          barGroups: myBarData2.barData2
                              .map((data) =>
                                  BarChartGroupData(x: data.x, barRods: [
                                    BarChartRodData(
                                        toY: data.y,
                                        width: 10,
                                        color: _textTheme.headlineLarge?.color!,
                                        borderRadius: BorderRadius.circular(5),
                                        backDrawRodData:
                                            BackgroundBarChartRodData(
                                          show: true,
                                          toY: 100,
                                          color: const Color.fromRGBO(
                                              39, 39, 39, 0.957),
                                        )),
                                  ]))
                              .toList())),*/

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Container(
                      child: Text("Work Efficiency",
                          style: _textTheme.headlineSmall),
                    ),
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: RotatedBox(
                              quarterTurns: 3,
                              child: Text("Efficiency",
                                  style: _textTheme.labelSmall)),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 50, 20, 10),
                              child: SizedBox(
                                  width: 1000,
                                  height: 225,
                                  child: LineChart(LineChartData(
                                      lineTouchData: LineTouchData(
                                          touchTooltipData:
                                              LineTouchTooltipData(
                                                  getTooltipItems:
                                                      (touchedSpots) {
                                        return touchedSpots
                                            .map((LineBarSpot touchedSpot) {
                                          final textStyle = TextStyle(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .color);
                                          return LineTooltipItem(
                                              touchedSpot.y.toString(),
                                              textStyle);
                                        }).toList();
                                      })),
                                      titlesData: FlTitlesData(
                                          show: true,
                                          topTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                  showTitles: false)),
                                          leftTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                  showTitles: true,
                                                  reservedSize: 50,
                                                  getTitlesWidget:
                                                      getSideTitles)),
                                          rightTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                  showTitles: false)),
                                          bottomTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                  showTitles: true,
                                                  getTitlesWidget:
                                                      getHourTitles))),
                                      minX: 0,
                                      maxX: 24,
                                      minY: 0,
                                      maxY: 100,
                                      baselineY: 120,
                                      gridData: FlGridData(
                                        show: false,
                                        getDrawingHorizontalLine: (value) {
                                          return FlLine(
                                            color: _textTheme
                                                .headlineLarge?.color!,
                                            strokeWidth: 1,
                                          );
                                        },
                                        drawVerticalLine: true,
                                      ),
                                      borderData: FlBorderData(show: false),
                                      lineBarsData: [
                                        LineChartBarData(
                                          spots: datalist,
                                          isCurved: false,
                                          color: globals.mainColor,
                                          barWidth: 5.5,
                                          belowBarData: BarAreaData(
                                              show: true,
                                              color: globals.mainColor!
                                                  .withOpacity(0.3)),
                                        ),
                                      ]))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      child: Text("Time of Day", style: _textTheme.labelSmall))
                ])),
      ),
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  final style = TextStyle(
      color: globals.mainColor, fontWeight: FontWeight.bold, fontSize: 14);

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = Text("Work Time", style: style);
      break;
    case 1:
      text = Text("Break Time", style: style);
      break;
    case 2:
      text = Text("Mean. Eff.", style: style);
      break;

    default:
      text = Text('', style: style);
      break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}

Widget getTopTitles(double value, TitleMeta meta) {
  final style = TextStyle(
      color: globals.mainColor, fontWeight: FontWeight.bold, fontSize: 14);

  Widget text;
  double decimalStudyTime =
      globals.sum_study_time - globals.sum_study_time.toInt();
  double minutesStudy = decimalStudyTime * 60;

  double decimalBreakTime =
      globals.sum_break_time - globals.sum_break_time.toInt();
  double minutesBreak = decimalBreakTime * 60;

  switch (value.toInt()) {
    case 0:
      //Takes time , which gets split in to its minutes above, and writes it above the graph in hours and minutes.
      text = Text(
          globals.sum_study_time.toInt().toString() +
              "h" +
              minutesStudy.ceil().toString() +
              "m",
          style: style);
      break;
    case 1:
      text = Text(
          globals.sum_break_time.toInt().toString() +
              "h" +
              minutesBreak.ceil().toString() +
              "m",
          style: style);
      break;
    case 2:
      text = Text(globals.avg_eff.toString() + " %", style: style);

      break;

    default:
      text = Text('', style: style);
      break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}

Widget getSideTitles(double value, TitleMeta meta) {
  final style = TextStyle(
      color: globals.mainColor, fontWeight: FontWeight.bold, fontSize: 14);

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = Text("0%", style: style);
      break;
    case 10:
      text = Text("10%", style: style);
      break;
    case 20:
      text = Text("20%", style: style);
      break;
    case 30:
      text = Text("30%", style: style);
      break;
    case 40:
      text = Text("40%", style: style);
      break;
    case 50:
      text = Text("50%", style: style);
      break;
    case 60:
      text = Text("60%", style: style);
      break;
    case 70:
      text = Text("70%", style: style);
      break;
    case 80:
      text = Text("80%", style: style);
      break;
    case 90:
      text = Text("90%", style: style);
      break;
    case 100:
      text = Text("100%", style: style);
      break;
    default:
      text = Text('', style: style);
      break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}

Widget getHourTitles(double value, TitleMeta meta) {
  final style = TextStyle(
      color: globals.mainColor, fontWeight: FontWeight.bold, fontSize: 14);

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = Text("00:00", style: style);
      break;
    case 1:
      text = Text("01:00", style: style);
      break;
    case 2:
      text = Text("02:00", style: style);
      break;
    case 3:
      text = Text("03:00", style: style);
      break;
    case 4:
      text = Text("04:00", style: style);
      break;
    case 5:
      text = Text("05:00", style: style);
      break;
    case 6:
      text = Text("06:00", style: style);
      break;
    case 7:
      text = Text("07:00", style: style);
      break;
    case 8:
      text = Text("08:00", style: style);
      break;
    case 9:
      text = Text("09:00", style: style);
      break;
    case 10:
      text = Text("10:00", style: style);
      break;
    case 11:
      text = Text("11:00", style: style);
      break;
    case 12:
      text = Text("12:00", style: style);
      break;
    case 13:
      text = Text("13:00", style: style);
      break;
    case 14:
      text = Text("14:00", style: style);
      break;
    case 15:
      text = Text("15:00", style: style);
      break;
    case 16:
      text = Text("16:00", style: style);
      break;
    case 17:
      text = Text("17:00", style: style);
      break;
    case 18:
      text = Text("18:00", style: style);
      break;
    case 19:
      text = Text("19:00", style: style);
      break;
    case 20:
      text = Text("20:00", style: style);
      break;
    case 21:
      text = Text("21:00", style: style);
      break;
    case 22:
      text = Text("22:00", style: style);
      break;
    case 23:
      text = Text("23:00", style: style);
      break;
    case 24:
      text = Text("24:00", style: style);
      break;
    default:
      text = Text('', style: style);
      break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}
