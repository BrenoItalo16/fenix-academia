import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class LoadingAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 200,
      child: FlareActor(
        'android/assets/images/loading.flr',
        animation: "Untitled",
      ),
    );
  }
}
