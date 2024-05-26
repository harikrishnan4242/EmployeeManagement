import 'package:flutter/material.dart';

import '../Services/firebase_service.dart';
import 'home.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    if (FirebaseServices().getUser() == null) {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WelcomeScreen(),
              ));
        },
      );
    } else {
      Future.delayed(const Duration(seconds: 2),() {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
  },);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              'assests/png_images/splash_icon.png',
              alignment: Alignment.center,
              height: 100,
              width: 250,
            )),
      ),
    );
  }
}
