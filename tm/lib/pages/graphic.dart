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

ThemeManager _themeManager = ThemeManager();

class Graphs extends StatefulWidget {
  @override
  State<Graphs> createState() => _GraphsState();
}

class IndividualBar {
  final int x;
  final double y;

  IndividualBar({
    required this.x,
    required this.y,
  });
}

class BarData {
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;
  final double sunAmount;

  BarData({
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thuAmount,
    required this.friAmount,
    required this.satAmount,
    required this.sunAmount,
  });

  List<IndividualBar> barData = [];

  void initializeBarData() {
    barData = [
      IndividualBar(x: 0, y: monAmount),
      IndividualBar(x: 1, y: tueAmount),
      IndividualBar(x: 2, y: wedAmount),
      IndividualBar(x: 3, y: thuAmount),
      IndividualBar(x: 4, y: friAmount),
      IndividualBar(x: 5, y: satAmount),
      IndividualBar(x: 6, y: sunAmount),
    ];
  }
}

List<double> weeklySummary = [1, 2, 3, 4, 5, 6, 7];

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
        //  print(day);
        //  print(_date);
        Test().getData(_date);
      });
    });
  }

  @override
  void initState() {
    Test().getData(DateTime.now());

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
    globals.mainColor = mainColor;

    final List<FlSpot> datalist =
        List.generate(globals.times_list.length, (index) {
      return FlSpot(globals.times_list[index], globals.effs_list[index]);
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
      monAmount: weeklySummary[0],
      tueAmount: weeklySummary[1],
      wedAmount: weeklySummary[2],
      thuAmount: weeklySummary[3],
      friAmount: weeklySummary[4],
      satAmount: weeklySummary[5],
      sunAmount: weeklySummary[6],
    );
    myBarData.initializeBarData();

    return Scaffold(
      backgroundColor: Colors.transparent,
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
                              child: Icon(Icons.calendar_month),
                              color: globals.mainColor,
                              shape: StadiumBorder()),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: Text("Total Work Time",
                        style: _textTheme.headlineSmall),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                      height: 150,
                      child: BarChart(BarChartData(
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
                          maxY: 24,
                          minY: 0,
                          groupsSpace: 35,
                          gridData: FlGridData(show: false),
                          borderData: FlBorderData(show: false),
                          barGroups: myBarData.barData
                              .map((data) =>
                                  BarChartGroupData(x: data.x, barRods: [
                                    BarChartRodData(
                                        toY: data.y,
                                        width: 19,
                                        color: _textTheme.headlineLarge?.color!,
                                        borderRadius: BorderRadius.circular(4),
                                        backDrawRodData:
                                            BackgroundBarChartRodData(
                                          show: true,
                                          toY: 24,
                                          color: const Color.fromRGBO(
                                              39, 39, 39, 0.957),
                                        )),
                                  ]))
                              .toList()))),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: Text("Work Efficiency",
                        style: _textTheme.headlineSmall),
                  ),
                  SizedBox(height: 25),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
                      child: SizedBox(
                          width: 500,
                          height: 250,
                          child: LineChart(LineChartData(
                              titlesData: FlTitlesData(
                                  show: true,
                                  topTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                          showTitles: true,
                                          reservedSize: 50,
                                          getTitlesWidget: getSideTitles)),
                                  rightTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget: getHourTitles))),
                              minX: 0,
                              maxX: 24,
                              minY: 0,
                              maxY: 100,
                              gridData: FlGridData(
                                show: false,
                                getDrawingHorizontalLine: (value) {
                                  return FlLine(
                                    color: _textTheme.headlineLarge?.color!,
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
                                      color:
                                          globals.mainColor!.withOpacity(0.3)),
                                ),
                              ]))),
                    ),
                  ),
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
      text = Text("Mon", style: style);
      break;
    case 1:
      text = Text("Tue", style: style);
      break;
    case 2:
      text = Text("Wed", style: style);
      break;
    case 3:
      text = Text("Thu", style: style);
      break;
    case 4:
      text = Text("Fri", style: style);
      break;
    case 5:
      text = Text("Sat", style: style);
      break;
    case 6:
      text = Text("Sun", style: style);
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
  switch (value.toInt()) {
    case 0:
      text = Text(weeklySummary[0].toString() + " h", style: style);
      break;
    case 1:
      text = Text(weeklySummary[1].toString() + " h", style: style);
      break;
    case 2:
      text = Text(weeklySummary[2].toString() + " h", style: style);
      break;
    case 3:
      text = Text(weeklySummary[3].toString() + " h", style: style);
      break;
    case 4:
      text = Text(weeklySummary[4].toString() + " h", style: style);
      break;
    case 5:
      text = Text(weeklySummary[5].toString() + " h", style: style);
      break;
    case 6:
      text = Text(weeklySummary[6].toString() + " h", style: style);
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
      text = Text("0h", style: style);
      break;
    case 2:
      text = Text("2h", style: style);
      break;
    case 4:
      text = Text("4h", style: style);
      break;
    case 6:
      text = Text("6h", style: style);
      break;
    case 8:
      text = Text("8h", style: style);
      break;
    case 10:
      text = Text("10h", style: style);
      break;
    case 12:
      text = Text("12h", style: style);
      break;
    case 14:
      text = Text("14h", style: style);
      break;
    case 16:
      text = Text("16h", style: style);
      break;
    case 18:
      text = Text("18h", style: style);
      break;
    case 20:
      text = Text("20h", style: style);
      break;
    case 22:
      text = Text("22h", style: style);
      break;
    case 24:
      text = Text("24h", style: style);
      break;
    default:
      text = Text('', style: style);
      break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}
