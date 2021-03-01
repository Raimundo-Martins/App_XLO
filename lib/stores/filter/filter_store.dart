import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo/stores/home/home_store.dart';
part 'filter_store.g.dart';

enum OrderBy { DATE, PRICE }

const VENDOR_TYPE_PARTICULAR = 1 << 0;
const VENDOR_TYPE_PROFISSIONAL = 1 << 1;

class FilterStore = _FilterStoreBase with _$FilterStore;

abstract class _FilterStoreBase with Store {
  _FilterStoreBase({
    this.orderBy = OrderBy.DATE,
    this.minPrice,
    this.maxPrice,
    this.vendorType = VENDOR_TYPE_PARTICULAR,
  });

  @observable
  OrderBy orderBy;

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

  @observable
  int vendorType;

  @action
  void selectVendorType(int value) => vendorType = value;
  void setVendorType(int type) => vendorType = vendorType | type;
  void resetVendorType(int type) => vendorType = vendorType & ~type;

  @computed
  bool get isTypeParticular => (vendorType & VENDOR_TYPE_PARTICULAR) != 0;
  bool get isTypeProfissional => (vendorType & VENDOR_TYPE_PROFISSIONAL) != 0;

  @computed
  bool get isFormValid => priceError == null;

  void save() {
    GetIt.I<HomeStore>().setFilter(this);
  }

  FilterStore clone() {
    return FilterStore(
      orderBy: orderBy,
      minPrice: minPrice,
      maxPrice: maxPrice,
      vendorType: vendorType,
    );
  }
}
