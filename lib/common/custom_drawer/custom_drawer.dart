import 'package:fenix_academia/common/custom_drawer/custom_drawer_header.dart';
import 'package:fenix_academia/common/custom_drawer/drawer_tile.dart';
import 'package:fenix_academia/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Image(
            image: const AssetImage('android/assets/images/model2.jpg'),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(190, 0, 0, 0),
                  Color.fromARGB(230, 80, 30, 30),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          ListView(
            children: <Widget>[
              CustomDrawerHeader(),
              const Divider(
                color: Colors.white54,
              ),
              const DrawerTile(
                iconData: MdiIcons.homeOutline,
                title: 'Início',
                page: 0,
              ),
              const DrawerTile(
                iconData: MdiIcons.accountCashOutline,
                title: 'Mensalidade',
                page: 1,
              ),
              const DrawerTile(
                iconData: Icons.contact_support_outlined,
                title: 'Suport',
                page: 2,
              ),
              Consumer<UserManager>(
                builder: (_, userManager, __) {
                  if (userManager.adminEnabled ||
                      userManager.devEnabled ||
                      userManager.treinerEnabled) {
                    return Column(
                      children: const [
                        Center(
                          child: Divider(
                            color: Colors.white54,
                          ),
                        ),
                        DrawerTile(
                          iconData: MdiIcons.cardAccountDetailsOutline,
                          title: 'Exercícios',
                          page: 3,
                        ),
                        DrawerTile(
                          iconData: MdiIcons.accountGroupOutline,
                          title: 'Alunos',
                          page: 4,
                        ),
                        DrawerTile(
                          iconData: MdiIcons.crown,
                          title: 'Administradores',
                          page: 5,
                        ),
                        DrawerTile(
                          iconData: MdiIcons.armFlexOutline,
                          title: 'Passar treino',
                          page: 6,
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
