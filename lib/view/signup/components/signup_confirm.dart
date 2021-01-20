import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SignupConfirm extends StatelessWidget {
  const SignupConfirm(this.name);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: SizedBox(
              height: 240,
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        '$name \nfoi cadastrado com sucesso!',
                        textAlign: TextAlign.center,
                        style: const TextStyle(),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Divider(),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Deseja cadastrar \noutro aluno?',
                        textAlign: TextAlign.center,
                        style: TextStyle(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(
                            MdiIcons.accountRemoveOutline,
                            color: Colors.redAccent,
                            size: 40,
                          ),
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed('/');
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            MdiIcons.accountPlusOutline,
                            color: Colors.green,
                            size: 40,
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed('/signup');
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
