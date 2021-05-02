import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comunicacao_dados/ami/ami.dart';

class Mensagem {
  String dono;
  String donoNome;
  String mensagemTexto;
  String mensagemCriptografada;
  List<String> binarios;
  DateTime horario;
  DocumentReference reference;

  Mensagem(
      {this.dono,
      this.donoNome,
      this.horario,
      this.binarios,
      this.mensagemCriptografada,
      this.mensagemTexto,
      this.reference});

  Mensagem.fromMap(Map<String, dynamic> map, {this.reference})
      : dono = decryptAmi(map['dono']),
        donoNome = decryptAmi(map['donoNome']),
        binarios = retornaBinariosDescrypt(map['mensagemCriptografada']),
        mensagemTexto = decryptAmi(map['mensagemCriptografada']),
        mensagemCriptografada = map['mensagemCriptografada'],
        horario = (map['horario'] as Timestamp).toDate();

  Map toMap() {
    Map<String, dynamic> map = Map();
    map['dono'] = dono;
    map['donoNome'] = donoNome;
    map['mensagemCriptografada'] = mensagemCriptografada;
    map['horario'] = horario;
    return map;
  }

  Mensagem.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
