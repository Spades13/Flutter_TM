//integrates authentication with firebase in to the sign in page. Moves the user to the homepage if sign in succesfull

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tm/homepage.dart';
import 'package:tm/pages/login.dart';

import 'login_or_register.dart';

class MyAuth extends StatelessWidget {
  const MyAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //login
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return LoginOrRegisterPage();
          }
          //not login
        },
      ),
    );
  }
}
