import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../BlocManagement/file_handler.dart';
import '../BlocManagement/signin_blog.dart';
import '../Dialogs/image_pick_dialog.dart';
import '../EventManagement/file_event.dart';
import '../EventManagement/signin_event.dart';
import '../ImageProvider/image_provider.dart';
import '../Services/firebase_service.dart';
import '../StateManagement/file_state.dart';
import '../StateManagement/signin_state.dart';
import 'home.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupState();
}

class _SignupState extends State<SignupScreen> {
  bool showCpass = false;
  bool showPass = true;
  final formKey = GlobalKey<FormState>();
  String imageLoc = '';
  final _blog = FileHandlerBloc();

  final _blog1 = SignInBlog();

  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

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
        bloc: _blog1,
        listener: (context, state) {
        if(state is SignInLoadState){
          showDialog(context: context, builder: (context) => const Center(child: CircularProgressIndicator(color: Colors.white,),),);
        }else if(state is SignInFailed){
          
          showDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.black,
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
          _blog1.add(SignInInitialEvent());
          
        }else if(state is SignInSuccessState){
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
        }
        else if(state is SignInInitialState){
            emailController.clear();
          passwordController.clear();
          phoneNumberController.clear();
          userNameController.clear();
          imageLoc = '';
        }
      },child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 0.8,
            width: MediaQuery.of(context).size.width / 1.1,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        'Create your account',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 4.5,
                    height: MediaQuery.of(context).size.height / 9,
                    child: Stack(
                      children: [
                        Positioned(
                            child: Container(
                          width: MediaQuery.of(context).size.width / 4.5,
                          height: MediaQuery.of(context).size.height / 9,
                          decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 1),borderRadius: BorderRadius.circular(50)),
                          child: BlocBuilder(
                            bloc: _blog,
                            builder: (context, state) {
                            if(state is ImageFileState){
                              imageLoc = state.filePath.path;
                              return Container(
                                height: double.maxFinite,
                                width: double.maxFinite,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),image: imageLoc.isNotEmpty?DecorationImage(image: FileImage(File(imageLoc)),fit: BoxFit.fill):null),
                              );
                            }else{
                              return Container();
                            }
                          },),
                          
                        )),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                            child: IconButton(onPressed: ()async{
                           var result = await   showDialog(context: context, builder: (context) => const PickImageDialog(),);
                           ImagePickerProperty chooseImage = ImagePickerProperty();
                           if(result=='Camera'){
                           XFile  imageLocs = (await chooseImage.getCameraImage())!;
                           if(imageLocs.path.isNotEmpty) {
                             _blog.add(ImageFileEvent(filePath: imageLocs));
                           }
                           }else if(result=='Gallery'){
                              XFile  imageLocs =  (await  chooseImage.getGalleryImage())!;
                              if(imageLocs.path.isNotEmpty) {
                                _blog.add(ImageFileEvent(filePath: imageLocs));
                              }
                           }
                            }, icon: const Icon(Icons.image_search_rounded,color: Colors.black,size: 15,))))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    maxLines: 1,
                    controller: userNameController,
                    keyboardType: TextInputType.text,
                    validator: (value) => value!.length < 3
                        ? 'User Name should be at least 3 characters'
                        : null,
                    decoration: InputDecoration(
                        hintText: 'UserName',
                        hintStyle: Theme.of(context).textTheme.bodySmall,
                        focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2))),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    maxLines: 1,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => emailRex(value),
                    decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: Theme.of(context).textTheme.bodySmall,
                        focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2))),
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
                  TextFormField(
                    maxLines: 1,
                    maxLength: 10,
                    controller: phoneNumberController,
                    validator: (value) {
                      if(value!.length<10){
                        return'Please enter 10 digit mobile number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Mobile Number',
                        hintStyle: Theme.of(context).textTheme.bodySmall),
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
                              if(formKey.currentState!.validate()){
                                FirebaseServices().signUp(email: emailController.text, password: passwordController.text, number: phoneNumberController.text, name: userNameController.text, blog: _blog1, path: imageLoc);
                              }
                            },
                            child: Text(
                              'SIGN UP',
                              style: Theme.of(context).textTheme.bodyMedium,
                            )),
                        const SizedBox(
                          height: 35,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Do you already have an account?",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen(),
                                        ));
                                  },
                                  child: Text(
                                    'Signin',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
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
          ),
        ),
      )),),
    );
  }
}
