import 'dart:convert' as convert;
import 'dart:typed_data';

import 'package:asn1lib/asn1lib.dart';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';

String rsaEncrypt(String rsaPublicKey, String content) {
  final rows = rsaPublicKey.split(RegExp(r'\r\n?|\n'));
  final keyBytes = Uint8List.fromList(convert.base64.decode(rows
      .skipWhile((row) => row.startsWith('-----BEGIN'))
      .takeWhile((row) => !row.startsWith('-----END'))
      .map((row) => row.trim())
      .join('')));

  final asn1Parser = ASN1Parser(keyBytes);
  final asn1sequence = asn1Parser.nextObject() as ASN1Sequence;

  final ASN1Object bitString = asn1sequence.elements[1];
  final bytes = bitString.valueBytes().sublist(1);
  final parser = ASN1Parser(Uint8List.fromList(bytes));
  final asn2sequence = parser.nextObject() as ASN1Sequence;

  final rsaEncrypter = Encrypter(RSA(
      publicKey: RSAPublicKey(
          (asn2sequence.elements[0] as ASN1Integer).valueAsBigInteger!,
          (asn2sequence.elements[1] as ASN1Integer).valueAsBigInteger!)));

  final encrypted1 = rsaEncrypter.encrypt(content);

  return encrypted1.base64;
}
