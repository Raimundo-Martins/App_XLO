import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:xlo/models/user.dart';
import 'package:xlo/repositories/table_keys.dart';

class UserRepository {
  Future<void> signUp(User user) async {
    final parseUser = ParseUser(user.email, user.senha, user.email);

    parseUser.set<String>(KeyUserName, user.name);
    parseUser.set<String>(KeyUserPhone, user.phone);
    parseUser.set(KeyUserType, user.type.index);

    await parseUser.signUp();
  }
}
