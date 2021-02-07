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
    final heightScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Dados do aluno',
          style: TextStyle(
            fontSize: heightScreen / 20,
          ),
        ),
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
                    sizeProfile: heightScreen / 3,
                    image: widget.student.images.last,
                  ),
                  Stack(
                    children: [
                      Container(
                        height: heightScreen * 1.55,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(60)),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Center(
                              child: Text(
                                widget.student.name,
                                style: TextStyle(
                                    fontSize: heightScreen / 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Consumer<UserManager>(
                            builder: (_, userManager, __) {
                              if (userManager.devEnabled) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 42,
                                    vertical: 8,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      RaisedButton(
                                        onPressed: () {
                                          widget.student.saveAdm();
                                        },
                                        child: Text(
                                          'Tonar adm',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black38,
                                            fontSize: heightScreen / 25,
                                          ),
                                        ),
                                      ),
                                      RaisedButton(
                                        onPressed: () {
                                          widget.student.saveTreiner();
                                        },
                                        child: Text(
                                          'Tornar instrutor',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black38,
                                            fontSize: heightScreen / 25,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return Container();
                            },
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
                              '${widget.student?.whatsapp ?? 'Sem whatsapp'}',
                            ), //! Já pode inserir no banco de dados
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: StudentTile(
                              MdiIcons.instagram,
                              // ignore: unnecessary_string_interpolations
                              '${widget.student?.instagram ?? 'Sem insta'}',
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
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          32, 0, 16, 0),
                                      child: Icon(
                                        MdiIcons.weightKilogram,
                                        color: const Color.fromARGB(
                                            230, 80, 30, 30),
                                        size: heightScreen / 16,
                                      ),
                                    ),
                                    Text(
                                      '${widget.student?.weight ?? '0.0'} kg',
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: heightScreen / 25,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: Icon(
                                        MdiIcons.humanMaleHeight,
                                        color: const Color.fromARGB(
                                            230, 80, 30, 30),
                                        size: heightScreen / 16,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 32, 0),
                                      child: Text(
                                        '${widget.student?.size ?? '0.0'} m de altura',
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: heightScreen / 25,
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
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 16, left: 32),
                                  child: Icon(
                                    MdiIcons.timelapse,
                                    color:
                                        const Color.fromARGB(230, 80, 30, 30),
                                    size: heightScreen / 16,
                                  ),
                                ),
                                Text(
                                  widget.student?.yearsOld ?? "nada",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: heightScreen / 25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 16, left: 32),
                                  child: Icon(
                                    MdiIcons.chartBox,
                                    color:
                                        const Color.fromARGB(230, 80, 30, 30),
                                    size: heightScreen / 16,
                                  ),
                                ),
                                Text(
                                  'Seu IMC é ${widget.student?.imc ?? ""}',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: heightScreen / 25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 16, left: 32),
                                  child: Icon(
                                    MdiIcons.alertDecagram,
                                    color: Colors.amber,
                                    size: heightScreen / 16,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    widget.student?.imcInfo ?? "",
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: heightScreen / 25,
                                    ),
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
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 24, right: 32),
                          //   child: Container(
                          //     alignment: Alignment.centerRight,
                          //     child: Text(
                          //       'Ativo desde 01/11/2020',
                          //       style: TextStyle(
                          //         fontSize: heightScreen / 30,
                          //       ),
                          //     ),
                          //   ), //! Ultimo
                          // ),
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
