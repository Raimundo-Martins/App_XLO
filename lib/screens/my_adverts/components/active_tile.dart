import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xlo/models/adverts.dart';
import 'package:xlo/helpers/extensions.dart';
import 'package:xlo/screens/adverts/adverts_screen.dart';
import 'package:xlo/screens/create/create_screen.dart';

class ActiveTile extends StatelessWidget {
  ActiveTile(this.adverts);

  final Adverts adverts;

  final List<MenuChoise> choices = [
    MenuChoise(index: 0, title: 'EDITAR', iconData: Icons.edit),
    MenuChoise(index: 1, title: 'VENDIDOS', iconData: Icons.thumb_up),
    MenuChoise(index: 2, title: 'EXCLUIR', iconData: Icons.delete),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AdvertsScreen(adverts),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        child: Container(
          height: 80,
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  imageUrl: adverts.images.isEmpty
                      ? 'https://static.thenounproject.com/png/194055-200.png'
                      : adverts.images.first,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        adverts.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        adverts.price.formattedMoney(),
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.purple),
                      ),
                      Text(
                        '${adverts.views} visualizações',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[900],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  PopupMenuButton<MenuChoise>(
                    onSelected: (choice) {
                      switch (choice.index) {
                        case 0:
                          editAdverts(context);
                          break;
                        case 1:
                          break;
                        case 2:
                          break;
                        default:
                      }
                    },
                    icon: Icon(Icons.more_vert, size: 25),
                    itemBuilder: (context) {
                      return choices
                          .map(
                            (choice) => PopupMenuItem<MenuChoise>(
                              value: choice,
                              child: Row(
                                children: [
                                  Icon(
                                    choice.iconData,
                                    size: 20,
                                    color: Colors.purple,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    choice.title,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.purple,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                          .toList();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> editAdverts(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreateScreen(adverts: adverts),
      ),
    );
  }
}

class MenuChoise {
  MenuChoise({this.index, this.title, this.iconData});

  final int index;
  final String title;
  final IconData iconData;
}
