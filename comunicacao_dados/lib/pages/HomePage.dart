import 'package:flutter/material.dart';
import '../ami/ami.dart';

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
        child: Text(encrypt('ã')),
      ),
    );
  }
}
