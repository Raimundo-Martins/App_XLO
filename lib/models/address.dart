import 'package:xlo/models/city.dart';
import 'package:xlo/models/uf.dart';

class Address {
  Address({this.uf, this.city, this.cep, this.district});

  UF uf;
  City city;
  String cep;
  String district;
}
