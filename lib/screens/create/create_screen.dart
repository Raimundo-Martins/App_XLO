import 'package:brasil_fields/formatter/real_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlo/components/custom_drawer/custom_drawer.dart';

class CreateScreen extends StatelessWidget {
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
      body: Card(
        margin: EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Título *',
                labelStyle: _labelStyle,
                contentPadding: _contentPadding,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Descrição *',
                labelStyle: _labelStyle,
                contentPadding: _contentPadding,
              ),
              maxLength: null,
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Preço *',
                  labelStyle: _labelStyle,
                  contentPadding: _contentPadding,
                  prefixText: 'R\$ '),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                RealInputFormatter(centavos: true)
              ],
            ),
          ],
        ),
      ),
    );
  }
}