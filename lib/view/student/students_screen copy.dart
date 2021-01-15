import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:fenix_academia/common/custom_drawer/custom_drawer.dart';
import 'package:fenix_academia/models/student_manager.dart';
import 'package:fenix_academia/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Stack(
        alignment: Alignment.topCenter,
        overflow: Overflow.visible,
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 80, 30, 30),
              Color.fromARGB(255, 40, 15, 15),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          ),
          Positioned(
            top: (MediaQuery.of(context).size.height / 2) -
                MediaQuery.of(context).size.width / 3,
            child: Image(
              image: const AssetImage('android/assets/images/fenix.png'),
              width: MediaQuery.of(context).size.width / 1.5,
            ),
          ),
          Consumer<StudentsManager>(
            builder: (_, adminUsersManager, __) {
              return AlphabetListScrollView(
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(
                      adminUsersManager.users[index].name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800, color: Colors.white),
                    ),
                    subtitle: Text(
                      adminUsersManager.users[index].email,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                },
                highlightTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                normalTextStyle: const TextStyle(
                  color: Color.fromARGB(255, 150, 30, 30),
                ),
                indexedHeight: (index) => 80,
                strList: adminUsersManager.names,
                showPreview: true,
              );
            },
          ),
        ],
      ),
    );
  }
}
