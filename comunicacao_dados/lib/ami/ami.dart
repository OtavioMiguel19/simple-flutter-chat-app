import 'dart:math';
import 'dart:typed_data';
import 'dart:core';

import 'package:binary_codec/binary_codec.dart';

String encrypt(String texto) {
  var textoEmBinario = binaryCodec.encode(texto);
  var textoDecoficado = binaryCodec.decode(textoEmBinario);
  if (texto.toString() != textoDecoficado.toString()) {
    /// They should be the same;
    throw new Exception('this shit does not work at all');
  }
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
