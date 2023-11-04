// Creation of break minutes list for visuals

import 'package:flutter/material.dart';

class BMinutes extends StatelessWidget {
  int bmins;

  BMinutes({required this.bmins});

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
          child: Center(
        child: Text(bmins.toString().padLeft(2, "0"),
            style: _textTheme.headlineSmall),
      )),
    );
  }
}
