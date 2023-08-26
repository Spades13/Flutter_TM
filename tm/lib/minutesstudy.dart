import 'package:flutter/material.dart';

class SMinutes extends StatelessWidget {
  int smins;

  SMinutes({required this.smins});

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
          child: Center(
        child: Text(smins.toString().padLeft(2, "0"),
            style: _textTheme.headlineSmall),
      )),
    );
  }
}
