import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceModal extends StatelessWidget {
  final Function(File) onImageSelected;

  ImageSourceModal(this.onImageSelected);

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid)
      return BottomSheet(
        onClosing: () => null,
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FlatButton(child: Text('Câmera'), onPressed: getFromCamera),
            FlatButton(child: Text('Galeria'), onPressed: getFromGaleria)
          ],
        ),
      );
    else
      return CupertinoActionSheet(
        title: Text('Selecione para adicionar uma foto.'),
        cancelButton: CupertinoActionSheetAction(
            child: Text('Cancelar', style: TextStyle(color: Colors.red)),
            onPressed: Navigator.of(context).pop),
        actions: [
          CupertinoActionSheetAction(
              child: Text('Câmera'), onPressed: getFromCamera),
          CupertinoActionSheetAction(
              child: Text('Câmera'), onPressed: getFromGaleria),
        ],
      );
  }

  Future<void> getFromCamera() async {
    final imageFile = await ImagePicker().getImage(source: ImageSource.camera);
    if (imageFile == null) return;
    final image = File(imageFile.path);
    imageSelected(image);
  }

  Future<void> getFromGaleria() async {
    final imageFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (imageFile == null) return;
    final image = File(imageFile.path);
    imageSelected(image);
  }

  Future<void> imageSelected(File image) async {
    final cropperFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Editar imagem',
        toolbarColor: Colors.purple,
        toolbarWidgetColor: Colors.white,
      ),
      iosUiSettings: IOSUiSettings(
        title: 'Editar imagem',
        cancelButtonTitle: 'Cancelar',
        doneButtonTitle: 'Concluir',
      ),
    );
    if (cropperFile != null) onImageSelected(cropperFile);
  }
}
