import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:xlo/models/adverts.dart';
import 'package:xlo/screens/adverts/components/bottom_bar.dart';
import 'package:xlo/screens/adverts/components/description_panel.dart';
import 'package:xlo/screens/adverts/components/location_panel.dart';
import 'package:xlo/screens/adverts/components/main_panel.dart';
import 'package:xlo/screens/adverts/components/user_panel.dart';

class AdvertsScreen extends StatelessWidget {
  final Adverts adverts;

  AdvertsScreen(this.adverts);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Anúncios'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                height: 280,
                child: Carousel(
                  images: adverts.images
                      .map((url) => CachedNetworkImageProvider(url))
                      .toList(),
                  dotSize: 5,
                  dotBgColor: Colors.transparent,
                  dotColor: Colors.orange,
                  autoplay: false,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MainPanel(adverts),
                    Divider(color: Colors.grey[500]),
                    DescriptionPanel(adverts),
                    Divider(color: Colors.grey[500]),
                    LocationPanel(adverts),
                    Divider(color: Colors.grey[500]),
                    UserPanel(adverts),
                    SizedBox(
                      height:
                          adverts.status == AdvertsStatus.PENDING ? 16 : 120,
                    )
                  ],
                ),
              ),
            ],
          ),
          BottomBar(adverts),
        ],
      ),
    );
  }
}
