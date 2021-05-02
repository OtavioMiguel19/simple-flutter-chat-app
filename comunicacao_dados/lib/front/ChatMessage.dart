import 'package:comunicacao_dados/models/Mensagem.dart';
import 'package:comunicacao_dados/pages/GraficoPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatMessage extends StatelessWidget {
  ChatMessage(this.mensagem);

  final Mensagem mensagem;
  final User user = FirebaseAuth.instance.currentUser;
  final DateFormat _format = DateFormat('dd/MM/yyyy HH:mm');
  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry _cardRadiusSender = BorderRadius.only(
        topLeft: Radius.circular(15.0),
        bottomLeft: Radius.circular(15.0),
        bottomRight: Radius.circular(15.0));
    BorderRadiusGeometry _cardRadiusReceiver = BorderRadius.only(
        topRight: Radius.circular(15.0),
        bottomRight: Radius.circular(15.0),
        bottomLeft: Radius.circular(15.0));
    bool _isThisUserMessage = mensagem.dono == user.uid;
    double _spacer = MediaQuery.of(context).size.width / 4;
    return Padding(
      padding: EdgeInsets.only(
          top: 10.0,
          right: _isThisUserMessage ? 8.0 : _spacer,
          left: _isThisUserMessage ? _spacer : 8.0),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 0.0,
        color:
            _isThisUserMessage ? Colors.blueAccent[100] : Colors.redAccent[100],
        shape: RoundedRectangleBorder(
            borderRadius:
                _isThisUserMessage ? _cardRadiusSender : _cardRadiusReceiver),
        child: ListTile(
          onLongPress: () {
            _showBottomSheet(context);
          },
          isThreeLine: true,
          title: Text(
            mensagem.mensagemTexto,
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.start,
          ),
          subtitle: Column(
            crossAxisAlignment: _isThisUserMessage
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Text(
                mensagem.donoNome,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.0,
                    fontFamily: 'Titulo',
                    fontWeight: FontWeight.bold),
                textAlign: _isThisUserMessage ? TextAlign.end : TextAlign.start,
              ),
              Text(
                _format.format(mensagem.horario),
                style: TextStyle(color: Colors.black, fontSize: 12.0),
                textAlign: _isThisUserMessage ? TextAlign.end : TextAlign.start,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0))),
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: new Icon(Icons.bar_chart_rounded),
                      title: new Text('Ver gráfico'),
                      onTap: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        GraficoPage(mensagem)))
                          }),
                  ListTile(
                    leading: new Icon(Icons.looks_one_outlined),
                    title: new Text('Ver binário'),
                    onTap: () => {_showBinary(context)},
                  ),
                  ListTile(
                    leading: new Icon(Icons.security),
                    title: new Text('Ver mensagem criptografada'),
                    onTap: () => {_showMensagemCriptografada(context)},
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _showBinary(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Binário da mensagem"),
              content: ListView(
                children: [
                  Text(mensagem.binarios.toString()),
                ],
              ),
            ));
  }

  void _showMensagemCriptografada(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Mensagem criptografada"),
              content: ListView(
                children: [
                  Text(mensagem.mensagemCriptografada),
                ],
              ),
            ));
  }
}
