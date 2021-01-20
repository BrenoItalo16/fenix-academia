import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  Student.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    email = document['email'] as String;
    name = document['name'] as String;
    images = List<String>.from(document.data['images'] as List<dynamic>);
  }

  String id;
  String email;
  String name;
  List<String> images;
}
