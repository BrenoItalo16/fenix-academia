import 'package:fenix_academia/helpers/custom_url.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// ignore: must_be_immutable
class OptionsSuport extends StatelessWidget {
  const OptionsSuport(
      {this.title, this.iconData, this.customRoute, this.pagina});
  final String title;
  final String customRoute;
  final IconData iconData;
  final int pagina;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (iconData == MdiIcons.whatsapp) {
          whatsapp();
        } else if (iconData == MdiIcons.phone) {
          customCall();
        } else {
          openMap();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          height: 65, //sizeHeight / 5,
          //width: ,//sizeWidth / 3,
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 80, 30, 30),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      iconData,
                      color: Colors.white70,
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(color: Colors.white70),
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
