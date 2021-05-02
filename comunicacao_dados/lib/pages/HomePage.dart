import 'package:comunicacao_dados/ami/ami.dart';
import 'package:comunicacao_dados/front/ChatMessage.dart';
import 'package:comunicacao_dados/models/Mensagem.dart';
import 'package:comunicacao_dados/routes/RoutesConfigs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User _user = FirebaseAuth.instance.currentUser;

  TextEditingController _controller = TextEditingController();

  bool _hasMessageToSend = false;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference mensagens =
      FirebaseFirestore.instance.collection('mensagens');

  List<Mensagem> msgs = List<Mensagem>.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    void _enviarMensagem() {
      if (_controller.text != null && _controller.text.isNotEmpty) {
        Mensagem mensagem = Mensagem();
        mensagem.mensagemCriptografada = encrypt(_controller.text);
        mensagem.dono = encrypt(_user.uid);
        mensagem.donoNome = encrypt(_user.displayName);
        mensagem.horario = DateTime.now();

        mensagens.add(mensagem.toMap());
        _controller.clear();
      }
    }

    void _checkIfHasMessageToSend(String text) {
      setState(() {
        _hasMessageToSend = text != null && text.isNotEmpty;
      });
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Olá, ${_user.displayName}',
          style: TextStyle(color: Colors.black, fontFamily: 'Titulo'),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, RoutesConfigs.calculateRoute(), (route) => false);
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: mensagens.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.data.size > 0) {
                  msgs = List<Mensagem>.empty(growable: true);
                  for (DocumentSnapshot data in snapshot.data.docs) {
                    msgs.add(Mensagem.fromSnapshot(data));
                  }
                  msgs.sort((a, b) {
                    if (a.horario.isBefore(b.horario)) {
                      return 1;
                    } else {
                      return -1;
                    }
                  });
                }

                return ListView.builder(
                  reverse: true,
                  itemCount: msgs.length,
                  itemBuilder: (context, index) {
                    Mensagem msg = msgs[index];
                    return ChatMessage(msg);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Center(
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _controller,
                    onChanged: (texto) {
                      _checkIfHasMessageToSend(texto);
                    },
                    minLines: 1,
                    maxLines: 3,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.greenAccent[100],
                        isDense: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide:
                              BorderSide(color: Colors.greenAccent[100]),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide:
                              BorderSide(color: Colors.greenAccent[100]),
                        ),
                        hintText: 'Digite uma mensagem'),
                  )),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      color: _hasMessageToSend ? Colors.green : Colors.black,
                    ),
                    onPressed: _hasMessageToSend ? _enviarMensagem : null,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
