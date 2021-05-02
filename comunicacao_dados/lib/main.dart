import 'package:comunicacao_dados/pages/HomePage.dart';
import 'package:comunicacao_dados/routes/AppRoutesEnum.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: AppRoutesEnum.main,
      routes: routes,
      title: 'Chatroom',
    )
  );
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _runStartSettings();
    return Container();
  }

  void _runStartSettings() async {
    await Firebase.initializeApp();
  }
}


Map<String, Widget Function(BuildContext)> routes = {
    AppRoutesEnum.main: (context) => HomePage(),
    // AppRoutesEnum.home: (context) => Home(),
    // AppRoutesEnum.login: (context) => LoginPage(),
    // AppRoutesEnum.verify: (context) => VerifyPage(),
  };