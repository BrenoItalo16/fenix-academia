import 'package:fenix_academia/models/user.dart';
import 'package:fenix_academia/models/user_manager.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:fenix_academia/helpers/validators.dart';

class LoginScree extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Stack(
                  children: [
                    Center(
                      child: Image(
                        image:
                            const AssetImage('android/assets/images/fenix.png'),
                        width: MediaQuery.of(context).size.width / 2,
                      ),
                      //todo inserir o codigo flare aqui
                      // child: const SizedBox(
                      //   height: 170,
                      //   child: FlareActor(
                      //     'android/assets/images/loading.flr',
                      //     animation: "Untitled",
                      //   ),
                      // ),
                    ),
                    const SizedBox(
                      height: 170,
                      child: Center(
                        child: Text(
                          'LOGIN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Image(
                image: const AssetImage('android/assets/images/fire.png'),
                width: MediaQuery.of(context).size.width,
              ),
            ],
          ),
          Center(
            child: Card(
              color: Colors.transparent, //todo: Altera a cor do card de form
              elevation: 0,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formKey,
                child: Consumer<UserManager>(
                  builder: (_, userManager, __) {
                    return userManager.loading
                        ? const SizedBox(
                            height: 170,
                            child: FlareActor(
                              //todo aki fica o arquivo flare
                              'android/assets/images/loading.flr',
                              animation: "Untitled",
                            ),
                          )
                        : ListView(
                            padding: const EdgeInsets.all(16),
                            shrinkWrap: true,
                            children: <Widget>[
                              TextFormField(
                                controller: emailController,
                                enabled: !userManager.loading,
                                decoration:
                                    const InputDecoration(hintText: 'E-mail'),
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                validator: (email) {
                                  if (!emailValid(email))
                                    return 'E-mail inválido';
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: passController,
                                decoration:
                                    const InputDecoration(hintText: 'Senha'),
                                autocorrect: false,
                                obscureText: true,
                                validator: (pass) {
                                  if (pass.isEmpty || pass.length < 6)
                                    // ignore: curly_braces_in_flow_control_structures
                                    return 'Senha Inválida';
                                  return null;
                                },
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: FlatButton(
                                  onPressed: () {},
                                  padding: EdgeInsets.zero,
                                  child: const Text('Esqueci a senha'),
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                height: 40,
                                child: RaisedButton(
                                  onPressed: userManager.loading
                                      ? null
                                      : () {
                                          if (formKey.currentState.validate()) {
                                            userManager.signIn(
                                              user: User(
                                                email: emailController.text,
                                                password: passController.text,
                                              ),
                                              onFail: (e) {
                                                scaffoldKey.currentState
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Falha ao entrar: $e'),
                                                  backgroundColor: Colors.red,
                                                ));
                                              },
                                              onSuccess: () {
                                                print('Sucesso');
                                                //todo: Fechar tela de login e Entrar no app
                                              },
                                            );
                                          }
                                        },
                                  color: Theme.of(context).primaryColor,
                                  disabledTextColor: Theme.of(context)
                                      .primaryColor
                                      .withAlpha(100),
                                  textColor: Colors.white,
                                  child: const Text(
                                    'Entrar',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              )
                            ],
                          );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
