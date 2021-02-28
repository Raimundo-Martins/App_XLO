import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo/screens/filter/components/section_title.dart';
import 'package:xlo/stores/filter/filter_store.dart';

class OrderByField extends StatelessWidget {
  OrderByField(this.filterStore);

  final FilterStore filterStore;

  @override
  Widget build(BuildContext context) {
    Widget buildOption(String title, OrderBy option) {
      return GestureDetector(
        onTap: () {
          filterStore.setOrderBy(option);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: filterStore.orderBy == option
                ? Colors.purple
                : Colors.transparent,
            border: Border.all(color: Colors.purple),
          ),
          child: Text(
            title,
            style: TextStyle(
              color:
                  filterStore.orderBy == option ? Colors.white : Colors.black,
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle('Ordenar por'),
        Observer(builder: (_) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildOption('Data', OrderBy.DATE),
              SizedBox(width: 16),
              buildOption('Preço', OrderBy.PRICE),
            ],
          );
        })
      ],
    );
  }
}
