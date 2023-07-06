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

class _GraphsState extends State<Graphs> {
  List<double> weeklySummary = [1, 2, 3, 4, 5, 6, 7];
  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;

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
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                    height: 200,
                    child: BarChart(BarChartData(
                        alignment: BarChartAlignment.center,
                        titlesData: FlTitlesData(
                            show: true,
                            topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: getBottomTitles,
                            ))),
                        maxY: 24,
                        minY: 0,
                        barGroups: myBarData.barData
                            .map((data) =>
                                BarChartGroupData(x: data.x, barRods: [
                                  BarChartRodData(
                                      toY: data.y,
                                      width: 8,
                                      color: _textTheme.headlineLarge?.color!)
                                ]))
                            .toList())))
              ]),
        ));
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style =
      TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14);

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text("Mon", style: style);
      break;
    case 1:
      text = const Text("Tue", style: style);
      break;
    case 2:
      text = const Text("Wed", style: style);
      break;
    case 3:
      text = const Text("Thu", style: style);
      break;
    case 4:
      text = const Text("Friday", style: style);
      break;
    case 5:
      text = const Text("Sat", style: style);
      break;
    case 6:
      text = const Text("Sun", style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}
