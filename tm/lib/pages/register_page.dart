import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tm/components/prompt.dart';
import 'package:tm/components/button.dart';
import 'package:tm/components/square_tile.dart';
import 'package:lottie/lottie.dart';




class RegisterPage extends StatefulWidget {
  void Function()? onTap;
  
   RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text options
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //acces to sign up user
  void signUp() async{
    //loading
    showDialog(context: context, builder: (context){
      return Center(child: CircularProgressIndicator(),);
    });

   try {
     //check if confirm pass is same
     if (passwordController.text == confirmPasswordController.text){
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text, 
      password: passwordController.text
      );
     } else{
      //show that passwords do not match
      showErrorMessage("Passowrds don't match!");
      
     }
    

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
              Lottie.network('https://assets1.lottiefiles.com/packages/lf20_UHhZXv9VWn.json', width:80, height: 80,fit: BoxFit.fill),
          
              SizedBox(height: 20),
          
              Text(
                'Let\'s create an account!',
                style: _textTheme.headlineSmall),
              SizedBox(height: 25),
          
              //username
              Text_Field(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),
              SizedBox(height: 10),
          
              //password
              Text_Field(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height:10),


              Text_Field(
                controller: confirmPasswordController,
                hintText: 'Confirm Passowrd',
                obscureText: true,
              ),
              const SizedBox(height:10),
              //i forgor
              
              
              const SizedBox(height: 25),
          
              SigninButton(
                onTap: signUp,
                text: 'Sign up',
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
                SquareTile()
              ],),
              const SizedBox(height: 50),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text('Already have an accounts?'),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    'Login now',
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