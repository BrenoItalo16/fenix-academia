import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OptionsStudents extends StatelessWidget {
  const OptionsStudents({this.title, this.iconData});
  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    //final int curPage = pagina;
    final double sizeHeight = MediaQuery.of(context).size.height;
    final double sizeWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        debugPrint('Clicado com sucesso');
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: SizedBox(
          height: sizeHeight / 6,
          width: sizeWidth / 10,
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 80, 30, 30),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    iconData,
                    color: Colors.white,
                    size: sizeWidth / 6,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      //fontSize: 16,
                      fontSize: sizeWidth / 25,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
