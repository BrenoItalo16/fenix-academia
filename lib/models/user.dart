import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User({this.id, this.name, this.email, this.password, this.images});
  User.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document.data['name'] as String;
    email = document.data['email'] as String;
    images = List<String>.from(document.data['images'] as List<dynamic>);
  }

  String id;
  String name;
  String email;
  String password;
  String confirmPassword;
  List<String> images;
  bool admin = false;
  bool treiner = false;
  bool dev = false;

  DocumentReference get firestorRef => Firestore.instance.document('users/$id');

  Future<void> saveData() async {
    await firestorRef.setData(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'images': ['https://i.imgur.com/8dpBpns.jpg'],
    };
  }
}
