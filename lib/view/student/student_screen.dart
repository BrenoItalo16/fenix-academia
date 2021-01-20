import 'package:fenix_academia/models/student.dart';
import 'package:flutter/material.dart';

class StudentScreen extends StatelessWidget {
  const StudentScreen(this.student);

  final Student student;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Dados do aluno'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(230, 80, 30, 30),
                  Color.fromARGB(190, 0, 0, 0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          ListView(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 180,
                        child: Center(
                          child: Container(
                            height: 130,
                            width: 130,
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 180,
                        child: Center(
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(student.images.first),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 1000,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          // borderRadius: BorderRadius.all(Radius.circular(60.0)),
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(60)),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: Text(
                                student.name,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
