import 'package:fenix_academia/common/custom_drawer/custom_drawer.dart';
import 'package:fenix_academia/main.dart';
import 'package:fenix_academia/models/page_manager.dart';
import 'package:fenix_academia/view/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          LoginScree(),
          Scaffold(
            key: scaffoldKey,
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Crescimento'),
            ),
          ),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Cadastro'),
            ),
          ),
          Scaffold(
            drawer: CustomDrawer(),
            appBar: AppBar(
              title: const Text('Mensalidade'),
            ),
          ),
        ],
      ),
    );
  }
}
