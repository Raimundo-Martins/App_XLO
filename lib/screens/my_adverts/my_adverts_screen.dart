import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo/components/empty_card.dart';
import 'package:xlo/screens/my_adverts/components/active_tile.dart';
import 'package:xlo/screens/my_adverts/components/pending_tile.dart';
import 'package:xlo/screens/my_adverts/components/sold_tile.dart';
import 'package:xlo/stores/my_adverts/my_adverts_store.dart';

class MyAdvertsScreen extends StatefulWidget {
  final initialPage;

  MyAdvertsScreen({this.initialPage = 0});

  @override
  _MyAdvertsScreenState createState() => _MyAdvertsScreenState();
}

class _MyAdvertsScreenState extends State<MyAdvertsScreen>
    with SingleTickerProviderStateMixin {
  final myAdvertsStore = MyAdvertsStore();

  TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController =
        TabController(length: 3, vsync: this, initialIndex: widget.initialPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Anúncios'),
        centerTitle: true,
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(child: Text('ATIVOS')),
            Tab(child: Text('PENDENTES')),
            Tab(child: Text('VENDIDOS')),
          ],
        ),
      ),
      body: Observer(
        builder: (_) {
          if (myAdvertsStore.loading)
            Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            );
          return TabBarView(
            controller: tabController,
            children: [
              Observer(
                builder: (_) {
                  if (myAdvertsStore.activeAdverts.isEmpty)
                    return EmptyCard(
                      text: 'Você não possui nenhum anúncio ativo!',
                    );
                  return ListView.builder(
                    itemCount: myAdvertsStore.activeAdverts.length,
                    itemBuilder: (context, index) => ActiveTile(
                      myAdvertsStore.activeAdverts[index],
                      myAdvertsStore,
                    ),
                  );
                },
              ),
              Observer(
                builder: (_) {
                  if (myAdvertsStore.pendingAdverts.isEmpty) return EmptyCard(
                      text: 'Você não possui nenhum anúncio pendente!',
                    );
                  return ListView.builder(
                    itemCount: myAdvertsStore.pendingAdverts.length,
                    itemBuilder: (context, index) => PendingTile(
                      myAdvertsStore.pendingAdverts[index],
                    ),
                  );
                },
              ),
              Observer(
                builder: (_) {
                  if (myAdvertsStore.soldAdverts.isEmpty) return EmptyCard(
                      text: 'Você não possui nenhum anúncio vendido!',
                    );
                  return ListView.builder(
                    itemCount: myAdvertsStore.soldAdverts.length,
                    itemBuilder: (context, index) => SoldTile(
                      myAdvertsStore.soldAdverts[index],
                      myAdvertsStore,
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
