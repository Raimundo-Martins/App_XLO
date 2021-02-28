import 'package:mobx/mobx.dart';
part 'filter_store.g.dart';

enum OrderBy { DATE, PRICE }

class FilterStore = _FilterStoreBase with _$FilterStore;

abstract class _FilterStoreBase with Store {
  @observable
  OrderBy orderBy = OrderBy.DATE;

  @action
  void setOrderBy(OrderBy value) => orderBy = value;

  @observable
  int minPrice;

  @action
  void setMin(int value) => minPrice = value;

  @observable
  int maxPrice;

  @action
  void setMax(int value) => maxPrice = value;

  @computed
  String get priceError =>
      minPrice != null && maxPrice != null && maxPrice < minPrice
          ? 'Faixa de preço inválida!'
          : null;
}
