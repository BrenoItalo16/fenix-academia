import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  Student({this.id, this.name, this.email, this.whatsapp, this.images});
  Student.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document['name'] as String;
    email = document['email'] as String;
    whatsapp = document['whatsapp'] as String;
    images = List<String>.from(document.data['images'] as List<dynamic>);
  }

  String id;
  String name;
  String email;
  String whatsapp;
  List<String> images;
}
