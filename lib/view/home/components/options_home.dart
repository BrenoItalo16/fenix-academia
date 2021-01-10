import 'package:flutter/material.dart';
import 'package:fenix_academia/models/page_manager.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OptionsHome extends StatelessWidget {
  const OptionsHome({this.title, this.iconData, this.customRoute, this.pagina});
  final String title;
  final String customRoute;
  final IconData iconData;
  final int pagina;

  @override
  Widget build(BuildContext context) {
    //final int curPage = pagina;
    final double sizeHeight = MediaQuery.of(context).size.height;
    final double sizeWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        context.read<PageManager>().setPage(pagina);
        Navigator.of(context).pushNamed(customRoute);
        Navigator.of(context).pop();
        //debugPrint('passou $curPage');
      },
      child: SizedBox(
        height: sizeHeight / 5,
        width: sizeWidth / 3,
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
    );
  }
}
