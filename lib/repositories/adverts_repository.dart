import 'dart:io';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo/models/adverts.dart';
import 'package:path/path.dart' as path;
import 'package:xlo/repositories/parse_errors.dart';

class AdvertsRepository {
  void save(Adverts adverts) async {
    final parseImages = await saveImages(adverts.images);
  }

  Future<List<ParseFile>> saveImages(List images) async {
    final parseImages = <ParseFile>[];

    try {
      for (final image in images) {
        if (image is File) {
          final parseFile = ParseFile(image, name: path.basename(image.path));
          final response = await parseFile.save();
          if (!response.success)
            return Future.error(
                ParseErrors.getDescription(response.error.code));

          parseImages.add(parseFile);
        } else {
          final parseFile = ParseFile(null);
          parseFile.name = path.basename(image);
          parseFile.url = image;
          parseImages.add(parseFile);
        }
      }
    } catch (e) {
      return Future.error('Falha ao salvar imagens!');
    }

    return parseImages;
  }
}
