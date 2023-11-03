//Here we build the Login page. This has the google authentication button aswell
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tm/components/prompt.dart';
import 'package:tm/components/button.dart';
import 'package:tm/components/square_tile.dart';
import 'package:lottie/lottie.dart';
import 'package:tm/services/auth_service.dart';




class LoginPage extends StatefulWidget {
  void Function()? onTap;
  
   LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text options
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  //acces to sign in user
  void signIn() async{
    //loading
    showDialog(context: context, builder: (context){
      return Center(child: CircularProgressIndicator(),);
    });

   try {
     await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text, 
      password: passwordController.text
      );
    Navigator.pop(context);

   } on FirebaseAuthException catch (error){
    Navigator.pop(context);

    //wrong email
    showErrorMessage(error.code);
   }
    //rid of the loading
  }

  void showErrorMessage(String message){
    showDialog(context: context, builder:(context) {
      return AlertDialog(title: Text(message));
    },);
  }

 

  @override
  Widget build(BuildContext context) {
      
    TextTheme _textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              SizedBox(height: 0),
          
              /*Icon(
              Icons.lock,
              size: 80,
              ),*/
              //REPLACE WITH LOGO WHEN LOGO IS MADE FOR APP
              Lottie.network('https://assets1.lottiefiles.com/packages/lf20_UHhZXv9VWn.json', width:150, height: 150,fit: BoxFit.fill),
          
              SizedBox(height: 25),
          
              Text(
                'Welcome!',
                style: _textTheme.headlineSmall),
              SizedBox(height: 25),
          
              //username
              Text_Field(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),
              SizedBox(height: 15),
          
              //password
              Text_Field(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height:10),
              //i forgor
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Color.fromARGB(255, 206, 205, 205))
                      ),
                  ],
                ),
              ),
              
              const SizedBox(height: 25),
          
              SigninButton(
                onTap: signIn,
                text: 'Sign In',
              ),
          
              const SizedBox(height: 50),
              
              Row(
                children: [
                  Expanded(child: Divider(
                thickness: 0.5,
                color: Color.fromARGB(136, 255, 255, 255),
                )
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text('Or continue with',
                  
                  ),
                ),
                Expanded(child: Divider(
                thickness: .55,
                color: Color.fromARGB(136, 255, 255, 255),
          
                )
                ),
          
                ],
              ),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                SquareTile(
                  onTap: () => AuthService().signInWithGoogle(),
                )
              ],),
              const SizedBox(height: 50),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text('No account?'),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    'Register now',
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                ),
              ],)
          
          
                
                
                
            ]),
          ),
        ),
      ),
    );
  }
}