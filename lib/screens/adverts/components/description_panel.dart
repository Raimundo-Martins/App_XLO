import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:xlo/models/adverts.dart';

class DescriptionPanel extends StatelessWidget {
  final Adverts adverts;

  DescriptionPanel(this.adverts);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 18),
          child: Text(
            'Descrição',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 18),
          child: ReadMoreText(
            adverts.description,
            trimLines: 3,
            trimMode: TrimMode.Line,
            trimCollapsedText: ' Ver descrição completa',
            trimExpandedText: ' ...menos',
            colorClickableText: Colors.purple,
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }
}
