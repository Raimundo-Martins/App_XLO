import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo/screens/filter/components/order_by_field.dart';
import 'package:xlo/screens/filter/components/price_range_field.dart';
import 'package:xlo/screens/filter/components/vendor_type_field.dart';
import 'package:xlo/stores/home/home_store.dart';

class FilterScreen extends StatelessWidget {
  final filterStore = GetIt.I<HomeStore>().filterStore.clone;

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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                OrderByField(filterStore),
                PriceRangeField(filterStore),
                VendorTypeField(filterStore),
                Observer(builder: (_) {
                  return Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      color: Colors.orange,
                      textColor: Colors.white,
                      disabledColor: Colors.orange.withAlpha(120),
                      child: Text(
                        'FILTRAR',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: filterStore.isFormValid
                          ? () {
                              filterStore.save();
                              Navigator.of(context).pop();
                            }
                          : null,
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
