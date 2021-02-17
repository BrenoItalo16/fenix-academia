import 'package:fenix_academia/models/user.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:fenix_academia/models/user_manager.dart';
import 'components/images_form.dart';

// ignore: must_be_immutable
class EditStudentScreen extends StatelessWidget {
  EditStudentScreen(this.user);
  User user;
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
        title: const Text('Editando aluno'),
        centerTitle: true,
      ),
      body: Consumer<UserManager>(
        builder: (_, user, __) {
          final usr = user.user;
          return Form(
            key: formKey,
            child: ListView(
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 30,
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  usr.name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ImagesForm(usr),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 16, 32, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        usr.name,
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
                        initialValue: usr?.whatsapp ?? '',
                        decoration: const InputDecoration(
                          hintText: 'Inserir whatsapp',
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        onSaved: (whatsapp) => usr.whatsapp = whatsapp,
                      ),
                      //! insta
                      TextFormField(
                        inputFormatters: [instagramMask],
                        initialValue: usr?.instagram ?? '',
                        decoration: const InputDecoration(
                          hintText: 'Inserir instagram',
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        onSaved: (instagram) => usr.instagram = instagram,
                      ),
                      //! peso
                      TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: usr?.weight ?? '',
                        decoration: const InputDecoration(
                          hintText: 'Inserir peso',
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        onSaved: (weight) => usr.weight = weight,
                      ),
                      //! altura
                      TextFormField(
                        inputFormatters: [sizeMask],
                        keyboardType: TextInputType.number,
                        initialValue: usr?.size ?? '',
                        decoration: const InputDecoration(
                          hintText: 'Inserir altura',
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        onSaved: (size) => usr.size = size,
                      ),
                      //! data de nascimento
                      TextFormField(
                        inputFormatters: [dateMask],
                        keyboardType: TextInputType.datetime,
                        initialValue: usr?.born ?? '',
                        decoration: const InputDecoration(
                          hintText: 'Inserir data de nascimento',
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        onSaved: (born) => usr.born = born,
                      ),

                      const SizedBox(height: 8),
                      RaisedButton(
                        color: Theme.of(context).primaryColor,
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            // await usr.save(); //!Criar metodo save();
                            debugPrint('Criar o botão método save');
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
