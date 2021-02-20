import 'package:fenix_academia/common/profile_pic/profile_pic.dart';
import 'package:fenix_academia/models/page_manager.dart';
import 'package:fenix_academia/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class CustomDrawerHeader extends StatefulWidget {
  @override
  _CustomDrawerHeaderState createState() => _CustomDrawerHeaderState();
}

class _CustomDrawerHeaderState extends State<CustomDrawerHeader> {
  @override
  Widget build(BuildContext context) {
    final double sizeScreen = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
      height: sizeScreen / 1.8,
      child: Consumer<UserManager>(
        builder: (_, userManager, __) {
          return GestureDetector(
            onTap: () {
              if (userManager.user != null) {
                Navigator.of(context)
                    .pushNamed('/student', arguments: userManager.user);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                if (userManager.isLoggedIn)
                  ProfilePic(
                    sizeProfile: sizeScreen / 7.5,
                    image: userManager.user.images.last,
                  ),
                if (!userManager.isLoggedIn)
                  const Text(
                    'Academia \nFenix',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white54,
                    ),
                  ),
                if (userManager.isLoggedIn)
                  Center(
                    child: Text(
                      //! Fazendo testes
                      userManager.adms.length.toString(),
                      // '${userManager.user?.name ?? ''}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                const Center(
                  child: Divider(
                    color: Colors.white54,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (userManager.isLoggedIn) {
                      context.read<PageManager>().setPage(0);
                      userManager.signOut();
                    } else {
                      Navigator.of(context).pushNamed('/login');
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        userManager.isLoggedIn ? 'Sair' : 'Entrar',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (userManager.adminEnabled && userManager.isLoggedIn)
                        Column(
                          children: const [
                            Icon(
                              MdiIcons.crown,
                              color: Colors.amber,
                            ),
                            Text(
                              'Admin',
                              style: TextStyle(color: Colors.white54),
                            )
                          ],
                        )
                      else if (userManager.devEnabled && userManager.isLoggedIn)
                        Column(
                          children: const [
                            Icon(
                              MdiIcons.devTo,
                              color: Colors.amber,
                            ),
                            Text(
                              'Desenvolvedor',
                              style: TextStyle(color: Colors.white54),
                            )
                          ],
                        )
                      else if (userManager.treinerEnabled &&
                          userManager.isLoggedIn)
                        Column(
                          children: const [
                            Icon(
                              MdiIcons.armFlex,
                              color: Colors.amber,
                            ),
                            Text(
                              'Instrutor',
                              style: TextStyle(color: Colors.white54),
                            )
                          ],
                        )
                      else if (!userManager.adminEnabled &&
                          !userManager.treinerEnabled &&
                          userManager.isLoggedIn)
                        Column(
                          children: const [
                            Icon(
                              MdiIcons.emoticon,
                              color: Colors.amber,
                            ),
                            Text(
                              'Aluno',
                              style: TextStyle(color: Colors.white54),
                            )
                          ],
                        )
                      else
                        Column(
                          children: [
                            Icon(
                              MdiIcons.emoticon,
                              color: Colors.grey.withAlpha(70),
                            ),
                          ],
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
