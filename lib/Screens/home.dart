import 'package:firebase_demo/Services/firebase_service.dart';
import 'package:flutter/material.dart';

import '../models/user_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key,});

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  late UserData user;
  bool isDataLoading = true;
  @override
  void initState() {
    super.initState();
    fetchUser();
  }
  Future<void> fetchUser() async{
    user = await FirebaseServices().getUserByEmail(FirebaseServices().getUser()!.email.toString()).then((value) => UserData(email: value!.email, imageUrl: value.imageUrl, name: value.name, number: value.number));
    setState(() {
      isDataLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: isDataLoading? const Center(child: CircularProgressIndicator(color: Colors.white,strokeWidth: 2,),):Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [ 
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), border: Border.all(color: Colors.white, width: 2)),
                child: user.imageUrl.isNotEmpty?CircleAvatar(
                  backgroundImage: NetworkImage(user.imageUrl),
                  radius: 50,
                ):Container()
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center ,
                children: [ 
                  Text('User Name : ', style: Theme.of(context).textTheme.bodyLarge,)
                  ,Text(user.name, style: Theme.of(context).textTheme.bodyMedium,)
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ 
                  Text('Mobile Number : ', style: Theme.of(context).textTheme.bodyLarge,)
                  ,Text(user.number, style: Theme.of(context).textTheme.bodyMedium,)
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ 
                  Text('E-mail : ', style: Theme.of(context).textTheme.bodyLarge,)
                  ,Text(user.email, style: Theme.of(context).textTheme.bodyMedium,)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}