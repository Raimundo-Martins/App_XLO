import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:xlo/stores/account/edit_account_store.dart';
import 'package:xlo/stores/page/page_store.dart';

class EditAccountScreen extends StatelessWidget {
  final editAccountStore = EditAccountStore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editar Conta'), centerTitle: true),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Observer(builder: (_) {
                    return IgnorePointer(
                      ignoring: editAccountStore.loading,
                      child: LayoutBuilder(
                        builder: (context, constraints) => ToggleSwitch(
                          minWidth: constraints.biggest.width / 2.01,
                          labels: ['Particular', 'Profissional'],
                          cornerRadius: 20,
                          activeBgColor: Colors.purple,
                          activeFgColor: Colors.white,
                          inactiveBgColor: Colors.grey,
                          inactiveFgColor: Colors.white,
                          initialLabelIndex: editAccountStore.userType.index,
                          onToggle: editAccountStore.setUserType,
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: 16),
                  Observer(builder: (_) {
                    return TextFormField(
                      initialValue: editAccountStore.name,
                      enabled: !editAccountStore.loading,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        labelText: 'Nome *',
                        errorText: editAccountStore.nameError,
                      ),
                      onChanged: editAccountStore.setName,
                    );
                  }),
                  SizedBox(height: 8),
                  Observer(builder: (_) {
                    return TextFormField(
                      initialValue: editAccountStore.phone,
                      enabled: !editAccountStore.loading,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        labelText: 'Telefone *',
                        errorText: editAccountStore.phoneError,
                      ),
                      onChanged: editAccountStore.setPhone,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        TelefoneInputFormatter()
                      ],
                    );
                  }),
                  SizedBox(height: 8),
                  Observer(builder: (_) {
                    return TextFormField(
                      enabled: !editAccountStore.loading,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        labelText: 'Nova Senha',
                      ),
                      obscureText: true,
                      onChanged: editAccountStore.setSenha1,
                    );
                  }),
                  SizedBox(height: 8),
                  Observer(builder: (_) {
                    return TextFormField(
                      enabled: !editAccountStore.loading,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        labelText: 'Confirmar Nova Senha *',
                        errorText: editAccountStore.senhaError,
                      ),
                      obscureText: true,
                      onChanged: editAccountStore.setSenha2,
                    );
                  }),
                  SizedBox(height: 16),
                  Observer(builder: (_) {
                    return SizedBox(
                      height: 50,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: Colors.orange,
                        disabledColor: Colors.orange.withAlpha(120),
                        elevation: 0,
                        child: editAccountStore.loading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : Text('SALVAR'),
                        textColor: Colors.white,
                        onPressed: editAccountStore.savePressed,
                      ),
                    );
                  }),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 50,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      color: Colors.red,
                      elevation: 0,
                      child: Text('SAIR'),
                      textColor: Colors.white,
                      onPressed: () {
                        editAccountStore.logout();
                        GetIt.I<PageStore>().setPage(0);
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
