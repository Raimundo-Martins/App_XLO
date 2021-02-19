import 'package:xlo/helpers/extensions.dart';
import 'package:mobx/mobx.dart';
part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  @observable
  String email;

  @action
  void setEmail(String value) => email = value;

  @computed
  bool get emailValid => email != null && email.isEmailValid();
  String get emailError =>
      email == null || emailValid ? null : 'E-mail inválido!';

  @observable
  String senha;

  @action
  void setSenha(String value) => senha = value;

  @computed
  bool get senhaValid => senha != null && senha.length >= 4;
  String get senhaError =>
      senha == null || senhaValid ? null : 'Senha inválida!';

  @computed
  Function get loginPressed =>
      emailValid && senhaValid && !loading ? login : null;

  @observable
  bool loading = false;

  @action
  Future<void> login() async {
    loading = true;

    loading = false;
  }
}
