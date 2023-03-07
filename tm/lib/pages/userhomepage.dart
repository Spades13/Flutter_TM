import 'package:flutter/material.dart';
import 'package:tm/hoursbreak.dart';
import 'package:tm/hoursstudy.dart';
import 'package:tm/minutesbreak.dart';
import 'package:tm/minutesstudy.dart';
import 'package:tm/startbutton.dart';



class UserHome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    backgroundColor: Color.fromARGB(255, 5, 4, 51),
    
     body: Column(
      

        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 30, 0),
                child: 
                
                Container(
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                    children: [
                      Container(
                          width: 60,
                          height: 500,
                          child: ListWheelScrollView.useDelegate(
                              onSelectedItemChanged: (value) => print(value),
                              itemExtent: 40,
                              perspective: 0.005,
                              diameterRatio: 0.8,
                              physics: const FixedExtentScrollPhysics(),
                              childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: 24,
                                  builder: (context, index) {
                                    return SHours(
                                      shours: index,
                                    );
                                  }))),
                      Container(
                          child: const Text(":",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ))),
                      Container(
                          width: 60,
                          height: 500,
                          child: ListWheelScrollView.useDelegate(
                              onSelectedItemChanged: (value) => print(value),
                              itemExtent: 40,
                              perspective: 0.005,
                              diameterRatio: 0.8,
                              physics: const FixedExtentScrollPhysics(),
                              childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: 60,
                                  builder: (context, index) {
                                    return SMinutes(
                                      smins: index,
                                    );
                                  }))),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 20, 0),
                child: Container(
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                    children: [
                      Container(
                          width: 60,
                          height: 500,
                          child: ListWheelScrollView.useDelegate(
                              itemExtent: 40,
                              perspective: 0.005,
                              diameterRatio: 0.8,
                              physics: const FixedExtentScrollPhysics(),
                              childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: 24,
                                  builder: (context, index) {
                                    return BHours(
                                      bhours: index,
                                    );
                                  }))),
                      Container(
                          child: const Text(":",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ))),
                      Container(
                          width: 60,
                          height: 500,
                          child: ListWheelScrollView.useDelegate(
                              itemExtent: 40,
                              perspective: 0.005,
                              diameterRatio: 0.8,
                              physics: const FixedExtentScrollPhysics(),
                              childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: 60,
                                  builder: (context, index) {
                                    return BMinutes(
                                      bmins: index,
                                    );
                                  }))),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(height: 50, width: 100, child: Startbutton()),
                //Container(height: 100, child: AppBarOur()),
                //AppBarOur(),
                //Startbutton(),
              ]),
        ],
      ),
   );
  }
}