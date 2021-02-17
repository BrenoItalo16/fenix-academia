import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fenix_academia/helpers/firebase_errors.dart';
import 'package:fenix_academia/models/user.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;

  User user;

  bool _loading = false;
  bool get loading => _loading;

  List<User> allUsers = [];
  List<User> allAdmins = [];

  String _search = '';

  String get search => _search;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  bool get isLoggedIn => user != null;

  Future<void> signIn({User user, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      await Future.delayed(const Duration(seconds: 0)); //! Atrazar o loading

      await _loadCurrentUser(firebaseUser: result.user);

      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  List<User> get filteredUsers {
    final List<User> filteredUsers = [];

    if (search.isEmpty) {
      filteredUsers.addAll(allUsers);
    } else {
      filteredUsers.addAll(
        allUsers.where(
          (s) => s.name.toLowerCase().contains(search.toLowerCase()),
        ),
      );
    }
    return filteredUsers;
  }

  Future<void> _loadAllUsers() async {
    final QuerySnapshot snapUsers =
        await firestore.collection('users').getDocuments();

    allUsers = snapUsers.documents.map((d) => User.fromDocument(d)).toList();

    notifyListeners();
  }

  User findProductById(User id) {
    try {
      return allUsers.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  void update(User user) {
    allUsers.removeWhere((p) => p.id == user.id);
    allUsers.add(user);
    notifyListeners();
  }

  Future<void> signUp({User user, Function onFail, Function onSuccess}) async {
    loading = true;

    try {
      // ignore: unused_local_variable
      final AuthResult result = await auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      user.id = result.user.uid; //! O usuário cadastrado fica logado
      // this.user = user; //! O usuário cadastrado fica logado

      await user.saveData();

      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  void signOut() {
    auth.signOut();
    user = null;
    notifyListeners();
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser({FirebaseUser firebaseUser}) async {
    final FirebaseUser currentUser = firebaseUser ?? await auth.currentUser();
    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await firestore.collection('users').document(currentUser.uid).get();
      user = User.fromDocument(docUser);

      //! Administrador
      final docAdmin =
          await firestore.collection('admins').document(user.id).get();
      if (docAdmin.exists) {
        user.admin = true;
      }

      //! Treinador
      final docTreiner =
          await firestore.collection('treiners').document(user.id).get();
      if (docTreiner.exists) {
        user.treiner = true;
      }

      //! Desenvolvedor
      final docDev = await firestore.collection('devs').document(user.id).get();
      if (docDev.exists) {
        user.dev = true;
      }

      notifyListeners();
    }
  }

  bool get adminEnabled => user != null && user.admin;

  bool get treinerEnabled => user != null && user.treiner;

  bool get devEnabled => user != null && user.dev;

  //! here---------
}
