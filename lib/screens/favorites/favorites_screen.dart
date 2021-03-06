import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo/components/custom_drawer/custom_drawer.dart';
import 'package:xlo/components/empty_card.dart';
import 'package:xlo/screens/favorites/components/favorite_tile.dart';
import 'package:xlo/stores/favorite/favorite_store.dart';

class FavoritesScreen extends StatelessWidget {
  final bool hideDrawer;
  final FavoriteStore favoriteStore = GetIt.I<FavoriteStore>();

  FavoritesScreen({this.hideDrawer = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
        centerTitle: true,
      ),
      drawer: hideDrawer ? null : CustomDrawer(),
      body: Observer(
        builder: (context) {
          if (favoriteStore.favoriteList.isEmpty)
            return EmptyCard(text: 'Nenhum anúncio favoritado!');
          return ListView.builder(
            padding: EdgeInsets.all(2),
            itemCount: favoriteStore.favoriteList.length,
            itemBuilder: (context, index) =>
                FavoriteTile(favoriteStore.favoriteList[index]),
          );
        },
      ),
    );
  }
}
