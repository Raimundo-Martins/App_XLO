import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xlo/models/city.dart';
import 'package:xlo/models/uf.dart';

class IBGERepository {
  Future<List<UF>> getUFListFromApi() async {
    final preferences = await SharedPreferences.getInstance();

    if (preferences.containsKey('UF_LIST')) {
      final ufJson = json.decode(preferences.get('UF_LIST'));

      return ufJson.map<UF>((j) => UF.fromJson(j)).toList()
        ..sort(
          (UF a, UF b) => a.nome.toLowerCase().compareTo(b.nome.toLowerCase()),
        );
    }

    const endPoint =
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados';

    try {
      final response = await Dio().get<List>(endPoint);

      preferences.setString('UF_LIST', json.encode(response.data));

      return response.data.map<UF>((j) => UF.fromJson(j)).toList()
        ..sort((a, b) => a.nome.toLowerCase().compareTo(b.nome.toLowerCase()));
    } on DioError {
      return Future.error('Falha ao obter os estados!');
    }
  }

  Future<List<City>> getCityListFromApi(UF uf) async {
    final String endPoint =
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados/${uf.id}/municipios';

    try {
      final response = await Dio().get<List>(endPoint);
      final cytyList =
          response.data.map<City>((json) => City.fromJson(json)).toList()
            ..sort(
              (a, b) => a.nome.toLowerCase().compareTo(b.nome.toLowerCase()),
            );
      return cytyList;
    } on DioError {
      return Future.error('Falha ao obter as cidades!');
    }
  }
}
