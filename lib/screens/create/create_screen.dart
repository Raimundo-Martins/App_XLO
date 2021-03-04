import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo/components/custom_drawer/custom_drawer.dart';
import 'package:xlo/components/error_box.dart';
import 'package:xlo/models/adverts.dart';
import 'package:xlo/screens/create/components/category_field.dart';
import 'package:xlo/screens/create/components/cep_field.dart';
import 'package:xlo/screens/create/components/hide_phone_field.dart';
import 'package:xlo/screens/create/components/images_field.dart';
import 'package:xlo/stores/create/create_store.dart';
import 'package:xlo/stores/page/page_store.dart';

class CreateScreen extends StatefulWidget {
  final Adverts adverts;

  CreateScreen({this.adverts});

  @override
  _CreateScreenState createState() => _CreateScreenState(adverts);
}

class _CreateScreenState extends State<CreateScreen> {
  _CreateScreenState(Adverts adverts)
      : editing = adverts != null,
        createStore = CreateStore(adverts ?? Adverts());

  final CreateStore createStore;
  bool editing;

  @override
  void initState() {
    super.initState();
    when((_) => createStore.savedAdverts, () {
      GetIt.I<PageStore>().setPage(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _labelStyle = TextStyle(
        fontWeight: FontWeight.w800, color: Colors.grey, fontSize: 18);
    final _contentPadding = EdgeInsets.fromLTRB(16, 10, 12, 10);

    return Scaffold(
      drawer: editing ? null : CustomDrawer(),
      appBar: AppBar(
        title: Text(editing ? 'Editar Anúncios' : 'Criar Anúncios'),
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
            child: Observer(
              builder: (context) {
                if (createStore.loading)
                  return Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          'Salvando anúncio!',
                          style: TextStyle(fontSize: 18, color: Colors.purple),
                        ),
                        SizedBox(height: 16),
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.purple),
                        )
                      ],
                    ),
                  );
                else
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ImagesField(createStore),
                      Observer(builder: (_) {
                        return TextFormField(
                          initialValue: createStore.title,
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
                          initialValue: createStore.description,
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
                          initialValue: createStore.priceText,
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
                        return ErrorBox(message: createStore.error);
                      }),
                      Observer(builder: (_) {
                        return SizedBox(
                          height: 50,
                          child: GestureDetector(
                            onTap: createStore.invalidSendPressed,
                            child: RaisedButton(
                              child: Text('Enviar',
                                  style: TextStyle(fontSize: 18)),
                              textColor: Colors.white,
                              color: Colors.orange,
                              disabledColor: Colors.orange.withAlpha(120),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              onPressed: createStore.sendPressed,
                            ),
                          ),
                        );
                      })
                    ],
                  );
              },
            ),
          ),
        ),
      ),
    );
  }
}
