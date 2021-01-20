import 'package:fenix_academia/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class CustomDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 16, 8),
      height: 190,
      child: Consumer<UserManager>(
        builder: (_, userManager, __) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              if (userManager.isLoggedIn)
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 80, 30, 30),
                        ),
                        child: const Icon(
                          MdiIcons.account,
                          color: Color.fromARGB(255, 100, 30, 30),
                          size: 36,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 26, vertical: 10),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // color: Color.fromARGB(255, 80, 30, 130),
                          image: DecorationImage(
                            image: NetworkImage(userManager.user.images.first),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
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
              const SizedBox(height: 10),
              if (userManager.isLoggedIn)
                Text(
                  // ignore: unnecessary_string_interpolations
                  '${userManager.user?.name ?? ''}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              GestureDetector(
                onTap: () {
                  if (userManager.isLoggedIn) {
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
          );
        },
      ),
    );
  }
}
