import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:xlo/models/user.dart';
import 'package:xlo/repositories/parse_errors.dart';
import 'package:xlo/repositories/table_keys.dart';

class UserRepository {
  Future<User> signUp(User user) async {
    final parseUser = ParseUser(user.email, user.senha, user.email);

    parseUser.set<String>(KeyUserName, user.name);
    parseUser.set<String>(KeyUserPhone, user.phone);
    parseUser.set(KeyUserType, user.type.index);

    final response = await parseUser.signUp();

    if (response.success)
      return mapParseToUser(response.result);
    else
      return Future.error(ParseErrors.getDescription(response.error.code));
  }

  Future<User> loginWithEmail(String email, String senha) async {
    final parseUser = ParseUser(email, senha, null);
    final response = await parseUser.login();

    if (response.success)
      return mapParseToUser(response.result);
    else
      return Future.error(ParseErrors.getDescription(response.error.code));
  }

  User mapParseToUser(ParseUser parseUser) {
    return User(
      id: parseUser.objectId,
      name: parseUser.get(KeyUserName),
      email: parseUser.get(KeyUserEmail),
      phone: parseUser.get(KeyUserPhone),
      type: UserType.values[parseUser.get(KeyUserType)],
      createdAt: parseUser.get(KeyUserCreatedAt),
    );
  }

  Future<User> currentUser() async {
    final parseUser = await ParseUser.currentUser();
    if (parseUser != null) {
      final response =
          await ParseUser.getCurrentUserFromServer(parseUser.sessionToken);
      if (response.success)
        return mapParseToUser(response.result);
      else
        await parseUser.logout();
    }
    return null;
  }
}
