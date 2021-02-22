import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo/screens/create/components/image_dialog.dart';
import 'package:xlo/screens/create/components/image_source_modal.dart';
import 'package:xlo/stores/create/create_store.dart';

class ImagesField extends StatelessWidget {
  final CreateStore createStore;

  ImagesField(this.createStore);

  @override
  Widget build(BuildContext context) {
    void onImageSelected(File image) {
      createStore.images.add(image);
      Navigator.of(context).pop();
    }

    return Container(
      color: Colors.grey[200],
      height: 120,
      child: Observer(
        builder: (context) => ListView.builder(
          itemBuilder: (context, index) {
            if (index == createStore.images.length + 1)
              return Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                child: GestureDetector(
                  onTap: () {
                    if (Platform.isAndroid)
                      showModalBottomSheet(
                          context: context,
                          builder: (context) =>
                              ImageSourceModal(onImageSelected));
                    else
                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) =>
                              ImageSourceModal(onImageSelected));
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_enhance,
                            size: 40, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              );
            else
              return Padding(
                padding: EdgeInsets.fromLTRB(8, 16, index == 4 ? 8 : 0, 16),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => ImageDialog(
                        image: createStore.images[index],
                        onDelete: () => createStore.images.removeAt(index),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: FileImage(createStore.images[index]),
                  ),
                ),
              );
          },
          itemCount:
              createStore.images.length < 5 ? createStore.images.length + 1 : 5,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
