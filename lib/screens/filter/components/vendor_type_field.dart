import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo/screens/filter/components/section_title.dart';
import 'package:xlo/stores/filter/filter_store.dart';

class VendorTypeField extends StatelessWidget {
  VendorTypeField(this.filterStore);

  final FilterStore filterStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SectionTitle('Tipo de anúncio'),
        Observer(
          builder: (_) {
            return Wrap(
              runSpacing: 5,
              children: [
                GestureDetector(
                  onTap: () {
                    if (filterStore.isTypeParticular) {
                      if (filterStore.isTypeProfissional)
                        filterStore.resetVendorType(VENDOR_TYPE_PARTICULAR);
                      else
                        filterStore.selectVendorType(VENDOR_TYPE_PROFISSIONAL);
                    } else
                      filterStore.setVendorType(VENDOR_TYPE_PARTICULAR);
                  },
                  child: Container(
                    height: 50,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: filterStore.isTypeParticular
                          ? Colors.purple
                          : Colors.transparent,
                      border: Border.all(color: Colors.purple),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Particular',
                      style: TextStyle(
                        color: filterStore.isTypeParticular
                            ? Colors.white
                            : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    if (filterStore.isTypeProfissional) {
                      if (filterStore.isTypeParticular)
                        filterStore.resetVendorType(VENDOR_TYPE_PROFISSIONAL);
                      else
                        filterStore.selectVendorType(VENDOR_TYPE_PARTICULAR);
                    } else
                      filterStore.setVendorType(VENDOR_TYPE_PROFISSIONAL);
                  },
                  child: Container(
                    height: 50,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: filterStore.isTypeProfissional
                          ? Colors.purple
                          : Colors.transparent,
                      border: Border.all(color: Colors.purple),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Profissional',
                      style: TextStyle(
                        color: filterStore.isTypeProfissional
                            ? Colors.white
                            : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        )
      ],
    );
  }
}
