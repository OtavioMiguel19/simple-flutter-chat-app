import 'dart:async';

import 'package:comunicacao_dados/routes/AppRoutesEnum.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  bool _isValidForm = false;
  bool _isValidEmail = false;
  bool _isValidPassword = false;
  bool _isPasswordWrong = false;
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String _getUserName() {
    if (_controllerEmail.text != null && _controllerEmail.text.isNotEmpty) {
      List<String> _emailParts = _controllerEmail.text.split('@');
      if (_emailParts.length == 2) {
        return _emailParts[0];
      }
    }
    return '';
  }

  bool _isEmailValid(String _emailAddress) {
    if (_emailAddress == null || _emailAddress.isEmpty) {
      return false;
    }
    List<String> _emailParts = _emailAddress.split('@');
    if (_emailParts.length != 2) {
      return false;
    }

    if (_emailParts[1].contains('utfpr')) {
      return true;
    }
    return false;
  }

  bool _isPasswordValid(String _password) {
    if (_password == null || _password.isEmpty) {
      return false;
    }
    return _password.length > 5;
  }

  void _toggleIncorrectPassword() {
    setState(() {
      _isPasswordWrong = !_isPasswordWrong;
    });
  }

  void _fazerLogin() async {
    if (_isValidForm) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _controllerEmail.text, password: _controllerSenha.text);
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutesEnum.main, (route) => false);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          _fazerRegistro();
        } else if (e.code == 'wrong-password') {
          _toggleIncorrectPassword();
          Timer(Duration(seconds: 2), () {
            _toggleIncorrectPassword();
          });
        }
      }
    }
  }

  void _fazerRegistro() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerSenha.text);

      User user = FirebaseAuth.instance.currentUser;
      user.updateProfile(displayName: _getUserName());
      await user.sendEmailVerification();

      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutesEnum.main, (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    _isValidForm = _isValidEmail && _isValidPassword;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
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
                    "Registre-se com seu email da UTFPR para ter acesso ao aplicativo.",
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        primaryColor:
                            _isValidPassword ? Colors.green : Colors.orange,
                      ),
                      child: TextField(
                        onChanged: (text) {
                          setState(() {
                            _isValidEmail = _isEmailValid(text);
                          });
                        },
                        controller: _controllerEmail,
                        decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: _isValidEmail
                                    ? Colors.green
                                    : Colors.orange),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: _isValidEmail
                                    ? Colors.green
                                    : Colors.black),
                          ),
                          labelText: 'Email',
                          hintText: 'Apenas email da UTFPR',
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        primaryColor:
                            _isValidPassword ? Colors.green : Colors.orange,
                      ),
                      child: TextField(
                        onChanged: (text) {
                          setState(() {
                            _isValidPassword = _isPasswordValid(text);
                          });
                        },
                        controller: _controllerSenha,
                        decoration: new InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: _isValidPassword
                                      ? Colors.green
                                      : Colors.orange),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: _isValidPassword
                                      ? Colors.green
                                      : Colors.black),
                            ),
                            labelText: 'Senha',
                            hintText: 'Ao menos 6 caracteres',
                            suffixIcon: IconButton(
                                onPressed: _toggle,
                                icon: _obscureText
                                    ? Icon(Icons.visibility_rounded)
                                    : Icon(Icons.visibility_off_rounded))),
                        keyboardType: TextInputType.text,
                        enableSuggestions: false,
                        autocorrect: false,
                        obscureText: _obscureText,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            child: InkWell(
              onTap: _isValidForm ? _fazerLogin : null,
              child: Container(
                color: _isValidForm
                    ? (_isPasswordWrong ? Colors.red : Colors.green)
                    : Colors.orange,
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                child: Center(
                  child: Text(
                    _isValidForm
                        ? (_isPasswordWrong ? 'Senha incorreta!' : 'Entrar')
                        : 'Preencha o formulário',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            bottom: 0.0,
          )
        ],
      ),
    );
  }
}
