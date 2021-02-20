import 'package:cloud_firestore/cloud_firestore.dart';

class Adm {
  Adm({this.id});
  Adm.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
  }
  String id;
}
