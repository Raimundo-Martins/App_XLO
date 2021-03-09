import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo/models/adverts.dart';
import 'package:xlo/repositories/favorite_repository.dart';
import 'package:xlo/stores/user/user_manager_store.dart';
part 'favorite_store.g.dart';

class FavoriteStore = _FavoriteStoreBase with _$FavoriteStore;

abstract class _FavoriteStoreBase with Store {
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  Future<void> toggleFavorite(Adverts adverts) async {
    try {
      await FavoriteRepository()
          .save(adverts: adverts, user: userManagerStore.user);
    } catch (e) {}
  }
}
