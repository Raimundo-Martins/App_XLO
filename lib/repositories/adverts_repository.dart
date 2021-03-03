import 'dart:io';

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo/models/adverts.dart';
import 'package:path/path.dart' as path;
import 'package:xlo/models/category.dart';
import 'package:xlo/models/user.dart';
import 'package:xlo/repositories/parse_errors.dart';
import 'package:xlo/repositories/table_keys.dart';
import 'package:xlo/stores/filter/filter_store.dart';

class AdvertsRepository {
  Future<void> save(Adverts adverts) async {
    try {
      final parseImages = await saveImages(adverts.images);
      final parseUser = ParseUser('', '', '')..set(keyUserId, adverts.user.id);
      final advertsObject = ParseObject(keyAdvertsTable);

      if (adverts.id != null) advertsObject.objectId = adverts.id;

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

      if (!response.success)
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

  Future<List<Adverts>> getHomeAdvertsList({
    FilterStore filterStore,
    String search,
    Category category,
    int page,
  }) async {
    final queryBuilder = QueryBuilder<ParseObject>(
      ParseObject(keyAdvertsTable),
    );

    queryBuilder.includeObject([keyAdvertsOwner, keyAdvertsCategory]);
    queryBuilder.setAmountToSkip(page * 10);
    queryBuilder.setLimit(10);
    queryBuilder.whereEqualTo(keyAdvertsStatus, AdvertsStatus.ACTIVE.index);

    if (search != null && search.trim().isNotEmpty) {
      queryBuilder.whereContains(keyAdvertsTitle, search, caseSensitive: false);
    }

    if (category != null && category.id != '*') {
      queryBuilder.whereEqualTo(
        keyAdvertsCategory,
        (ParseObject(keyCategoryTable)..set(keyCategoryId, category.id))
            .toPointer(),
      );
    }

    switch (filterStore.orderBy) {
      case OrderBy.DATE:
        queryBuilder.orderByDescending(keyAdvertsCreatedAt);
        break;
      case OrderBy.PRICE:
      default:
        queryBuilder.orderByAscending(keyAdvertsPrice);
        break;
    }

    if (filterStore.minPrice != null && filterStore.minPrice > 0) {
      queryBuilder.whereGreaterThanOrEqualsTo(
          keyAdvertsPrice, filterStore.minPrice);
    }

    if (filterStore.maxPrice != null && filterStore.maxPrice > 0) {
      queryBuilder.whereLessThanOrEqualTo(
          keyAdvertsPrice, filterStore.maxPrice);
    }

    if (filterStore.vendorType != null &&
        filterStore.vendorType > 0 &&
        filterStore.vendorType <
            (VENDOR_TYPE_PROFISSIONAL | VENDOR_TYPE_PARTICULAR)) {
      final userQuery = QueryBuilder<ParseUser>(ParseUser.forQuery());

      if (filterStore.vendorType == VENDOR_TYPE_PARTICULAR) {
        userQuery.whereEqualTo(keyUserType, UserType.PARTICULAR.index);
      }

      if (filterStore.vendorType == VENDOR_TYPE_PROFISSIONAL) {
        userQuery.whereEqualTo(keyUserType, UserType.PROFISSIONAL.index);
      }

      queryBuilder.whereMatchesQuery(keyAdvertsOwner, userQuery);
    }

    final response = await queryBuilder.query();

    if (response.success && response.results != null)
      return response.results
          .map((result) => Adverts.fromParse(result))
          .toList();
    else if (response.success && response.results == null)
      return [];
    else
      return Future.error(ParseErrors.getDescription(response.error.code));
  }

  Future<List<Adverts>> getMyAdverts(User user) async {
    final currentUser = ParseUser('', '', '')..set(keyUserId, user.id);
    final queryBuilder =
        QueryBuilder<ParseObject>(ParseObject(keyAdvertsTable));

    queryBuilder.setLimit(100);
    queryBuilder.orderByDescending(keyAdvertsCreatedAt);
    queryBuilder.whereEqualTo(keyAdvertsOwner, currentUser.toPointer());
    queryBuilder.includeObject([keyAdvertsCategory, keyAdvertsOwner]);

    final response = await queryBuilder.query();
    if (response.success && response.results != null)
      return response.results
          .map((result) => Adverts.fromParse(result))
          .toList();
    else if (response.success && response.results == null)
      return [];
    else
      return Future.error(ParseErrors.getDescription(response.error.code));
  }
}
