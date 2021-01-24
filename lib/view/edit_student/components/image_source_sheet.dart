import 'package:flutter/material.dart';

class ImageSourceSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FlatButton(
            onPressed: () {},
            child: const Text(
              'Câmera',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 46),
            child: Divider(),
          ),
          FlatButton(
            onPressed: () {},
            child: const Text(
              'Galeria',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 16)
        ],
      ),
      onClosing: () {},
    );
  }
}
