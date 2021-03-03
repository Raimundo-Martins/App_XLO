import 'package:flutter/material.dart';
import 'package:xlo/models/adverts.dart';
import 'package:xlo/helpers/extensions.dart';

class MainPanel extends StatelessWidget {
  final Adverts adverts;

  MainPanel(this.adverts);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 24, bottom: 14),
          child: Text(
            adverts.price.formattedMoney(),
            style: TextStyle(
              fontSize: 34,
              letterSpacing: 2.8,
              fontWeight: FontWeight.w300,
              color: Colors.grey[800],
            ),
          ),
        ),
        Text(
          adverts.title,
          style: TextStyle(
            fontSize: 18,
            letterSpacing: 1,
            fontWeight: FontWeight.w400,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 18),
          child: Text(
            'Publicado em ${adverts.created.formattedDate()}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    );
  }
}
