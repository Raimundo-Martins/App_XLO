import 'package:xlo/models/address.dart';
import 'package:xlo/models/category.dart';
import 'package:xlo/models/user.dart';

enum advertsStatus { PENDING, ACTIVE, SOLD, DELETED }

class Adverts {
  String id;
  List images;
  String title;
  String description;
  Category category;
  Address address;
  num price;
  bool hidePhone;
  advertsStatus status = advertsStatus.PENDING;
  DateTime created;
  User user;
  int views;
}
