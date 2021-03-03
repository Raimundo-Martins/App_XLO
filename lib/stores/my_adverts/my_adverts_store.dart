import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo/repositories/adverts_repository.dart';
import 'package:xlo/stores/user/user_manager_store.dart';
part 'my_adverts_store.g.dart';

class MyAdvertsStore = _MyAdvertsStoreBase with _$MyAdvertsStore;

abstract class _MyAdvertsStoreBase with Store {
  _MyAdvertsStoreBase() {
    _getMyAdverts();
  }

  Future<void> _getMyAdverts() async {
    final user = GetIt.I<UserManagerStore>().user;
    AdvertsRepository().getMyAdverts(user);
  }
}
