import 'package:comunicacao_dados/pages/HomePage.dart';
import 'package:comunicacao_dados/pages/LoginPage.dart';
import 'package:comunicacao_dados/pages/SplashPage.dart';
import 'package:comunicacao_dados/pages/VerifyPage.dart';
import 'package:comunicacao_dados/routes/AppRoutesEnum.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: AppRoutesEnum.main,
    routes: routes,
    title: 'Chatroom',
    theme: ThemeData(
      fontFamily: 'Texto'
    ),
  ));
}

Map<String, Widget Function(BuildContext)> routes = {
  AppRoutesEnum.main: (context) => SplashPage(),
  AppRoutesEnum.home: (context) => HomePage(),
  AppRoutesEnum.login: (context) => LoginPage(),
  AppRoutesEnum.verify: (context) => VerifyPage(),
};
