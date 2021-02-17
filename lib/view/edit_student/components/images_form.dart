import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:fenix_academia/models/user.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'image_source_sheet.dart';

class ImagesForm extends StatelessWidget {
  const ImagesForm(this.student);
  final User student;
  @override
  Widget build(BuildContext context) {
    // final heightScreen = MediaQuery.of(context).size.width;
    return FormField<List<dynamic>>(
      initialValue: List.from(student.images),
      validator: (images) {
        if (images.isEmpty) return 'Insira ao menos uma imagem';
        return null;
      },
      onSaved: (images) => student.newImages = images,
      builder: (state) {
        void onImageSelected(File file) {
          state.value.add(file);
          state.didChange(state.value);
          Navigator.of(context).pop();
        }

        return Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Carousel(
                images: state.value.map<Widget>((image) {
                  return Card(
                    margin: const EdgeInsets.fromLTRB(80, 80, 80, 80),
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
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
                      margin: const EdgeInsets.fromLTRB(80, 80, 80, 80),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
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
                                size: 90,
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (_) => ImageSourceSheet(
                                    onImageSelected: onImageSelected,
                                  ),
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
            ),
            if (state.hasError)
              Text(
                state.errorText,
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontSize: 16,
                ),
              ),
          ],
        );
      },
    );
  }
}
