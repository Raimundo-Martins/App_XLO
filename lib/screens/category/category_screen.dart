import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo/components/error_box.dart';
import 'package:xlo/models/category.dart';
import 'package:xlo/stores/category/category_store.dart';

class CategoryScreen extends StatelessWidget {
  final Category selected;
  final bool showAll;

  CategoryScreen({this.selected, this.showAll = true});

  final CategoryStore categoryStore = GetIt.I<CategoryStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorias'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.fromLTRB(32, 10, 32, 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          child: Observer(
            builder: (_) {
              if (categoryStore.error != null)
                return ErrorBox(
                  message: categoryStore.error,
                );
              else if (categoryStore.categoryList.isEmpty)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else {
                final categories = showAll
                    ? categoryStore.allCategoryList
                    : categoryStore.categoryList;
                return ListView.separated(
                  itemCount: categories.length,
                  separatorBuilder: (context, index) =>
                      Divider(height: 0.1, color: Colors.grey),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pop(category);
                      },
                      child: Container(
                        height: 50,
                        color: category.id == selected?.id
                            ? Colors.purple.withAlpha(50)
                            : null,
                        alignment: Alignment.center,
                        child: Text(
                          category.description,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: category.id == selected?.id
                                ? FontWeight.bold
                                : null,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
