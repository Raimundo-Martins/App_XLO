import 'package:xlo/helpers/extensions.dart';
import 'package:mobx/mobx.dart';
part 'sign_up_store.g.dart';

class SignUpStore = _SignUpStoreBase with _$SignUpStore;

abstract class _SignUpStoreBase with Store {
  @observable
  String name;

  @action
  void setNome(String value) => name = value;

  @computed
  bool get nameValid => name != null && name.length >= 6;
  String get nameError {
    if (name == null || nameValid)
      return null;
    else if (name.isEmpty)
      return 'Campo obrigatório!';
    else
      return 'Nome muito curto!';
  }

  @observable
  String email;

  @action
  void setEmail(String value) => email = value;

  @computed
  bool get emailValid => email != null && email.isEmailValid();
  String get emailError {
    if (email == null || emailValid)
      return null;
    else if (email.isEmpty)
      return 'Campo obrigatório!';
    else
      return 'E-mail inválido!';
  }

  @observable
  String phone;

  @action
  void setPhone(String value) => phone = value;

  @computed
  bool get phoneValid => phone != null && phone.length >= 14;
  String get phoneError {
    if (phone == null || phoneValid)
      return null;
    else if (phone.isEmpty)
      return 'Campo obrigatório!';
    else
      return 'Celular enválido!';
  }

  @observable
  String senha1;

  @action
  void setSenha1(String value) => senha1 = value;

  @computed
  bool get senha1Valid => senha1 != null && senha1.length >= 6;
  String get senha1Error {
    if (senha1 == null || senha1Valid)
      return null;
    else if (senha1.isEmpty)
      return 'Campo obrigatório!';
    else
      return 'Senha enválida!';
  }

  @observable
  String senha2;

  @action
  void setSenha2(String value) => senha2 = value;

  @computed
  bool get senha2Valid => senha2 != null && senha2 == senha1;
  String get senha2Error {
    if (senha2 == null || senha2Valid)
      return null;
    else
      return 'Senha diferente!';
  }
}
