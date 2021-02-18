enum UserType { PARTICULAR, PROFISSIONAL }

class User {
  User(
      {this.name,
      this.email,
      this.phone,
      this.senha,
      this.type = UserType.PARTICULAR});

  String name;
  String email;
  String phone;
  String senha;
  UserType type;
}
