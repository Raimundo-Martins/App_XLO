import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo/models/adverts.dart';
import 'package:xlo/repositories/favorite_repository.dart';
import 'package:xlo/stores/user/user_manager_store.dart';
part 'favorite_store.g.dart';

class FavoriteStore = _FavoriteStoreBase with _$FavoriteStore;

abstract class _FavoriteStoreBase with Store {
  _FavoriteStoreBase() {
    reaction((_) => userManagerStore.isLoggedIn, (_) {
      _getFavoriteList();
    });
  }

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  ObservableList<Adverts> favoriteList = ObservableList<Adverts>();

  @action
  Future<void> toggleFavorite(Adverts adverts) async {
    try {
      if (favoriteList.any((favorite) => favorite.id == adverts.id)) {
        favoriteList.removeWhere((favorite) => favorite.id == adverts.id);

        await FavoriteRepository().delete(
          adverts: adverts,
          user: userManagerStore.user,
        );
      } else {
        favoriteList.add(adverts);

        await FavoriteRepository().save(
          adverts: adverts,
          user: userManagerStore.user,
        );
      }
    } catch (e) {}
  }

  @action
  Future<void> _getFavoriteList() async {
    try {
      favoriteList.clear();
      final favorites =
          await FavoriteRepository().getFavorites(userManagerStore.user);

      favoriteList.addAll(favorites);
    } catch (e) {}
  }
}
