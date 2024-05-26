
import 'package:firebase_demo/Screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../BlocManagement/signin_blog.dart';
import '../EventManagement/signin_event.dart';
import '../Services/firebase_service.dart';
import '../StateManagement/signin_state.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  bool showPass = true;
  final formKey = GlobalKey<FormState>();
  final _blog = SignInBlog();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

@override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  
  String? emailRex(String? email) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(email!)) {
      return 'Please Enter a valid Email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener(
          bloc: _blog,
      listener: (context, state) {
        if (state is SignInSuccessState) {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ));
        } else if (state is SignInLoadState) {
          showDialog(
            context: context,
            builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
        } else if (state is SignInErrorEvent) {
          showDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                'Error!',
                style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
              content: Text(
                state.error,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          );
          setState(() {
            emailController.text = '';
          passwordController.text = '';
          });
        }
      },
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    'Hello There,\nWelcome back',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                controller: emailController,
                validator: (value) => emailRex(value),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: Theme.of(context).textTheme.bodySmall,
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2))),
              ),
              const SizedBox(
                height: 25,
              ),
                                TextFormField(
                    maxLines: 1,
                    controller: passwordController,
                    obscureText: showPass,
                    validator: (value) => value!.length<6?'Please enter password 6 character':null,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                showPass = showPass ? false : true;
                              });
                            },
                            icon: showPass
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility)),
                        hintStyle: Theme.of(context).textTheme.bodySmall,
                        focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2))),
                  ),
              const SizedBox(
                height: 25,
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            FirebaseServices().signIn(email: emailController.text, password: passwordController.text, blog: _blog);
                          }
                        },
                        child: Text(
                          'SIGN IN',
                          style: Theme.of(context).textTheme.bodyMedium,
                        )),
                    const SizedBox(
                      height: 35,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen(),));
                              },
                              child: Text(
                                'Signup',
                                style: Theme.of(context).textTheme.bodySmall,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    ));
  }
}
