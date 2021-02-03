import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextTile extends StatelessWidget {
  TextTile(this.initialValue, this.hintText);
  String initialValue;
  String hintText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
