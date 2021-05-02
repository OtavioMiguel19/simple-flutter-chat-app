import 'dart:typed_data';
import 'dart:core';
import 'dart:convert';

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
