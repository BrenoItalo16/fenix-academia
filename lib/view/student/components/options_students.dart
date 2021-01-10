import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OptionsStudents extends StatelessWidget {
  OptionsStudents({this.title, this.iconData});
  String title;
  IconData iconData;
  @override
  Widget build(BuildContext context) {
    final double sizeHeight = MediaQuery.of(context).size.height;
    final double sizeWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: sizeHeight / 5,
      width: sizeWidth / 3,
      child: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(200, 80, 30, 30),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                iconData,
                color: Colors.white70,
                size: sizeWidth / 6,
              ),
              Text(
                title,
                style: TextStyle(
                  //fontSize: 16,
                  fontSize: sizeWidth / 25,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
