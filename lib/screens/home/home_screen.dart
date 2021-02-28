import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo/components/custom_drawer/custom_drawer.dart';
import 'package:xlo/screens/home/components/search_dialog.dart';
import 'package:xlo/screens/home/components/top_bar.dart';
import 'package:xlo/stores/home/home_store.dart';

class HomeScreen extends StatelessWidget {
  final homeStore = GetIt.I<HomeStore>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          title: Observer(
            builder: (context) {
              if (homeStore.search.isEmpty) return Container();
              return GestureDetector(
                onTap: () => openSearch(context),
                child: LayoutBuilder(
                  builder: (context, constraints) => Container(
                    width: constraints.biggest.width,
                    child: Text(homeStore.search, textAlign: TextAlign.center,),
                  ),
                ),
              );
            },
          ),
          actions: [
            Observer(builder: (_) {
              if (homeStore.search.isEmpty)
                return IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      openSearch(context);
                    });
              return IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    homeStore.setSearch('');
                  });
            })
          ],
        ),
        body: Column(
          children: [
            TopBar(),
          ],
        ),
      ),
    );
  }

  openSearch(BuildContext context) async {
    final search = await showDialog(
      context: context,
      builder: (context) => SearchDialog(
        currentSearch: homeStore.search,
      ),
    );
    if (search != null) homeStore.setSearch(search);
  }
}
