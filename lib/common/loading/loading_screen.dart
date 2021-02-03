import 'package:fenix_academia/common/loading/loading_animation.dart';
import 'package:fenix_academia/models/student.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Student(),
      child: Scaffold(
        body: Consumer<Student>(
          builder: (_, student, __) {
            return Stack(
              children: [
                Container(
                  color: const Color.fromARGB(255, 80, 30, 30),
                ),
                Center(child: LoadingAnimation()),
              ],
            );
          },
        ),
      ),
    );
  }
}
