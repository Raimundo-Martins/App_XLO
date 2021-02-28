import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo/screens/category/category_screen.dart';
import 'package:xlo/screens/filter/filter_screen.dart';
import 'package:xlo/screens/home/components/bar_button.dart';
import 'package:xlo/stores/home/home_store.dart';

class TopBar extends StatelessWidget {
  final homeStore = GetIt.I<HomeStore>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Observer(
          builder: (_) {
            return BarButton(
              label: homeStore.category?.description ?? 'Categorias',
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[400])),
              ),
              onTap: () async {
                final category = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CategoryScreen(
                      showAll: true,
                      selected: homeStore.category,
                    ),
                  ),
                );
                if (category != null) homeStore.setCategory(category);
              },
            );
          },
        ),
        BarButton(
          label: 'Filtros',
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey[400]),
              left: BorderSide(color: Colors.grey[400]),
            ),
          ),
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => FilterScreen()));
          },
        ),
      ],
    );
  }
}
