import 'package:flutter/material.dart';

class StudentTile extends StatelessWidget {
  const StudentTile(this.iconData, this.whatsapp);

  final IconData iconData;
  final String whatsapp;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 32),
          child: Icon(
            iconData,
            color: const Color.fromARGB(230, 80, 30, 30),
          ),
        ),
        Text(
          whatsapp, //Todo: Color o número
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
