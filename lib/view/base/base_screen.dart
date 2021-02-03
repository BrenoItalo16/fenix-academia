import 'package:fenix_academia/models/page_manager.dart';
import 'package:fenix_academia/models/user_manager.dart';
import 'package:fenix_academia/view/exercises/exercises_screen.dart';
import 'package:fenix_academia/view/home/home_screen.dart';
import 'package:fenix_academia/view/money_screen/money_screen.dart';
import 'package:fenix_academia/view/student_list/students_list_screen.dart';
import 'package:fenix_academia/view/suport/suport_screen.dart';
import 'package:fenix_academia/view/treinning/treinning_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatelessWidget {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(pageController),
      child: Consumer<UserManager>(
        builder: (_, userManager, __) {
          return PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              HomeScreen(),
              MoneyScreen(),
              SuportScreen(),
              if (userManager.adminEnabled ||
                  userManager.devEnabled ||
                  userManager.treinerEnabled) ...[
                ExercisesScreen(),
                StudentsListScreen(),
                TreinningScreen(),
              ],
            ],
          );
        },
      ),
    );
  }
}
