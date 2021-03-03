import 'package:flutter/material.dart';
import 'package:xlo/models/adverts.dart';

class LocationPanel extends StatelessWidget {
  final Adverts adverts;

  LocationPanel(this.adverts);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 18, bottom: 12),
          child: Text(
            'Localização',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('CEP'),
                  SizedBox(height: 12),
                  Text('Municipio'),
                  SizedBox(height: 12),
                  Text('Bairro'),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(adverts.address.cep),
                    SizedBox(height: 12),
                    Text(adverts.address.city.nome),
                    SizedBox(height: 12),
                    Text(adverts.address.district),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
