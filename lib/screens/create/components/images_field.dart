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

    return Column(
      children: [
        Container(
          color: Colors.grey[200],
          height: 100,
          child: Observer(
            builder: (context) => ListView.builder(
              itemBuilder: (context, index) {
                if (index == createStore.images.length)
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
                        radius: 45,
                        backgroundColor: Colors.grey[500],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_enhance,
                                size: 50, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  );
                else
                  return Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, index == 4 ? 8 : 0, 8),
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
                        radius: 45,
                        backgroundImage: FileImage(createStore.images[index]),
                      ),
                    ),
                  );
              },
              itemCount: createStore.images.length < 5
                  ? createStore.images.length + 1
                  : 5,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
        Observer(
          builder: (context) {
            if (createStore.imagesError != null)
              return Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.red)),
                ),
                padding: EdgeInsets.fromLTRB(16, 8, 0, 8),
                child: Text(
                  createStore.imagesError,
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              );
            else
              return Container();
          },
        )
      ],
    );
  }
}
