import 'package:flutter/material.dart';
import 'package:tm/pages/login.dart';
import 'package:tm/pages/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool showLoginPage = true;

  //toggle login and register
  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }


  @override
  Widget build(BuildContext context) {
   if(showLoginPage){
    return LoginPage(onTap: togglePages);
   } else{
    return RegisterPage(onTap: togglePages,);
   }
  }
}