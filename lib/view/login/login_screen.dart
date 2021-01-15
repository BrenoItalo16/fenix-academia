import 'package:fenix_academia/common/loading/loading_animation.dart';
import 'package:fenix_academia/models/user.dart';
import 'package:fenix_academia/models/user_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:fenix_academia/helpers/validators.dart';

class LoginScreen extends StatelessWidget {
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
          Positioned(
            top: 0,
            left: MediaQuery.of(context).size.width / 4,
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Stack(
                children: [
                  Center(
                    child: Image(
                      image: const AssetImage(
                          'android/assets/images/fenixLogin.png'),
                      width: MediaQuery.of(context).size.width / 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Image(
              image: const AssetImage('android/assets/images/fire.png'),
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Center(
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                return userManager.loading
                    ? LoadingAnimation()
                    : Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: Form(
                          key: formKey,
                          child: ListView(
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
                                  if (!emailValid(email)) {
                                    return 'E-mail inválido';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: passController,
                                enabled: !userManager.loading,
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
                              if (userManager.adminEnabled)
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: FlatButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed('/signup');
                                    },
                                    padding: EdgeInsets.zero,
                                    child: const Text('Cadastrar aluno'),
                                  ),
                                ),
                              const SizedBox(height: 16),
                              SizedBox(
                                height: 40,
                                child: RaisedButton(
                                  onPressed: () {
                                    if (formKey.currentState.validate()) {
                                      userManager.signIn(
                                        user: User(
                                          email: emailController.text,
                                          password: passController.text,
                                        ),
                                        onFail: (e) {
                                          scaffoldKey.currentState
                                              .showSnackBar(SnackBar(
                                            content:
                                                Text('Falha ao entrar: $e'),
                                            backgroundColor: Colors.red,
                                          ));
                                        },
                                        onSuccess: () {
                                          Navigator.of(context)
                                              .popAndPushNamed('/');
                                        },
                                      );
                                    }
                                  },
                                  color: Theme.of(context).primaryColor,
                                  textColor: Colors.white,
                                  child: const Text(
                                    'Entrar',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
              },
            ),
          )
        ],
      ),
    );
  }
}
