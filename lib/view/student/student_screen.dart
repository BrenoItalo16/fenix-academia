import 'package:fenix_academia/common/profile_pic/profile_pic.dart';
import 'package:fenix_academia/models/student.dart';
import 'package:fenix_academia/models/user_manager.dart';
import 'package:fenix_academia/view/student/components/student_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen(this.student);

  final Student student;

  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  @override
  Widget build(BuildContext context) {
    final double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Dados do aluno'),
        centerTitle: true,
        actions: [
          Consumer<UserManager>(
            builder: (_, userManager, __) {
              if (userManager.user.id == widget.student.id) {
                return IconButton(
                  icon: const Icon(
                    MdiIcons.accountEdit,
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('/editstudent', arguments: widget.student);
                  },
                );
              } else {
                return IconButton(
                  icon: const Icon(
                    Icons.emoji_emotions,
                    color: Colors.transparent,
                  ),
                  onPressed: () {},
                );
              }
            },
          ),
        ],
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
                  ProfilePic(
                    sizeProfile: heightScreen / 7,
                    image: widget.student.images.first,
                  ),
                  Stack(
                    children: [
                      Container(
                        height: heightScreen,
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
                                widget.student.name,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: StudentTile(
                              MdiIcons.cardAccountMail,
                              widget.student.email,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: StudentTile(
                              MdiIcons.whatsapp,
                              // ignore: unnecessary_string_interpolations
                              '${widget.student?.whatsapp ?? '(**)*****-****'}',
                            ), //! Já pode inserir no banco de dados
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: StudentTile(
                              MdiIcons.instagram,
                              // ignore: unnecessary_string_interpolations
                              '${widget.student?.whatsapp ?? '@brenoitalo16'}',
                            ), //! Já pode inserir no banco de dados
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Divider(thickness: 2),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 24, 0, 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(32, 0, 16, 0),
                                      child: Icon(
                                        MdiIcons.weightKilogram,
                                        color: Color.fromARGB(230, 80, 30, 30),
                                      ),
                                    ),
                                    Text(
                                      '78.00 Kg',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Icon(
                                        MdiIcons.humanMaleHeight,
                                        color: Color.fromARGB(230, 80, 30, 30),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 32, 0),
                                      child: Text(
                                        '1.74 de altura',
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(right: 16, left: 32),
                                  child: Icon(
                                    MdiIcons.timelapse,
                                    color: Color.fromARGB(230, 80, 30, 30),
                                  ),
                                ),
                                Text(
                                  '30 anos de idade', //Todo: Colocar Altura
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 16, left: 32),
                                  child: Icon(
                                    MdiIcons.alertDecagram,
                                    color: Colors.amber,
                                  ),
                                ),
                                const Text(
                                  'Você está levemente a cima do peso',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Divider(thickness: 2),
                          ),
                          const SizedBox(height: 24),
                          const StudentTile(
                            MdiIcons.cashUsd,
                            'Mensalidade em dia',
                          ),
                          const SizedBox(height: 16),
                          const StudentTile(MdiIcons.gateAnd, 'Teste 02'),
                          const SizedBox(height: 8),

                          const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                            ),
                            child: Divider(thickness: 2),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 24, right: 32),
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: const Text('Ativo desde 01/11/2020'),
                            ),
                          ), //! Ultimo
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
