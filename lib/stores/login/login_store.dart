import 'package:get_it/get_it.dart';
import 'package:xlo/helpers/extensions.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo/repositories/user_repository.dart';
import 'package:xlo/stores/user/user_manager_store.dart';
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

  @observable
  String error;

  @action
  Future<void> login() async {
    loading = true;

    try {
      final user = await UserRepository().loginWithEmail(email, senha);
      GetIt.I<UserManagerStore>().setUser(user);
    } catch (e) {
      error = e;
    }

    loading = false;
  }
}
