import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo/models/category.dart';
import 'package:xlo/repositories/parse_errors.dart';
import 'package:xlo/repositories/table_keys.dart';

class CategoryRepository {
  Future<List<Category>> getList() async {
    final queryBuilder = QueryBuilder(ParseObject(KeyCategoryTable))
      ..orderByAscending(KeyCategoryDescription);

    final response = await queryBuilder.query();

    if (response.success) {
      return response.results.map((e) => Category.fromParse(e)).toList();
    } else {
      throw ParseErrors.getDescription(response.error.code);
    }
  }
}