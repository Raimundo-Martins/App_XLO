import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo/models/adverts.dart';
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
    try {
      loading = true;
      allAdverts = await AdvertsRepository().getMyAdverts(user);
      loading = false;
    } catch (e) {}
  }

  @observable
  List<Adverts> allAdverts = [];

  @computed
  List<Adverts> get activeAdverts => allAdverts
      .where((adverts) => adverts.status == AdvertsStatus.ACTIVE)
      .toList();
  List<Adverts> get pendingAdverts => allAdverts
      .where((adverts) => adverts.status == AdvertsStatus.PENDING)
      .toList();
  List<Adverts> get soldAdverts => allAdverts
      .where((adverts) => adverts.status == AdvertsStatus.SOLD)
      .toList();

  @observable
  bool loading = false;

  void refresh() => _getMyAdverts();

  @action
  Future<void> soldAdvert(Adverts adverts) async {
    loading = true;
    await AdvertsRepository().sold(adverts);
    refresh();
  }

  @action
  Future<void> deleteAdvert(Adverts adverts) async {
    loading = true;
    await AdvertsRepository().delete(adverts);
    refresh();
  }
}
