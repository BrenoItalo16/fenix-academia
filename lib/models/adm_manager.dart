import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenix_academia/models/adm.dart';
import 'package:flutter/cupertino.dart';

class AdmManager extends ChangeNotifier {
  AdmManager() {
    _loadAllAdms();
  }

  final Firestore firestore = Firestore.instance;

  List<Adm> allAdms = [];

  Future<void> _loadAllAdms() async {
    final QuerySnapshot snapAdms =
        await firestore.collection('admins').getDocuments();

    allAdms = snapAdms.documents.map((d) => Adm.fromDocument(d)).toList();
    notifyListeners();
  }
}
