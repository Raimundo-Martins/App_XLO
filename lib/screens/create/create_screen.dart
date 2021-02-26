import 'package:brasil_fields/formatter/real_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo/components/custom_drawer/custom_drawer.dart';
import 'package:xlo/screens/create/components/category_field.dart';
import 'package:xlo/screens/create/components/cep_field.dart';
import 'package:xlo/screens/create/components/hide_phone_field.dart';
import 'package:xlo/screens/create/components/images_field.dart';
import 'package:xlo/stores/create/create_store.dart';

class CreateScreen extends StatelessWidget {
  final createStore = CreateStore();

  @override
  Widget build(BuildContext context) {
    final _labelStyle = TextStyle(
        fontWeight: FontWeight.w800, color: Colors.grey, fontSize: 18);
    final _contentPadding = EdgeInsets.fromLTRB(16, 10, 12, 10);

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Criar anúncios'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Card(
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.symmetric(horizontal: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ImagesField(createStore),
                Observer(builder: (_) {
                  return TextFormField(
                    onChanged: createStore.setTitle,
                    decoration: InputDecoration(
                      labelText: 'Título *',
                      labelStyle: _labelStyle,
                      contentPadding: _contentPadding,
                      errorText: createStore.titleError,
                    ),
                  );
                }),
                Observer(builder: (_) {
                  return TextFormField(
                    onChanged: createStore.setDescription,
                    decoration: InputDecoration(
                      labelText: 'Descrição *',
                      labelStyle: _labelStyle,
                      contentPadding: _contentPadding,
                      errorText: createStore.descriptionError,
                    ),
                    maxLength: null,
                  );
                }),
                CategoryField(createStore),
                CepField(createStore),
                Observer(builder: (_) {
                  return TextFormField(
                    onChanged: createStore.setPrice,
                    decoration: InputDecoration(
                        errorText: createStore.priceError,
                        labelText: 'Preço *',
                        labelStyle: _labelStyle,
                        contentPadding: _contentPadding,
                        prefixText: 'R\$ '),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      RealInputFormatter(centavos: true)
                    ],
                  );
                }),
                HidePhoneField(createStore),
                Observer(builder: (_) {
                  return SizedBox(
                    height: 50,
                    child: GestureDetector(
                      onTap: createStore.invalidSendPressed,
                      child: RaisedButton(
                        child: Text('Enviar', style: TextStyle(fontSize: 18)),
                        textColor: Colors.white,
                        color: Colors.orange,
                        disabledColor: Colors.orange.withAlpha(120),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: createStore.sendPressed,
                      ),
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
