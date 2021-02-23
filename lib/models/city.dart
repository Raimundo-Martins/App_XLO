class City {
  City({this.id, this.nome});

  int id;
  String nome;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json['id'],
        nome: json['nome'],
      );
}
