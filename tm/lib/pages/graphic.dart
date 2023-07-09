import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tm/globals.dart' as globals;
import '/theme/theme_manager.dart';
import '/theme/theme_constants.dart';

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

class _GraphsState extends State<Graphs> {
  //List<double> weeklySummary = [1, 2, 3, 4, 5, 6, 7];
  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    Color? mainColor = _textTheme.headlineLarge?.color!;
    globals.mainColor = mainColor;

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
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text("Statistics", style: _textTheme.headlineMedium),
            ),
          ),
          Container(
            child: Text("Total Work Time", style: _textTheme.headlineSmall),
          ),
          SizedBox(
              height: 150,
              child: BarChart(BarChartData(
                  alignment: BarChartAlignment.center,
                  titlesData: FlTitlesData(
                      show: true,
                      topTitles: AxisTitles(
                          sideTitles: SideTitles(
                              showTitles: true, getTitlesWidget: getTopTitles)),
                      leftTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
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
                      .map((data) => BarChartGroupData(x: data.x, barRods: [
                            BarChartRodData(
                                toY: data.y,
                                width: 19,
                                color: _textTheme.headlineLarge?.color!,
                                borderRadius: BorderRadius.circular(4),
                                backDrawRodData: BackgroundBarChartRodData(
                                  show: true,
                                  toY: 24,
                                  color:
                                      const Color.fromRGBO(39, 39, 39, 0.957),
                                ))
                          ]))
                      .toList()))),
          Container(
            child: Text("Work Efficiency", style: _textTheme.headlineSmall),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 20, 10),
              child: SizedBox(
                  width: 500,
                  height: 250,
                  child: LineChart(LineChartData(
                      titlesData: FlTitlesData(
                          show: true,
                          topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 50,
                                  getTitlesWidget: getSideTitles)),
                          rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
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
                          spots: [
                            FlSpot(0, 30),
                            FlSpot(2.6, 20),
                            FlSpot(4.9, 5),
                            FlSpot(6.8, 25),
                            FlSpot(8, 40),
                            FlSpot(9.5, 30),
                            FlSpot(11, 40),
                          ],
                          isCurved: true,
                          color: globals.mainColor,
                          barWidth: 5.5,
                          belowBarData: BarAreaData(
                              show: true,
                              color: globals.mainColor!.withOpacity(0.3)),
                        )
                      ]))),
            ),
          ),
        ]),
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
