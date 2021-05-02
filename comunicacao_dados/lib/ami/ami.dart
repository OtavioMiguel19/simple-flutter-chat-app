import 'dart:typed_data';
import 'dart:core';
import 'dart:convert';
import 'package:graphic/graphic.dart' as graphic;

String encrypt(String texto) {
  var textoEmInteger = utf8.encode(texto);
  List<String> valoresBinarios =
      textoEmInteger.map((int strInt) => strInt.toRadixString(2)).toList();
  var encriptedText = '';

  for (String binario in valoresBinarios) {
    var contador = 0;
    var polaridade = '+';
    var charEmBinario = '';
    for (var char = 0; char < binario.length; char++) {
      if (binario[char] == '0') {
        charEmBinario += '0';
      } else {
        charEmBinario += polaridade;
        polaridade = polarityChange(polaridade);
      }
      contador++;
    }
    if (contador < 8) {
      while (contador < 8) {
        charEmBinario = '0' + charEmBinario;
        contador++;
      }
    }
    encriptedText += charEmBinario;
  }
  return encriptedText;
}

List<String> retornaBinariosEncriptado(String texto) {
  var textoEmInteger = utf8.encode(texto);
  List<String> valoresBinarios =
      textoEmInteger.map((int strInt) => strInt.toRadixString(2)).toList();
  return valoresBinarios;
}

List<int> retornaBinariosDescrypt(String textoCodificado) {
  var textoDecodificado = textoCodificado.replaceAll('+', '1');
  textoDecodificado = textoDecodificado.replaceAll('-', '1');
  // o que eu preciso, inserir numa lista os bytes a cada 8 caracteres
  List<int> list = [];
  var valorBinario = '';

  for (var i = 1; i <= textoDecodificado.length; i++) {
    valorBinario += textoDecodificado[i - 1];
    if (i % 8 == 0 && i != 0) {
      list.add(int.parse(valorBinario, radix: 2));
      valorBinario = '';
    }
  }
  Uint8List bytes = Uint8List.fromList(list);
  return bytes;
}

String decryptAmi(String textoCodificado) {
  var textoDecodificado = textoCodificado.replaceAll('+', '1');
  textoDecodificado = textoDecodificado.replaceAll('-', '1');
  // o que eu preciso, inserir numa lista os bytes a cada 8 caracteres
  List<int> list = [];
  var valorBinario = '';

  for (var i = 1; i <= textoDecodificado.length; i++) {
    valorBinario += textoDecodificado[i - 1];
    if (i % 8 == 0 && i != 0) {
      list.add(int.parse(valorBinario, radix: 2));
      valorBinario = '';
    }
  }
  Uint8List bytes = Uint8List.fromList(list);

  return utf8.decode(bytes).toString();
}

String polarityChange(String polaridade) {
  if (polaridade == '+') {
    polaridade = '-';
  } else {
    polaridade = '+';
  }
  return polaridade;
}

graphic.Chart graphicShow(String textoCodificado) {
  var list = [];

  for (var i = 1; i <= textoCodificado.length; i++) {
    list.add({'byte': i, 'value': textoCodificado[i - 1]});
  }
  var grafico = graphic.Chart(
    data: list,
    scales: {
      'byte': graphic.LinearScale(
        accessor: (map) => map['byte'] as num,
      ),
      'value': graphic.CatScale(
        accessor: (map) => map['value'] as String,
      )
    },
    geoms: [
      graphic.IntervalGeom(
        position: graphic.PositionAttr(field: 'byte*value'),
      )
    ],
    axes: {
      'byte': graphic.Defaults.horizontalAxis,
      'value': graphic.Defaults.verticalAxis,
    },
  );
  return grafico;
}
