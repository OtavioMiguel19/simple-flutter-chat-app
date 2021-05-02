import 'package:comunicacao_dados/models/Mensagem.dart';
import 'package:flutter/material.dart';

class GraficoPage extends StatelessWidget {
  final Mensagem mensagem;
  GraficoPage(this.mensagem);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Gráfico", style: TextStyle(fontFamily: "Titulo", color: Colors.black),),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,),
          backgroundColor: Colors.white,
          body: Container(),
    );
  }
}
