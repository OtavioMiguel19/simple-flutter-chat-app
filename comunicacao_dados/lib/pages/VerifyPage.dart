import 'package:comunicacao_dados/routes/AppRoutesEnum.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyPage extends StatelessWidget {
  User user;
  String name;

  String _getUserName(String email) {
    if (email != null && email.isNotEmpty) {
      List<String> _emailParts = email.split('@');
      if (_emailParts.length == 2) {
        return _emailParts[0];
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    user = FirebaseAuth.instance.currentUser;

    if (user.displayName == null || user.displayName.isEmpty) {
      user.updateProfile(displayName: _getUserName(user.email));
    }

    name = user.displayName;
    user = FirebaseAuth.instance.currentUser;

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
              "Bem vindo, $name!",
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontFamily: 'Titulo'),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            "Você ainda não verificou seu endereço de email. Por favor, clique no link na sua Caixa de Entrada e tente novamente.",
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: TextButton(
                onPressed: () async {
                  await user.reload();
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutesEnum.main, (route) => false);
                },
                child: Text(
                  "Já verifiquei meu email",
                  style: TextStyle(color: Colors.green),
                )),
          )
        ],
      ),
    ));
  }
}
