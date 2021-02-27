import 'package:flutter/material.dart';
import 'package:xlo/components/custom_drawer/custom_drawer.dart';
import 'package:xlo/screens/home/components/search_dialog.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  openSearch(context);
                })
          ],
        ),
      ),
    );
  }

  openSearch(BuildContext context) async {
    final seach = await showDialog(
      context: context,
      builder: (context) => SearchDialog(),
    );
  }
}
