import 'package:flutter/material.dart';

class SigninButton extends StatelessWidget {
  final Function()? onTap;
  const SigninButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(25),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(color: Color.fromARGB(255, 20, 15, 121),
        borderRadius: BorderRadius.circular(25)
        ),
        child: Center(child: Text(
          "Sign In",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}