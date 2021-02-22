import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xlo/screens/create/components/image_source_modal.dart';

class ImagesField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void onImageSelected(File image) {
      Navigator.of(context).pop();
    }

    return Container(
      color: Colors.grey[200],
      height: 120,
      child: ListView.builder(
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
          child: GestureDetector(
            onTap: () {
              if (Platform.isAndroid)
                showModalBottomSheet(
                    context: context,
                    builder: (context) => ImageSourceModal(onImageSelected));
              else
                showCupertinoModalPopup(
                    context: context,
                    builder: (context) => ImageSourceModal(onImageSelected));
            },
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_enhance, size: 40, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
        itemCount: 5,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
