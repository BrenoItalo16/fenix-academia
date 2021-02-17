import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User({this.id, this.name, this.email, this.password, this.images});
  User.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document.data['name'] as String;
    email = document.data['email'] as String;
    images = List<String>.from(document.data['images'] as List<dynamic>);
    //Novo campos que não têm em usuário
    whatsapp = document['whatsapp'] as String;
    instagram = document['instagram'] as String;
    weight = document['weight'] as String;
    size = document['size'] as String;
    born = document['born'] as String;
    payment = document['payment'] as String;
  }

  String id;
  String name;
  String email;
  String password;
  String confirmPassword;
  List<String> images;

  List<dynamic> newImages;
  //Novos campos que não têm em usuário
  String whatsapp;
  String instagram;
  String weight;
  String size;
  String born;
  String payment;
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

  String get yearsOld {
    if (born == null) {
      return 0.toStringAsFixed(2);
    } else {
      //Pega o ano da data de nascimento e passa para Inteiro
      final year = int.parse(born.split("/").last);

      //Pega a data atual
      final now = DateTime.now().toString().split(' ').first.split('-').first;
      final actual = int.parse(now); //pega o ano atual e passa para Inteiro

      final yearsOld = actual - year;

      return yearsOld.toString();
    }
  }

  String get imc {
    if ((weight == null) || (size == null)) {
      return 0.toStringAsFixed(2);
    } else {
      final weight = double.parse(this.weight);
      final size = double.parse(this.size);
      final imc = weight / (size * size);

      return imc.toStringAsFixed(2);
    }
  }

  String get imcInfo {
    final imc = double.parse(this.imc);
    if ((weight == null) || (size == null)) {
      return 'Peso e/ou altura não cadastrados';
    } else {
      if (imc < 18.6) {
        return 'Você está abaixo do peso';
      } else if (imc >= 18.6 && imc <= 24.9) {
        return 'Você está no peso ideal';
      } else if (imc >= 24.9 && imc <= 29.9) {
        return 'Você está levemente acima do peso';
      } else if (imc >= 29.9 && imc <= 34.9) {
        return 'Você está na obesidade grau 1';
      } else if (imc >= 34.9 && imc <= 39.9) {
        return 'Você está na obesidade grau 2';
      } else if (imc >= 40) {
        return 'Você está na obesidade grau 3';
      }
      return 'Verifique se o peso e a altura estão corretos';
    }
  }
}
