enum UserType { PARTICULAR, PROFISSIONAL }

class User {
  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.senha,
      this.type = UserType.PARTICULAR,
      this.createdAt});

  String id;
  String name;
  String email;
  String phone;
  String senha;
  UserType type;
  DateTime createdAt;
  
}
