import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo/models/adverts.dart';
import 'package:xlo/models/category.dart';
import 'package:xlo/repositories/adverts_repository.dart';
import 'package:xlo/stores/connectivity/connectivity_store.dart';
import 'package:xlo/stores/filter/filter_store.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();

  _HomeStoreBase() {
    autorun((_) async {
      // ignore: unnecessary_statements
      connectivityStore.connected;
      try {
        setLoading(true);
        final newAdverts = await AdvertsRepository().getHomeAdvertsList(
          filterStore: filterStore,
          search: search,
          category: category,
          page: page,
        );

        addNewAdverts(newAdverts);
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
  void setSearch(String value) {
    search = value;
    resetPage();
  }

  @observable
  Category category;

  @action
  void setCategory(Category value) {
    category = value;
    resetPage();
  }

  @observable
  FilterStore filterStore = FilterStore();

  FilterStore get filterStoreClone => filterStore.clone();

  @action
  void setFilter(FilterStore value) {
    filterStore = value;
    resetPage();
  }

  @observable
  String error;

  @action
  void setError(String value) => error = value;

  @observable
  bool loading = false;

  @action
  void setLoading(bool value) => loading = value;

  @observable
  int page = 0;

  @action
  void loadingNextPage() => page++;

  @computed
  int get itemCount => lastPage ? advertsList.length : advertsList.length + 1;

  void resetPage() {
    page = 0;
    advertsList.clear();
    lastPage = false;
  }

  @action
  void addNewAdverts(List<Adverts> newAdverts) {
    if (newAdverts.length < 10) lastPage = true;
    advertsList.addAll(newAdverts);
  }

  @observable
  bool lastPage = false;

  @computed
  bool get showProgress => loading && advertsList.isEmpty;
}
