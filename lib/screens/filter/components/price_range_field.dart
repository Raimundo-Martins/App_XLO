import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo/screens/filter/components/price_field.dart';
import 'package:xlo/screens/filter/components/section_title.dart';
import 'package:xlo/stores/filter/filter_store.dart';

class PriceRangeField extends StatelessWidget {
  PriceRangeField(this.filterStore);

  final FilterStore filterStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle('Preço'),
        Row(
          children: [
            PriceField(
              label: 'Min',
              onChange: filterStore.setMin,
              initialValue: filterStore.minPrice,
            ),
            SizedBox(width: 16),
            PriceField(
              label: 'Max',
              onChange: filterStore.setMax,
              initialValue: filterStore.maxPrice,
            ),
          ],
        ),
        Observer(builder: (_) {
          if (filterStore.priceError != null)
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                filterStore.priceError,
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            );
          return Container();
        })
      ],
    );
  }
}
