import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/Screens/splash_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    storageBucket: 'fir-1-fe5ec.appspot.com',
    apiKey: 'AIzaSyAhX6xpYHoGQGkY6beE6PjiCH9bKsLnhdE',
    appId: '1:313230439006:android:59c660890998614d7afacf',
    messagingSenderId: '313230439006',
    projectId: 'fir-1-fe5ec',
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shadowColor: Colors.white,
                foregroundColor: Colors.transparent,
                minimumSize: const Size(90, 40),
                maximumSize: const Size(130, 80))),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            titleTextStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
        buttonTheme: const ButtonThemeData(buttonColor: Colors.black),
        textTheme: const TextTheme(
            bodyLarge: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
            titleLarge: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.w600),
            bodyMedium: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
            bodySmall: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 14)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
