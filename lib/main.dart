import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:xlo/screens/base/base_screen.dart';
import 'package:xlo/stores/category/category_store.dart';
import 'package:xlo/stores/page/page_store.dart';
import 'package:xlo/stores/user/user_manager_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeParse();
  setupLocators();
  runApp(MyApp());
}

void setupLocators() {
  GetIt.I.registerSingleton(PageStore());
  GetIt.I.registerSingleton(UserManagerStore());
  GetIt.I.registerSingleton(CategoryStore());
}

//Informações da chave do projeto - Back4App

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'XLO',
      theme: ThemeData(
          primaryColor: Colors.purple,
          scaffoldBackgroundColor: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(elevation: 0),
          cursorColor: Colors.orange),
      home: BaseScreen(),
    );
  }
}
