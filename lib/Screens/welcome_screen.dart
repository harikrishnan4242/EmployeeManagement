
import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeState();
}

class _WelcomeState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  'assests/png_images/welcome_screen_icon.png',
                ),
                Text('Welcome to the Employee Management System. Please login or signup to continue.', style: Theme.of(context).textTheme.titleLarge,textAlign: TextAlign.center,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(onPressed: (){
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
                    }, child: Text('Login', style: Theme.of(context).textTheme.bodyLarge,)),
                    ElevatedButton(onPressed: (){
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen(),));
                    }, child: Text('Signup',style: Theme.of(context).textTheme.bodyLarge))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
