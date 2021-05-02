import 'dart:math';
import 'dart:typed_data';
import 'dart:core';
import 'dart:convert';

import 'package:binary_codec/binary_codec.dart';

String encrypt(String texto) {
  var textoEmInteger = utf8.encode(texto);
  List<String> valoresBinarios =
      textoEmInteger.map((int strInt) => strInt.toRadixString(2)).toList();
  var encriptedText = '';

  for (String binario in valoresBinarios) {
    var polaridade = '+';
    for (var char = 0; char < binario.length; char++) {
      binario[char];
      if (binario[char] == '0') {
        encriptedText += '0';
      } else {
        encriptedText += polaridade;
        polaridade = polarityChange(polaridade);
      }
    }
  }
  // var textoDecodificado = encriptedText.replaceAll('+', '1');
  // textoDecodificado = textoDecodificado.replaceAll('-', '1');
  // List<int> list = textoDecodificado.codeUnits;
  // Uint8List bytes = Uint8List.fromList(list);
  // if (texto.toString() != textoDecoficado.toString()) {
  //   /// They should be the same;
  //   throw new Exception('this shit does not work at all');
  // }
  return encriptedText;
}

String decryptAmi(String textoCodificado) {
  var textoDecodificado = textoCodificado.replaceAll('+', '1');
  textoDecodificado = textoDecodificado.replaceAll('-', '1');
  return textoDecodificado;
}

String polarityChange(String polaridade) {
  if (polaridade == '+') {
    polaridade = '-';
  } else {
    polaridade = '+';
  }
  return polaridade;
}
// def encrypt(str):
//     byte_list = []
//     for i in str:
//         byte_list.append(format(ord(i), '08b'))
//     encriptedArray = []
//     polarity = '+'
//     for binary in byte_list:
//         encriptedChar =''
//         encriptedCharToGraph = []
//         for digit in binary:
//             if digit == '0':
//                 encriptedChar += '0'
//                 encriptedCharToGraph.append(0)
//             elif digit == '1':
//                 encriptedChar += polarity
//                 if polarity =='+':
//                     encriptedCharToGraph.append(1)
//                 else:
//                     encriptedCharToGraph.append(-1)
//                 polarity = polarityChange(polarity)
//         # descomente essa linha pra plotar cada um dos caracteres no grafico
//         # não consegui fazer ainda o y ficar com os valores '-' '0' e '+' apenas

//         # x = np.array( [ y for y in range( len(encriptedCharToGraph) ) ])
//         # y = np.array(encriptedCharToGraph)
//         # plt.scatter(x, y)
//         # plt.title('String codificada em AMI')
//         # plt.show()
//         encriptedArray.append(encriptedChar)

//     stringCodificada = ''.join(encriptedArray)
//     return stringCodificada

// def decrypt(encryptedArray):

//     arrayDecodificada = []
//     for binary in encryptedArray:
//         str= binary.replace("+","1")
//         str= str.replace("-","1")
//         character = BinaryToAscii(str)
//         arrayDecodificada.append(character)
//     stringDecodificada = ''.join(arrayDecodificada)
//     return stringDecodificada

// def BinaryToAscii(binary):
//     n = int(binary, 2)
//     return chr(n)

// def polarityChange(polarity):
//     if polarity == '+':
//         polarity ='-'
//     else:
//         polarity = '+'
//     return polarity
