import 'package:cloud_firestore/cloud_firestore.dart';

class UserData{
  final String name;
  final String email;
  final String number;
  final String imageUrl;
  UserData({required this.email, required this.imageUrl, required this.name, required this.number});

    Map<String, dynamic> toMap() {
    return {
      'name': name,
      'number': number,
      'email':email,
      'imageUrl':imageUrl,
    };
  }
    factory UserData.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserData(
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      number: data['number']??''
    );
}
}