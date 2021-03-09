import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo/models/adverts.dart';
import 'package:xlo/models/user.dart';
import 'package:xlo/repositories/parse_errors.dart';
import 'package:xlo/repositories/table_keys.dart';

class FavoriteRepository {
  Future<void> save({Adverts adverts, User user}) async {
    final favoriteObject = ParseObject(keyFavoritesTable);

    favoriteObject.set<String>(keyFavoritesOwner, user.id);
    favoriteObject.set<ParseObject>(
      keyFavoritesAdverts,
      ParseObject(keyAdvertsTable)..set(keyAdvertsId, adverts.id),
    );

    final response = await favoriteObject.save();

    if (!response.success)
      return Future.error(ParseErrors.getDescription(response.error.code));
  }

  Future<List<Adverts>> getFavorites(User user) async {
    final queryBuilder =
        QueryBuilder<ParseObject>(ParseObject(keyFavoritesTable));

    queryBuilder.whereEqualTo(keyFavoritesOwner, user.id);
    queryBuilder.includeObject([keyFavoritesAdverts, 'adverts.owner']);

    final response = await queryBuilder.query();

    if (response.success && response.results != null)
      return response.results
          .map((favorite) =>
              Adverts.fromParse(favorite.get(keyFavoritesAdverts)))
          .toList();
    else if (response.success && response.results == null)
      return [];
    else
      return Future.error(ParseErrors.getDescription(response.error.code));
  }

  Future<void> delete({Adverts adverts, User user}) async {
    try {
      final queryBuilder =
          QueryBuilder<ParseObject>(ParseObject(keyFavoritesTable));

      queryBuilder.whereEqualTo(keyFavoritesOwner, user.id);
      queryBuilder.whereEqualTo(
        keyFavoritesAdverts,
        ParseObject(keyAdvertsTable)..set(keyAdvertsId, adverts.id),
      );

      final response = await queryBuilder.query();

      if (response.success && response.results != null) {
        for (final favorite in response.results as List<ParseObject>) {
          favorite.delete();
        }
      }
    } catch (e) {
      return Future.error('Falha ao deletar favorito!');
    }
  }
}
