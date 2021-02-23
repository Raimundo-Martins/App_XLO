import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo/components/error_box.dart';
import 'package:xlo/models/category.dart';
import 'package:xlo/stores/category/category_store.dart';

class CategotyScreen extends StatelessWidget {
  final Category selected;
  final bool showAll;

  CategotyScreen({this.selected, this.showAll = true});

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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [],
              );
            },
          ),
        ),
      ),
    );
  }
}
