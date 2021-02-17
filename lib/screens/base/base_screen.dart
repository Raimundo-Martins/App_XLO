import 'package:flutter/material.dart';
import 'package:xlo/screens/home/home_screen.dart';

class BaseScreen extends StatelessWidget {
  final pageContoller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageContoller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(),
          Container(),
          Container(),
          Container(),
          Container(),
        ],
      ),
    );
  }
}
