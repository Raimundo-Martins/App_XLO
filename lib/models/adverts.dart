import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo/models/address.dart';
import 'package:xlo/models/category.dart';
import 'package:xlo/models/city.dart';
import 'package:xlo/models/uf.dart';
import 'package:xlo/models/user.dart';
import 'package:xlo/repositories/table_keys.dart';
import 'package:xlo/repositories/user_repository.dart';

enum AdvertsStatus { PENDING, ACTIVE, SOLD, DELETED }

class Adverts {
  Adverts();

  Adverts.fromParse(ParseObject object) {
    id = object.objectId;
    title = object.get<String>(keyAdvertsTitle);
    description = object.get<String>(keyAdvertsDescription);
    images =
        object.get<List>(keyAdvertsImages).map((image) => image.url).toList();
    hidePhone = object.get<bool>(keyAdvertsHidePhone);
    price = object.get<num>(keyAdvertsPrice);
    created = object.createdAt;
    address = Address(
      district: object.get<String>(keyAdvertsDistrict),
      city: City(nome: object.get<String>(keyAdvertsCity)),
      uf: UF(sigla: object.get<String>(keyAdvertsFederativeUnit)),
      cep: object.get<String>(keyAdvertsPostalCode),
    );
    views = object.get<int>(keyAdvertsViews, defaultValue: 0);
    user =
        UserRepository().mapParseToUser(object.get<ParseUser>(keyAdvertsOwner));
    category = Category.fromParse(object.get<ParseObject>(keyAdvertsCategory));
    status = AdvertsStatus.values[object.get<int>(keyAdvertsStatus)];
  }

  String id;
  List images;
  String title;
  String description;
  Category category;
  Address address;
  num price;
  bool hidePhone;
  AdvertsStatus status = AdvertsStatus.PENDING;
  DateTime created;
  User user;
  int views;
}
