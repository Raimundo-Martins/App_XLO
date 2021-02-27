import 'dart:io';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo/models/adverts.dart';
import 'package:path/path.dart' as path;
import 'package:xlo/repositories/parse_errors.dart';
import 'package:xlo/repositories/table_keys.dart';

class AdvertsRepository {
  Future<Adverts> save(Adverts adverts) async {
    try {
      final parseImages = await saveImages(adverts.images);
      final parseUser = ParseUser('', '', '')..set(keyUserId, adverts.user.id);
      final advertsObject = ParseObject(keyAdvertsTable);
      final parseACL = ParseACL(owner: parseUser);

      parseACL.setPublicReadAccess(allowed: true);
      parseACL.setPublicWriteAccess(allowed: false);
      advertsObject.setACL(parseACL);

      advertsObject.set<List<ParseFile>>(keyAdvertsImages, parseImages);
      advertsObject.set<String>(keyAdvertsTitle, adverts.title);
      advertsObject.set<String>(keyAdvertsDescription, adverts.description);
      advertsObject.set<ParseObject>(
          keyAdvertsCategory,
          ParseObject(keyCategoryTable)
            ..set(keyCategoryId, adverts.category.id));

      advertsObject.set<String>(keyAdvertsDistrict, adverts.address.district);
      advertsObject.set<String>(keyAdvertsCity, adverts.address.city.nome);
      advertsObject.set<String>(
          keyAdvertsFederativeUnit, adverts.address.uf.sigla);
      advertsObject.set<String>(keyAdvertsPostalCode, adverts.address.cep);

      advertsObject.set<num>(keyAdvertsPrice, adverts.price);
      advertsObject.set<bool>(keyAdvertsHidePhone, adverts.hidePhone);
      advertsObject.set<int>(keyAdvertsStatus, adverts.status.index);

      advertsObject.set<ParseUser>(keyAdvertsOwner, parseUser);

      final response = await advertsObject.save();

      if (response.success)
        return Adverts.fromParse(response.result);
      else
        return Future.error(ParseErrors.getDescription(response.error.code));
    } catch (e) {
      return Future.error('Falha ao salvar anúncio!');
    }
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
