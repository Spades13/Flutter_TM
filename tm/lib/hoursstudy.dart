// Creation of study hours list for visuals

import 'package:flutter/material.dart';

class SHours extends StatelessWidget {
  int shours;

  SHours({required this.shours});

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
          child: Center(
        child: Text(shours.toString().padLeft(2, "0"),
            style: _textTheme.headlineSmall),
      )),
    );
  }
}
