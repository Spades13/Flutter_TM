import 'package:flutter/material.dart';

class Text_Field extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const Text_Field({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText
    });

  @override
  Widget build(BuildContext context) {
    return  Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: TextField(
                controller: controller,
                obscureText: obscureText,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 15, 13, 150)),
                  ),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey),
                  ),
                  fillColor: Color.fromARGB(166, 16, 5, 73),
                  filled: true,
                  hintText: hintText,
                  hintStyle: TextStyle(color: Color.fromARGB(144, 153, 153, 153))
                ),
            
              ),
            );
  }
}