import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenix_academia/models/student.dart';
import 'package:flutter/cupertino.dart';

class StudentManager extends ChangeNotifier {
  StudentManager() {
    _loadAllUsers();
  }

  final Firestore firestore = Firestore.instance;
  List<Student> allStudents = [];

  String _search = '';

  String get search => _search;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<Student> get filteredStudents {
    final List<Student> filteredStudents = [];

    if (search.isEmpty) {
      filteredStudents.addAll(allStudents);
    } else {
      filteredStudents.addAll(
        allStudents.where(
          (s) => s.name.toLowerCase().contains(search.toLowerCase()),
        ),
      );
    }
    return filteredStudents;
  }

  Future<void> _loadAllUsers() async {
    final QuerySnapshot snapUsers =
        await firestore.collection('users').getDocuments();

    allStudents =
        snapUsers.documents.map((d) => Student.fromDocument(d)).toList();

    notifyListeners();
  }
}
