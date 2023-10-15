import 'package:flutter/material.dart';
import 'package:tm/hoursbreak.dart';
import 'package:tm/hoursstudy.dart';
import 'package:tm/minutesbreak.dart';
import 'package:tm/minutesstudy.dart';
import 'package:tm/startbutton.dart';
import 'package:tm/globals.dart' as globals;

const List<String> list = <String>[
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10'
];

class DropdownButtonItem extends StatefulWidget {
  const DropdownButtonItem({super.key});

  @override
  State<DropdownButtonItem> createState() => _DropdownButtonItemState();
}

class _DropdownButtonItemState extends State<DropdownButtonItem> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down_circle),
      elevation: 0,
      style: _textTheme.headlineSmall,
      underline: Container(height: 0),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
        print(dropdownValue);
        globals.cycle_num = int.parse(dropdownValue);
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class UserHome extends StatelessWidget {
  //variables

  int study_hour = 0;
  int study_minutes = 0;
  int break_hour = 0;
  int break_minutes = 0;

  @override
  Widget build(BuildContext context) {
    globals.study_hour = 0;
    globals.study_minutes = 0;
    globals.break_hour = 0;
    globals.break_minutes = 0;

    TextTheme _textTheme = Theme.of(context).textTheme;
    return Container(
      //decoration: const BoxDecoration(
      //  gradient: LinearGradient(
      //      begin: Alignment.topCenter,
      //        end: Alignment.bottomCenter,
      //       colors: [
      //     Color.fromARGB(255, 5, 4, 76),
      //     Color.fromARGB(255, 5, 4, 76),
      //     Color.fromARGB(255, 5, 4, 51),
      //      Color.fromARGB(255, 5, 4, 26),
      //     Color.fromARGB(255, 5, 4, 26),
      //])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                  padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            child: Text("Cycles",
                                style: _textTheme.headlineMedium)),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 6, 0, 0),
                          child: Container(child: DropdownButtonItem()),
                        )
                      ])),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          //color: Colors.black,
                          child:
                              Text(" Study", style: _textTheme.headlineMedium),
                        ),
                        Container(
                            //color: Colors.black,
                            child: Text("Break ",
                                style: _textTheme.headlineMedium)),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 50, 0, 0),
                            child: Text("Hours  Minutes",
                                style: _textTheme.labelSmall),
                          )),
                          Container(
                              child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                            child: Text("Hours  Minutes",
                                style: _textTheme.labelSmall),
                          )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 30, 0),
                            child: Container(
                              padding: const EdgeInsets.all(0.0),
                              child: Row(
                                children: [
                                  Container(
                                      //color: Colors.black,
                                      width: 60,
                                      height: 250,
                                      child: ListWheelScrollView.useDelegate(
                                          onSelectedItemChanged: (value) =>
                                              globals.study_hour = value,
                                          itemExtent: 40,
                                          perspective: 0.005,
                                          diameterRatio: 1.2,
                                          useMagnifier: true,
                                          magnification: 1.5,
                                          physics:
                                              const FixedExtentScrollPhysics(),
                                          childDelegate:
                                              ListWheelChildBuilderDelegate(
                                                  childCount: 24,
                                                  builder: (context, index) {
                                                    return SHours(
                                                      shours: index,
                                                    );
                                                  }))),
                                  Container(
                                      child: const Text(":",
                                          style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ))),
                                  Container(
                                      //color: Colors.black,
                                      width: 60,
                                      height: 250,
                                      child: ListWheelScrollView.useDelegate(
                                          onSelectedItemChanged: (value1) =>
                                              globals.study_minutes = value1,
                                          itemExtent: 40,
                                          perspective: 0.005,
                                          diameterRatio: 1.2,
                                          useMagnifier: true,
                                          magnification: 1.5,
                                          physics:
                                              const FixedExtentScrollPhysics(),
                                          childDelegate:
                                              ListWheelChildBuilderDelegate(
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
                                      height: 250,
                                      child: ListWheelScrollView.useDelegate(
                                          onSelectedItemChanged: (value2) =>
                                              globals.break_hour = value2,
                                          itemExtent: 40,
                                          perspective: 0.005,
                                          diameterRatio: 1.2,
                                          physics:
                                              const FixedExtentScrollPhysics(),
                                          useMagnifier: true,
                                          magnification: 1.5,
                                          childDelegate:
                                              ListWheelChildBuilderDelegate(
                                                  childCount: 6,
                                                  builder: (context, index) {
                                                    return BHours(
                                                      bhours: index,
                                                    );
                                                  }))),
                                  Container(
                                      child: const Text(":",
                                          style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ))),
                                  Container(
                                      width: 60,
                                      height: 250,
                                      child: ListWheelScrollView.useDelegate(
                                          onSelectedItemChanged: (value3) =>
                                              globals.break_minutes = value3,
                                          itemExtent: 40,
                                          perspective: 0.005,
                                          diameterRatio: 1.2,
                                          useMagnifier: true,
                                          magnification: 1.5,
                                          physics:
                                              const FixedExtentScrollPhysics(),
                                          childDelegate:
                                              ListWheelChildBuilderDelegate(
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
                    ],
                  ),
                  Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                          child: Container(
                              height: 100, width: 280, child: Startbutton()),
                        ),
                        //Container(height: 100, child: AppBarOur()),
                        //AppBarOur(),
                        //Startbutton(),
                      ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
