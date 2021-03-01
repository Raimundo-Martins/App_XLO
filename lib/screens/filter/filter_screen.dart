import 'package:flutter/material.dart';
import 'package:xlo/screens/filter/components/order_by_field.dart';
import 'package:xlo/screens/filter/components/price_range_field.dart';
import 'package:xlo/screens/filter/components/vendor_type_field.dart';
import 'package:xlo/stores/filter/filter_store.dart';

class FilterScreen extends StatelessWidget {
  final filterStore = FilterStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtros'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                OrderByField(filterStore),
                PriceRangeField(filterStore),
                VendorTypeField(filterStore), 
              ],
            ),
          ),
        ),
      ),
    );
  }
}
