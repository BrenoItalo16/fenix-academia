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
}
