import 'package:fenix_academia/common/custom_drawer/custom_drawer.dart';
import 'package:fenix_academia/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoneyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: scaffoldKey,
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // actions: [
        //   Consumer<UserManager>(
        //     builder: (_, userManager, __) {
        //       return IconButton(
        //         icon: Icon(
        //           userManager.isLoggedIn ? Icons.logout : Icons.login,
        //           color: Colors.white,
        //         ),
        //         onPressed: () {
        //           if (userManager.isLoggedIn) {
        //             Navigator.of(context).pushReplacementNamed('/base');
        //             userManager.signOut();
        //           } else {
        //             Navigator.of(context).pushReplacementNamed('/login');
        //           }
        //         },
        //       );
        //     },
        //   ),
        // ],
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
                  image: const AssetImage('android/assets/images/fenixMon.png'),
                  width: MediaQuery.of(context).size.width / 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 130, 16, 16),
                child: ListView(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Center(
                        child: Text(
                          'Tela em desenvolvimento',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
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
