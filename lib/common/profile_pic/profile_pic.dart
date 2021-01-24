import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfilePic extends StatelessWidget {
  ProfilePic({this.sizeProfile, this.image});

  double sizeProfile;
  String image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: sizeProfile * 1.5,
          child: Center(
            child: Container(
              height: sizeProfile * 1.05, //! 4
              width: sizeProfile * 1.05, //! 4
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
            ),
          ),
        ),
        SizedBox(
          height: sizeProfile * 1.5,
          child: Center(
            child: Container(
              height: sizeProfile,
              width: sizeProfile,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
