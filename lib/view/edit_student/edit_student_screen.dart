import 'package:fenix_academia/models/student.dart';
import 'package:fenix_academia/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/images_form.dart';

class EditStudentScreen extends StatelessWidget {
  const EditStudentScreen(this.student);
  final Student student;
  @override
  Widget build(BuildContext context) {
    final double heightScreen = MediaQuery.of(context).size.height;
    return Consumer<UserManager>(builder: (_, userManager, __) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 80, 30, 30),
          title: const Text('Editando aluno'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 200,
                      color: const Color.fromARGB(255, 80, 30, 30),
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 60,
                          color: const Color.fromARGB(255, 80, 30, 30),
                        ),
                        Container(
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(32),
                              topRight: Radius.circular(32),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ImagesForm(student),
              ],
            ),
          ],
        ),
      );
    });
  }
}
