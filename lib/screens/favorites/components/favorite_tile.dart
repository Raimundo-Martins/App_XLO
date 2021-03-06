import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo/models/adverts.dart';
import 'package:xlo/helpers/extensions.dart';
import 'package:xlo/screens/adverts/adverts_screen.dart';
import 'package:xlo/stores/favorite/favorite_store.dart';

class FavoriteTile extends StatelessWidget {
  final Adverts adverts;
  final FavoriteStore favoriteStore = GetIt.I<FavoriteStore>();

  FavoriteTile(this.adverts);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AdvertsScreen(adverts),
        ),
      ),
      child: Container(
        height: 135,
        padding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 8,
          child: Row(
            children: [
              SizedBox(
                height: 135,
                width: 127,
                child: CachedNetworkImage(
                  imageUrl: adverts.images.isEmpty
                      ? 'https://static.thenounproject.com/png/194055-200.png'
                      : adverts.images.first,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        adverts.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        adverts.price.formattedMoney(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${adverts.created.formattedDate()} - '
                              '${adverts.address.city.nome} - '
                              '${adverts.address.uf.sigla}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          GestureDetector(
                            child: Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                              size: 20,
                            ),
                            onTap: () => favoriteStore.toggleFavorite(adverts),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
