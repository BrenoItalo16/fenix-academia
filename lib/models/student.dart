import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class Student extends ChangeNotifier {
  Student(
      {this.id,
      this.name,
      this.email,
      this.images,
      this.whatsapp,
      this.instagram,
      this.weight,
      this.size,
      this.born,
      this.payment}) {
    images = images ?? [];
  }

  final Firestore firestore = Firestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  DocumentReference get firestoreRef => firestore.document('users/$id');
  StorageReference get storageRef => storage.ref().child('students').child(id);

  Student.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document['name'] as String;
    email = document['email'] as String;
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
  List<String> images;

  List<dynamic> newImages;
  //Novos campos que não têm em usuário
  String whatsapp;
  String instagram;
  String weight;
  String size;
  String born;
  String payment;

  bool _loading = false;
  bool dev = false;
  bool admin = false;
  bool treiner = false;
  bool isAdmin = false;

  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> save() async {
    loading = true;

    final Map<String, dynamic> data = {
      'whatsapp': whatsapp,
      'instagram': instagram,
      'weight': weight,
      'size': size,
      'born': born,
      'payment': payment,
    };

    if (id == null) {
      //   //! Aluno será criado
      final doc = await firestore.collection('users').add(data);
      id = doc.documentID;
    } else {
      //! Aluno será editado
      await firestoreRef.updateData(data);
    }

    final List<String> updateImages = [];
    for (final newImage in newImages) {
      if (images.contains(newImage)) {
        updateImages.add(newImage as String);
      } else {
        final StorageUploadTask task =
            storageRef.child(Uuid().v1()).putFile(newImage as File);
        final StorageTaskSnapshot snapshot = await task.onComplete;
        final String url = await snapshot.ref.getDownloadURL() as String;
        updateImages.add(url);
      }
    }

    for (final image in images) {
      if (!newImages.contains(image)) {
        try {
          final ref = await storage.getReferenceFromUrl(image);
          await ref.delete();
        } catch (e) {
          debugPrint('Falha ao deletar $image');
        }
      }
    }

    await firestoreRef.updateData({'images': updateImages});
    images = updateImages;
    loading = false;
    notifyListeners(); //! teste de atualização de imagem
  }

  Student clone() {
    return Student(
      id: id,
      name: name,
      email: email,
      whatsapp: whatsapp,
      instagram: instagram,
      weight: weight,
      size: size,
      born: born,
      payment: payment,
      images: List.from(images),
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Student{id: $id, name: $name, email: $email, whatsapp: $whatsapp, instagram: $instagram, weight: $weight, size: $size, born: $born, payment: $payment, images: $images, newImages, $newImages}';
  }

  Future<void> saveAdm() async {
    loading = true;
    final Map<String, dynamic> data = {
      'admUser': id,
    };
    await firestore.collection('admins').document(id).setData(data);
    loading = false;
    notifyListeners();
  }

  Future<void> saveTreiner() async {
    loading = true;
    final Map<String, dynamic> data = {
      'treinerUser': id,
    };
    await firestore.collection('treiners').document(id).setData(data);
    loading = false;
    notifyListeners();
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
