import 'package:mobx/mobx.dart';
import 'package:xlo/models/adverts.dart';
import 'package:xlo/models/category.dart';
import 'package:xlo/repositories/adverts_repository.dart';
import 'package:xlo/stores/filter/filter_store.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  _HomeStoreBase() {
    autorun((_) async {
      try {
        setLoading(true);
        final newAdverts = await AdvertsRepository().getHomeAdvertsList(
          filterStore: filterStore,
          search: search,
          category: category,
        );
        advertsList.clear();
        advertsList.addAll(newAdverts);

        setError(null);
        setLoading(false);
      } catch (e) {
        setError(e);
      }
    });
  }

  ObservableList<Adverts> advertsList = ObservableList<Adverts>();

  @observable
  String search = '';

  @action
  void setSearch(String value) => search = value;

  @observable
  Category category;

  @action
  void setCategory(Category value) => category = value;

  @observable
  FilterStore filterStore = FilterStore();

  FilterStore get filterStoreClone => filterStore.clone();

  @action
  void setFilter(FilterStore value) => filterStore = value;

  @observable
  String error;

  @action
  void setError(String value) => error = value;

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;
}
