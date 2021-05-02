import 'package:flutter/material.dart';
import '../ami/ami.dart';
import 'package:graphic/graphic.dart' as graphic;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fala maluco'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: graphicShow(encrypt('textoCodificado')),
      ),
    );
  }
}
