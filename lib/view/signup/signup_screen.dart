import 'package:fenix_academia/common/custom_drawer/custom_drawer.dart';
import 'package:fenix_academia/common/loading/loading_animation.dart';
import 'package:fenix_academia/models/user.dart';
import 'package:fenix_academia/models/user_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fenix_academia/helpers/validators.dart';

class SignupScreen extends StatelessWidget {
  final User user = User();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Consumer<UserManager>(
            builder: (_, userManager, __) {
              return IconButton(
                icon: Icon(
                  userManager.isLoggedIn ? Icons.logout : Icons.login,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (userManager.isLoggedIn) {
                    Navigator.of(context).pushNamed('/base');
                    userManager.signOut();
                  } else {
                    Navigator.of(context).pushNamed('/login');
                  }
                },
              );
            },
          ),
        ],
      ),
      body: Consumer<UserManager>(builder: (_, userManager, __) {
        return Stack(
          alignment: Alignment.topCenter,
          overflow: Overflow.visible,
          children: [
            Positioned(
              top: -40,
              child: Image(
                image:
                    const AssetImage('android/assets/images/fenixCadastro.png'),
                width: MediaQuery.of(context).size.width / 2,
              ),
            ),
            Stack(
              overflow: Overflow.visible,
              children: [
                Positioned(
                  bottom: 0,
                  child: Image(
                    image: const AssetImage('android/assets/images/fire.png'),
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                if (userManager.loading)
                  LoadingAnimation()
                else
                  Center(
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Form(
                        key: formKey,
                        child: ListView(
                          padding: const EdgeInsets.all(16),
                          shrinkWrap: true,
                          children: <Widget>[
                            TextFormField(
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                  hintText: 'Nome completo'),
                              validator: (name) {
                                if (name.isEmpty) {
                                  return 'Campo obrigatório';
                                } else if (name.trim().split(' ').length <= 1) {
                                  return 'Preencha seu nome completo';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (name) => user.name = name,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              enabled: !userManager.loading,
                              decoration:
                                  const InputDecoration(hintText: 'E-mail'),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              validator: (email) {
                                if (email.isEmpty) {
                                  return 'Campo obrigatório';
                                } else if (!emailValid(email)) {
                                  return 'E-mail inválido';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (email) => user.email = email,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              decoration:
                                  const InputDecoration(hintText: 'Senha'),
                              autocorrect: false,
                              obscureText: true,
                              validator: (pass) {
                                if (pass.isEmpty) {
                                  return 'Campo obrigatório';
                                } else if (pass.length < 6) {
                                  return 'Senha muito curta';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (pass) => user.password = pass,
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              decoration: const InputDecoration(
                                  hintText: 'Repetir senha'),
                              autocorrect: false,
                              obscureText: true,
                              validator: (pass) {
                                if (pass.isEmpty) {
                                  return 'Campo obrigatório';
                                } else if (pass.length < 6) {
                                  return 'Senha muito curta';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (pass) => user.confirmPassword = pass,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/login');
                                },
                                padding: EdgeInsets.zero,
                                child: const Text('Já tenho cadastro'),
                              ),
                            ),
                            const SizedBox(height: 32),
                            SizedBox(
                              height: 40,
                              child: RaisedButton(
                                onPressed: () {
                                  if (formKey.currentState.validate()) {
                                    formKey.currentState.save();
                                    if (user.password != user.confirmPassword) {
                                      scaffoldKey.currentState.showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Senhas não coincidem!'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                      return;
                                    }
                                    context.read<UserManager>().signUp(
                                        user: user,
                                        onSuccess: () {
                                          debugPrint('Successo ao cadastrar!');
                                          Navigator.of(context).pop();
                                        },
                                        onFail: (e) {
                                          scaffoldKey.currentState.showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Falha ao cadastrar: $e'),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        });
                                  }
                                },
                                color: Theme.of(context).primaryColor,
                                textColor: Colors.white,
                                child: const Text(
                                  'Cadastrar',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ],
        );
      }),
    );
  }
}
