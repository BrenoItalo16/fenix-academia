import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:fenix_academia/models/student.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'image_source_sheet.dart';

class ImagesForm extends StatelessWidget {
  const ImagesForm(this.student);
  final Student student;
  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: student.images,
      builder: (state) {
        return AspectRatio(
          aspectRatio: 1,
          child: Carousel(
            images: state.value.map<Widget>((image) {
              return Card(
                margin: const EdgeInsets.fromLTRB(32, 16, 32, 32),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    if (image is String)
                      Image.network(image, fit: BoxFit.cover)
                    else
                      Image.file(image as File, fit: BoxFit.cover),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        decoration: const BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black54,
                                blurRadius: 5.0,
                                offset: Offset(0.75, 0.1))
                          ],
                          color: Colors.white,
                          // borderRadius: BorderRadius.all(Radius.circular(60.0)),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10)),
                        ),
                        child: IconButton(
                          icon: const Icon(MdiIcons.delete),
                          color: Colors.red,
                          onPressed: () {
                            state.value.remove(image);
                            state.didChange(state.value);
                          },
                        ),
                      ),
                    )
                  ],
                ),
              );
            }).toList()
              ..add(
                //! Início do Cartão
                Card(
                  margin: const EdgeInsets.fromLTRB(32, 16, 32, 32),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Material(
                        color: Colors.grey[300],
                        child: IconButton(
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: Colors.grey,
                            size: 46,
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (_) => ImageSourceSheet(),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),

            //! Final do cartão
            dotSize: 4,
            dotSpacing: 15,
            dotBgColor: Colors.transparent,
            dotColor: Theme.of(context).primaryColor,
            dotIncreasedColor: Colors.redAccent,
            dotVerticalPadding: -4,
            autoplay: false,
          ),
        );
      },
    );
  }
}
