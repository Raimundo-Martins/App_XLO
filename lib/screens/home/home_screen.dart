import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo/components/empty_card.dart';
import 'package:xlo/components/custom_drawer/custom_drawer.dart';
import 'package:xlo/screens/home/components/adverts_tile.dart';
import 'package:xlo/screens/home/components/create_adverts_button.dart';
import 'package:xlo/screens/home/components/search_dialog.dart';
import 'package:xlo/screens/home/components/top_bar.dart';
import 'package:xlo/stores/home/home_store.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeStore = GetIt.I<HomeStore>();
  final scrollController = ScrollController();

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
                    child: Text(
                      homeStore.search,
                      textAlign: TextAlign.center,
                    ),
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
            Expanded(
              child: Stack(
                children: [
                  Observer(
                    builder: (context) {
                      if (homeStore.error != null)
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error, color: Colors.white, size: 100),
                              SizedBox(height: 8),
                              Text(
                                'Ocorreu um erro!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        );
                      if (homeStore.showProgress)
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        );
                      if (homeStore.advertsList.isEmpty)
                        return EmptyCard(
                          text: 'Nunhum anúncio encontrado!',
                        );
                      return ListView.builder(
                        controller: scrollController,
                        itemCount: homeStore.itemCount,
                        itemBuilder: (context, index) {
                          if (index < homeStore.advertsList.length)
                            return AdvertsTile(homeStore.advertsList[index]);

                          homeStore.loadingNextPage();
                          return Container(
                            height: 10,
                            child: LinearProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.purple),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  Positioned(
                    bottom: 50,
                    left: 0,
                    right: 0,
                    child: CreateAdvertsButton(scrollController),
                  )
                ],
              ),
            )
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
