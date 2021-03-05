import 'dart:ui';

import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo/models/user.dart';
import 'package:xlo/stores/user/user_manager_store.dart';
part 'edit_account_store.g.dart';

class EditAccountStore = _EditAccountStoreBase with _$EditAccountStore;

abstract class _EditAccountStoreBase with Store {
  final userManagerStore = GetIt.I<UserManagerStore>();

  _EditAccountStoreBase() {
    final user = userManagerStore.user;

    userType = user.type;
    name = user.name;
    phone = user.phone;
  }

  @observable
  UserType userType;

  @action
  void setUserType(int value) => userType = UserType.values[value];

  @observable
  String name;

  @action
  void setName(String value) => name = value;

  @computed
  bool get nameValid => name != null && name.length >= 2;
  String get nameError =>
      nameValid || name == null ? null : 'Campo obrigatório!';

  @observable
  String phone;

  @action
  void setPhone(String value) => phone = value;

  @computed
  bool get phoneValid => phone != null && phone.length >= 14;
  String get phoneError =>
      phoneValid || phone == null ? null : 'Campo obrigatório!';

  @observable
  String senha1 = '';

  @action
  void setSenha1(String value) => senha1 = value;

  @observable
  String senha2 = '';

  @action
  void setSenha2(String value) => senha2 = value;

  @computed
  bool get senhaValid =>
      senha2 == senha1 && (senha1.length >= 6 || senha1.isEmpty);
  String get senhaError {
    if (senha1.isNotEmpty && senha1.length < 6)
      return 'Senha muito curta!';
    else if (senha1 != senha2) return 'As senhas não são iguais!';
    return null;
  }

  @computed
  bool get isFormValid => nameValid && phoneValid && senhaValid;

  @observable
  bool loading = false;

  @computed
  VoidCallback get savePressed => (isFormValid && !loading) ? _save : null;

  @action
  Future<void> _save() async {
    loading = true;
  }
}
