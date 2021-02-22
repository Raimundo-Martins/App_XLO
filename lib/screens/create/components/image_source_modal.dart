import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageSourceModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid)
      return BottomSheet(
        onClosing: () => null,
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FlatButton(child: Text('Câmera'), onPressed: () {}),
            FlatButton(child: Text('Galeria'), onPressed: () {})
          ],
        ),
      );
    else
      return CupertinoActionSheet(
        title: Text('Selecione para adicionar uma foto.'),
        cancelButton: CupertinoActionSheetAction(
            child: Text('Cancelar', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: [
          CupertinoActionSheetAction(child: Text('Câmera'), onPressed: () {}),
          CupertinoActionSheetAction(child: Text('Câmera'), onPressed: () {}),
        ],
      );
  }
}
