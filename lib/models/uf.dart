import 'package:flutter/foundation.dart';

class UF {
  UF({this.id, this.sigla, this.nome});

  int id;
  String sigla;
  String nome;

  factory UF.fromJson(Map<String, dynamic> json) => UF(
        id: json['id'],
        sigla: json['sigla'],
        nome: json['nome'],
      );
}
