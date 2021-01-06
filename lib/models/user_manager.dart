import 'package:fenix_academia/helpers/firebase_errors.dart';
import 'package:fenix_academia/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class UserManager extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;
  Future<void> signIn({User user, Function onFail, Function onSuccess}) async {
    setLoading(true);
    try {
      // ignore: unused_local_variable
      final AuthResult result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      await Future.delayed(const Duration(seconds: 5)); //todo: APAGAR
      onSuccess();
    } on PlatformException catch (e) {
      onFail(getErrorString(e.code));
    }
    setLoading(false);
  }

  // ignore: avoid_positional_boolean_parameters
  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }
}
