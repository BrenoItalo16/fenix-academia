import 'package:fenix_academia/common/custom_drawer/drawer_tile.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
                  Color.fromARGB(230, 100, 52, 65),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          ListView(
            children: const [
              DrawerTile(
                //iconData: Icons.home_outlined,
                iconData: MdiIcons.weightLifter,
                title: 'Treino',
                page: 0,
              ),
              DrawerTile(
                //iconData: Icons.home_outlined,
                iconData: MdiIcons.armFlexOutline,
                title: 'Crescimento',
                page: 1,
              ),
              DrawerTile(
                //iconData: Icons.home_outlined,
                iconData: MdiIcons.cardAccountDetailsOutline,
                title: 'Cadastro',
                page: 2,
              ),
              DrawerTile(
                //iconData: Icons.home_outlined,
                iconData: MdiIcons.accountCashOutline,
                title: 'Mensalidade',
                page: 3,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
