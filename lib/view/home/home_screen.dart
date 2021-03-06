import 'package:fenix_academia/common/custom_drawer/custom_drawer.dart';
import 'package:fenix_academia/models/user_manager.dart';
import 'package:fenix_academia/view/home/components/options_home.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'components/options_home2.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldKey,
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          Consumer<UserManager>(
            builder: (_, userManager, __) {
              if (userManager.devEnabled || userManager.adminEnabled) {
                return IconButton(
                  icon: const Icon(
                    MdiIcons.accountPlus,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/signup');
                  },
                );
              }
              return Container();
            },
          ),
        ],
      ),
      body: Consumer<UserManager>(
        builder: (_, userManager, __) {
          return Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 80, 30, 30),
                  Color.fromARGB(255, 40, 15, 15),
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              ),
              Positioned(
                top: -40, //todo: alterar a altura aqui
                //left: MediaQuery.of(context).size.width / 4,
                child: Image(
                  image: const AssetImage('android/assets/images/fenix.png'),
                  width: MediaQuery.of(context).size.width / 2,
                ),
              ),
              if (userManager.adminEnabled)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
                  child: ListView(
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: const [
                            OptionsHome2(
                              iconData: MdiIcons.accountPlusOutline,
                              title: 'Novo Aluno',
                              customRoute: '/signup',
                            ),
                            OptionsHome(
                              iconData: MdiIcons.weightLifter,
                              title: 'Exercícios',
                              customRoute: '/exercises',
                              pagina: 1,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            OptionsHome(
                              iconData: MdiIcons.cardAccountDetailsOutline,
                              title: 'Alunos',
                              customRoute: '/students',
                              pagina: 4,
                            ),
                            OptionsHome(
                              iconData: MdiIcons.accountCashOutline,
                              title: 'Mensalidade',
                              customRoute: '/money',
                              pagina: 2,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            OptionsHome(
                              iconData: MdiIcons.armFlexOutline,
                              title: 'Passar Treino',
                              customRoute: '/treinning',
                              pagina: 5,
                            ),
                            OptionsHome(
                              iconData: Icons.contact_support_outlined,
                              title: 'Suporte',
                              customRoute: '/suport',
                              pagina: 3,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              else
                const Center(
                  child: Text(
                    'Tela em desenvolvimento',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
