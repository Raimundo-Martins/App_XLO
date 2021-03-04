import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo/models/address.dart';
import 'package:xlo/models/adverts.dart';
import 'package:xlo/models/category.dart';
import 'package:xlo/repositories/adverts_repository.dart';
import 'package:xlo/stores/cep/cep_store.dart';
import 'package:xlo/stores/user/user_manager_store.dart';
part 'create_store.g.dart';

class CreateStore = _CreateStoreBase with _$CreateStore;

abstract class _CreateStoreBase with Store {
  _CreateStoreBase(this.adverts) {
    images = adverts.images.asObservable();
    title = adverts.title ?? '';
    description = adverts.description ?? '';
    category = adverts.category;
    priceText = adverts.price?.toStringAsFixed(2) ?? '';
    hidePhone = adverts.hidePhone;

    if (adverts.address != null)
      cepStore = CepStore(adverts.address.cep);
    else
      cepStore = CepStore(null);
  }

  final Adverts adverts;

  ObservableList images = ObservableList();

  @computed
  bool get imagesValid => images.isNotEmpty;
  String get imagesError {
    if (!showErrors || imagesValid)
      return null;
    else
      return 'Insira uma imagem!';
  }

  @observable
  String title = '';

  @action
  void setTitle(String value) => title = value;

  @computed
  bool get titleValid => title.length >= 2;
  String get titleError {
    if (!showErrors || titleValid)
      return null;
    else if (title.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Título muito curto!';
  }

  @observable
  String description = '';

  @action
  void setDescription(String value) => description = value;

  @computed
  bool get descriptionValid => description.length >= 10;
  String get descriptionError {
    if (!showErrors || descriptionValid)
      return null;
    else if (description.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Descrição muito curta!';
  }

  @observable
  Category category;

  @action
  void setCategory(Category value) => category = value;

  @computed
  bool get categoryValid => category != null;
  String get categoryError {
    if (!showErrors || categoryValid)
      return null;
    else
      return 'Campo obrigatório!';
  }

  CepStore cepStore;

  @computed
  Address get address => cepStore.address;
  bool get addressValid => address != null;
  String get addressError {
    if (!showErrors || addressValid)
      return null;
    else
      return 'Campo obrigatório!';
  }

  @observable
  String priceText = '';

  @action
  void setPrice(String value) => priceText = value;

  @computed
  num get price {
    if (priceText.contains(','))
      return num.tryParse(priceText.replaceAll(RegExp('[^0-9]'), '')) / 100;
    else
      return num.tryParse(priceText);
  }

  bool get priceValid => price != null && price <= 9999999;
  String get priceError {
    if (!showErrors || priceValid)
      return null;
    else if (priceText.isEmpty)
      return 'Campo obrigatório';
    else
      return 'Preço inválido!';
  }

  @observable
  bool hidePhone = false;

  @action
  void setHidePhone(bool value) => hidePhone = value;

  @computed
  bool get formValid =>
      imagesValid &&
      titleValid &&
      descriptionValid &&
      categoryValid &&
      addressValid &&
      priceValid;

  @computed
  Function get sendPressed => formValid ? _send : null;

  @observable
  bool showErrors = false;

  @action
  void invalidSendPressed() => showErrors = true;

  @observable
  bool loading = false;

  @observable
  String error;

  @action
  Future<void> _send() async {
    final adverts = Adverts();
    adverts.images = images;
    adverts.title = title;
    adverts.description = description;
    adverts.category = category;
    adverts.address = address;
    adverts.price = price;
    adverts.hidePhone = hidePhone;
    adverts.user = GetIt.I<UserManagerStore>().user;

    loading = true;
    try {
      await AdvertsRepository().save(adverts);
      savedAdverts = true;
    } catch (e) {
      error = e;
    }
    loading = false;
  }

  @observable
  bool savedAdverts = false;
}
