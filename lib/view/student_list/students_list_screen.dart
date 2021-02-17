import 'package:fenix_academia/common/custom_drawer/custom_drawer.dart';
import 'package:fenix_academia/models/admin_users_manager.dart';
import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:fenix_academia/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/search_dialog.dart';

class StudentsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        // centerTitle: true,
        title: Consumer<UserManager>(
          builder: (_, userManager, __) {
            if (userManager.search.isEmpty) {
              return const Text(
                'Alunos',
              );
            } else {
              return LayoutBuilder(
                builder: (_, constraints) {
                  return GestureDetector(
                    onTap: () async {
                      final search = await showDialog<String>(
                        context: context,
                        builder: (_) => SearchDialog(userManager.search),
                      );
                      if (search != null) {
                        userManager.search = search;
                      }
                    },
                    child: SizedBox(
                      width: constraints.biggest.width,
                      child: Text(
                        userManager.search,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
        backgroundColor: Colors.transparent,
        //! Remover o comentário para o ícone da appBar
        // actions: [
        //   Consumer<UserManager>(
        //     builder: (_, userManager, __) {
        //       if (userManager.search.isEmpty) {
        //         return IconButton(
        //           icon: const Icon(
        //             Icons.search,
        //             color: Colors.white,
        //           ),
        //           onPressed: () async {
        //             final search = await showDialog<String>(
        //               context: context,
        //               builder: (_) => SearchDialog(userManager.search),
        //             );
        //             if (search != null) {
        //               userManager.search = search;
        //             }
        //           },
        //         );
        //       } else {
        //         return IconButton(
        //           icon: const Icon(
        //             Icons.close,
        //             color: Colors.white,
        //           ),
        //           onPressed: () async {
        //             userManager.search = '';
        //           },
        //         );
        //       }
        //     },
        //   ),
        // ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: heightScreen / (1.16)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(20),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
              ),
            ),
          ),
          Consumer<AdminUsersManager>(
            builder: (_, adm, __) {
              return AlphabetListScrollView(
                itemBuilder: (_, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: heightScreen / (30),
                      right: heightScreen / (6.8),
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      color: const Color.fromARGB(255, 100, 30, 30),
                      child: ListTile(
                        leading: Container(
                          height: heightScreen / 9,
                          width: heightScreen / 9,
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(adm.users[index].images.last),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(
                          adm.users[index].name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          adm.users[index].email,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/student',
                            arguments: adm.users[index],
                          );
                        },
                      ),
                    ),
                  );
                },
                highlightTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: heightScreen / 22,
                ),
                normalTextStyle: TextStyle(
                  color: const Color.fromARGB(255, 200, 30, 30),
                  fontSize: heightScreen / 30,
                ),
                indexedHeight: (index) => heightScreen / 5.4,
                strList: adm.names,
                showPreview: true,
              );
            },
          ),
        ],
      ),
    );
  }
}
