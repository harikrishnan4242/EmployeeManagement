import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../BlocManagement/signin_blog.dart';
import '../EventManagement/signin_event.dart';
import '../models/user_data.dart';

class FirebaseServices {
  final FirebaseAuth _firebaseauth = FirebaseAuth.instance;

  Stream<User?> get authStateChange => _firebaseauth.authStateChanges();

  FirebaseFirestore db = FirebaseFirestore.instance;

  User? getUser() {
    return _firebaseauth.currentUser;
  }

  Future<void> signIn(
      {required String email,
      required String password,
      required SignInBlog blog}) async {
    blog.add(SignInLoadEvent());
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user != null) {
        blog.add(SignInSuccessEvent());
      }
    } catch (e) {
      blog.add(SignInErrorEvent(error: e.toString()));
    }
  }

  Future<void> signUp(
      {required String email,
      required String password,
      required String number,
      required String name,
      required String path,
      required SignInBlog blog}) async {
    try {
      final credential = await _firebaseauth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (credential.user != null && path.isNotEmpty) {
        final storageRef = FirebaseStorage.instance.ref('Users/');
        final mountainsRef = storageRef.child('$name.jpg');
        await mountainsRef.putFile(File(path));
        var imageUrl = await mountainsRef.getDownloadURL();
        if (imageUrl.isNotEmpty) {
          UserData user = UserData(
              email: email, imageUrl: imageUrl, name: name, number: number);

          await db
              .collection('Users')
              .add(user.toMap())
              .then((documentSnapshot) {
            blog.add(SignInSuccessEvent());
          });
        }
      } else if (credential.user != null) {
        UserData user =
            UserData(email: email, imageUrl: '', name: name, number: number);
        FirebaseFirestore db = FirebaseFirestore.instance;
        await db.collection('Users').add(user.toMap()).then((documentSnapshot) {
          blog.add(SignInSuccessEvent());
        });
      }
    } on FirebaseAuthException catch (e) {
      blog.add(SignInErrorEvent(error: e.toString()));
    } catch (e) {
      blog.add(SignInErrorEvent(error: e.toString()));
    }
  }

  Future<UserData?> getUserByEmail(String email) async {
    try {
      QuerySnapshot querySnapshot = await db
          .collection('Users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return UserData.fromDocument(querySnapshot.docs.first);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
