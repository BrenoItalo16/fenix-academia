import 'package:fenix_academia/models/student.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:fenix_academia/models/user_manager.dart';

import 'components/images_form.dart';

class EditStudentScreen extends StatelessWidget {
  EditStudentScreen(Student s)
      : editing = s != null,
        student = s != null ? s.clone() : Student();
  final Student student;
  final bool editing;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final whatsappMask = MaskTextInputFormatter(mask: '(##) #####-####',
        // ignore: unnecessary_raw_strings
        filter: {"#": RegExp(r'[0-9]')});
    final dateMask = MaskTextInputFormatter(mask: '##/##/####',
        // ignore: unnecessary_raw_strings
        filter: {"#": RegExp(r'[0-9]')});
    final instagramMask = MaskTextInputFormatter(
      mask: '@###############################################################',
      filter: {"#": RegExp(r'[\D-\d]')},
    );
    final sizeMask = MaskTextInputFormatter(
      mask: '#.##',
      // ignore: unnecessary_raw_strings
      filter: {"#": RegExp(r'[0-9]')},
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 80, 30, 30),
        title: Text(editing ? 'Editando aluno' : 'Criar aluno'),
        centerTitle: true,
      ),
      body: Consumer<UserManager>(
        builder: (_, userManager, __) {
          return Form(
            key: formKey,
            child: ListView(
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 16, 32, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        student.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      //! whatsapp
                      TextFormField(
                        inputFormatters: [whatsappMask],
                        keyboardType: TextInputType.phone,
                        initialValue: student?.whatsapp ?? '',
                        decoration: const InputDecoration(
                          hintText: 'Inserir whatsapp',
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        onSaved: (whatsapp) => student.whatsapp = whatsapp,
                      ),
                      //! insta
                      TextFormField(
                        inputFormatters: [instagramMask],
                        initialValue: student?.instagram ?? '',
                        decoration: const InputDecoration(
                          hintText: 'Inserir instagram',
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        onSaved: (instagram) => student.instagram = instagram,
                      ),
                      //! peso
                      TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: student?.weight ?? '',
                        decoration: const InputDecoration(
                          hintText: 'Inserir peso',
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        onSaved: (weight) => student.weight = weight,
                      ),
                      //! altura
                      TextFormField(
                        inputFormatters: [sizeMask],
                        keyboardType: TextInputType.number,
                        initialValue: student?.size ?? '',
                        decoration: const InputDecoration(
                          hintText: 'Inserir altura',
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        onSaved: (size) => student.size = size,
                      ),
                      //! data de nascimento
                      TextFormField(
                        inputFormatters: [dateMask],
                        keyboardType: TextInputType.datetime,
                        initialValue: student?.born ?? '',
                        decoration: const InputDecoration(
                          hintText: 'Inserir data de nascimento',
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        onSaved: (born) => student.born = born,
                      ),

                      const SizedBox(height: 8),
                      RaisedButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            await student.save();
                            debugPrint('O botão de SALVAR tá funcionando');
                          }
                        },
                        child: const Text(
                          'Salvar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
