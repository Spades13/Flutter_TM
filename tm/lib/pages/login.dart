import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tm/components/prompt.dart';
import 'package:tm/components/button.dart';
import 'package:tm/components/square_tile.dart';
import 'package:lottie/lottie.dart';




class LoginPage extends StatefulWidget {
  
   LoginPage({super.key});

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
    if(error.code == "invalid-email"){
      wrongEmail();
    }
    //wrong password
    else if(error.code == 'wrong-password'){
      wrongPassword();
    }
   }
    //rid of the loading
  }

  void wrongEmail(){
    showDialog(context: context, builder:(context) {
      return const AlertDialog(title: Text("Incorect Email!"),);
    },);
  }

  void wrongPassword(){
    showDialog(context: context, builder:(context) {
      return const AlertDialog(title: Text("Incorect Password!"),);
    },);
  }

  @override
  Widget build(BuildContext context) {
      
    TextTheme _textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Center(
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
              style: _textTheme.headlineMedium),
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
              Text('No account?'),
              const SizedBox(width: 4),
              Text(
                'Register now',
                style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                ),
            ],)


              
              
              
          ]),
        ),
      ),
    );
  }
}