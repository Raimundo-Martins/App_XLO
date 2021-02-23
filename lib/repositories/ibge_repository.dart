import 'package:dio/dio.dart';
import 'package:xlo/models/uf.dart';

class IBGERepository {
  Future<List<UF>> getUFListFromApi() async {
    const endPoint =
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados';

    try {
      final response = await Dio().get<List>(endPoint);
      final ufList = response.data.map<UF>((json) => UF.fromJson(json)).toList()
        ..sort((a, b) => a.nome.toLowerCase().compareTo(b.nome.toLowerCase()));
      return ufList;
    } on DioError {
      return Future.error('Falha ao obter os estados!');
    }
  }

  getCityListFromApi() {}
}
