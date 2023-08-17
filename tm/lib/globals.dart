import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

int study_hour = 0;
int study_minutes = 0;
int break_hour = 0;
int break_minutes = 0;
int cycle_num = 0;

int time_block = 0;
int time_block1 = 0;
double ratio = 0;
double full_block = 0;

var email = "null";

int divider = 0;

Color? mainColor = Colors.white;

// ignore: constant_identifier_names
Object? data_line = 0;

double hours_line = 0;
double minutes_line = 0;
double eff_line = 0;
List times_list = [];
List effs_list = [];

DateTime date = DateTime.now();

String year = DateTime.now().year.toString();
String month = DateTime.now().month.toString();
String day = DateTime.now().day.toString();
String weekday = DateTime.now().weekday.toString();
List<FlSpot> datalist = [];

int globalIndex = 0;
int current_index = 0;

double avg_eff = 0;
