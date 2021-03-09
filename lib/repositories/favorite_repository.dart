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
}
