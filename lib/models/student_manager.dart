import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenix_academia/models/student.dart';
import 'package:fenix_academia/models/user.dart';
import 'package:fenix_academia/models/user_manager.dart';
import 'package:flutter/cupertino.dart';

class StudentManager extends ChangeNotifier {
  StudentManager() {
    _loadAllUsers();
  }

  final Firestore firestore = Firestore.instance;

  Student student;

  User user;

  bool _loadingStudent = false;
  bool get loading => _loadingStudent;

  List<Student> allStudents = [];
  List<Student> allAdmins = [];

  String _search = '';

  String get search => _search;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  void updateUser(UserManager userManager) {
    user = userManager.user;
    if (user != null) {
      _loadAllUsers();
    }
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

  set loading(bool value) {
    _loadingStudent = value;
    notifyListeners();
  }

  Future<void> _loadAllUsers() async {
    final QuerySnapshot snapUsers =
        await firestore.collection('users').getDocuments();

    allStudents =
        snapUsers.documents.map((d) => Student.fromDocument(d)).toList();

    notifyListeners();
  }

  Student findProductById(String id) {
    try {
      return allStudents.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  void update(Student student) {
    allStudents.removeWhere((p) => p.id == student.id);
    allStudents.add(student);
    notifyListeners();
  }
}
