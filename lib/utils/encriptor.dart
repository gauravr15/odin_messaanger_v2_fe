import 'package:encrypt/encrypt.dart';

class AESUtils {
  static final IV iv = IV.fromUtf8('0123456789abcdef'); // Sample IV value

  String encrypt(String plainText, String key) {
    final encrypter = Encrypter(AES(Key.fromUtf8(key), mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  String decrypt(String encryptedText, String key) {
    final encrypter = Encrypter(AES(Key.fromUtf8(key), mode: AESMode.cbc));
    final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
    return decrypted;
  }
}

void main() {
  final AESUtils aesUtils = AESUtils();

  // Example usage
  final encryptedText =
      aesUtils.encrypt('Hello, World!', 'your_encryption_key');
  print('Encrypted Text: $encryptedText');

  final decryptedText = aesUtils.decrypt(encryptedText, 'your_encryption_key');
  print('Decrypted Text: $decryptedText');
}
