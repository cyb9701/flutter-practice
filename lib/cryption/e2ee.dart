import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:flutteridmemo/database/hive_db.dart';

class E2EE {
  final crypt = new PlatformStringCryptor();
  final key = HiveDB().getKey();

  Future<String> encryptE2EE(String value) async {
    if (value != 'null') {
      final encrypted = await crypt.encrypt(value, key);
      return encrypted;
    } else {
      return null;
    }
  }

  Future<String> decryptE22EE(String encrypted) async {
    try {
      final String decrypted = await crypt.decrypt(encrypted, key);
      return decrypted;
    } on MacMismatchException {
      return null;
      // unable to decrypt (wrong key or forged data)
    }
  }
}
