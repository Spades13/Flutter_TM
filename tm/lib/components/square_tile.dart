import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  const SquareTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(border: Border.all(color: Color.fromARGB(124, 255, 255, 255)), borderRadius: BorderRadius.circular(25), color: Color.fromARGB(41, 158, 158, 158)),
      child: Image.asset('assets/google.png', height: 40),
    );
  }
}