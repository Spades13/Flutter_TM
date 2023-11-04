// Creation of break hours list for visuals

import 'package:flutter/material.dart';

class BHours extends StatelessWidget {
  int bhours;

  BHours({required this.bhours});

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
          child: Center(
        child: Text(bhours.toString().padLeft(2, "0"),
            style: _textTheme.headlineSmall),
      )),
    );
  }
}
