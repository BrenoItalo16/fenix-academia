import 'package:fenix_academia/common/custom_drawer/custom_drawer.dart';
import 'package:fenix_academia/models/student_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/search_dialog.dart';
import 'components/student_list_tile.dart';

class StudentsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Consumer<StudentManager>(
          builder: (_, studentManager, __) {
            if (studentManager.search.isEmpty) {
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
                        builder: (_) => SearchDialog(studentManager.search),
                      );
                      if (search != null) {
                        studentManager.search = search;
                      }
                    },
                    child: SizedBox(
                      width: constraints.biggest.width,
                      child: Text(
                        studentManager.search,
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
        actions: [
          Consumer<StudentManager>(
            builder: (_, studentManager, __) {
              if (studentManager.search.isEmpty) {
                return IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    final search = await showDialog<String>(
                      context: context,
                      builder: (_) => SearchDialog(studentManager.search),
                    );
                    if (search != null) {
                      studentManager.search = search;
                    }
                  },
                );
              } else {
                return IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    studentManager.search = '';
                  },
                );
              }
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
          Consumer<StudentManager>(
            builder: (_, adminUsersManager, __) {
              return Consumer<StudentManager>(
                builder: (_, studentManager, __) {
                  // ignore: unused_local_variable
                  final filteredStudents = studentManager.filteredStudents;
                  return ListView.builder(
                    itemCount: studentManager.filteredStudents.length,
                    itemBuilder: (_, index) {
                      return StudentListTile(
                        studentManager.filteredStudents[index],
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
