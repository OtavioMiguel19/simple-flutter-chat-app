import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:comunicacao_dados/routes/RoutesConfigs.dart';

class SplashPage extends StatelessWidget {
  void _runStartSettings() async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
          context, RoutesConfigs.calculateRoute(), (route) => false);
    });
    _runStartSettings();
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: 'welcomeText',
            child: Text(
              "Bem vindo!",
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontFamily: 'Titulo'),
            ),
          ),
          Text(
            "Aguarde. Preparando módulos.",
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          )
        ],
      ),
    ));
  }
}
