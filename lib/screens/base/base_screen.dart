import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:xlo/screens/account/account_screen.dart';
import 'package:xlo/screens/create/create_screen.dart';
import 'package:xlo/screens/favorites/favorites_screen.dart';
import 'package:xlo/screens/home/home_screen.dart';
import 'package:xlo/screens/offline/offline_screen.dart';
import 'package:xlo/stores/connectivity/connectivity_store.dart';
import 'package:xlo/stores/page/page_store.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageController pageController = PageController();

  final PageStore pageStore = GetIt.I<PageStore>();
  final ConnectivityStore connectivityStore = GetIt.I<ConnectivityStore>();

  @override
  void initState() {
    super.initState();

    reaction((_) => pageStore.page, (page) => pageController.jumpToPage(page));

    autorun((_) {
      if (!connectivityStore.connected)
        Future.delayed(Duration(milliseconds: 50)).then((value) {
          showDialog(
            context: context,
            builder: (context) => OfflineScreen(),
          );
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(),
          CreateScreen(),
          Container(),
          FavoritesScreen(),
          AccountScreen(),
        ],
      ),
    );
  }
}
