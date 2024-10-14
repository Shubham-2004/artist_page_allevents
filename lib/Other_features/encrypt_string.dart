import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:pointycastle/api.dart';
import 'package:pointycastle/key_generators/rsa_key_generator.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:pointycastle/random/fortuna_random.dart';

class Encrypt extends StatefulWidget {
  const Encrypt({super.key});

  @override
  State<Encrypt> createState() => _EncryptState();
}

class _EncryptState extends State<Encrypt> {
  TextEditingController textEditingController = TextEditingController();
  String encryptedText = '';
  String decryptedText = '';
  encrypt.Encrypter? encrypter;
  RSAPublicKey? publicKey;
  RSAPrivateKey? privateKey;
  bool isLoading = true;
  String encryptionKeyString = '';
  String decryptionKeyString = '';

  @override
  void initState() {
    super.initState();
    _generateKeys();
  }

  Future<void> _generateKeys() async {
    try {
      final secureRandom = FortunaRandom();

      secureRandom.seed(KeyParameter(
          Uint8List.fromList(List.generate(32, (index) => index + 1))));
      final keyGen = RSAKeyGenerator();
      final keyGenParams =
          RSAKeyGeneratorParameters(BigInt.from(65537), 2048, 12);
      keyGen.init(ParametersWithRandom(keyGenParams, secureRandom));

      AsymmetricKeyPair<PublicKey, PrivateKey> keyPair =
          keyGen.generateKeyPair();
      publicKey = keyPair.publicKey as RSAPublicKey;
      privateKey = keyPair.privateKey as RSAPrivateKey;

      encrypter = encrypt.Encrypter(
          encrypt.RSA(publicKey: publicKey!, privateKey: privateKey!));
      encryptionKeyString =
          'Modulus: ${publicKey!.modulus}\nExponent: ${publicKey!.exponent}';
      decryptionKeyString =
          'Modulus: ${privateKey!.modulus}\nExponent: ${privateKey!.privateExponent}';

      print('Encryption Key (Public Key): $encryptionKeyString');
      print('Decryption Key (Private Key): $decryptionKeyString');
    } catch (e) {
      print('Error generating keys: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _encryptText() {
    if (encrypter != null) {
      try {
        final encrypted = encrypter!.encrypt(textEditingController.text);
        setState(() {
          encryptedText = encrypted.base64;
          decryptedText = '';
          textEditingController.clear();
        });
      } catch (e) {
        print('Encryption failed: $e');
      }
    }
  }

  void _decryptText() {
    if (encrypter != null && encryptedText.isNotEmpty) {
      try {
        final decrypted = encrypter!.decrypt64(encryptedText);
        setState(() {
          decryptedText = decrypted;
        });
      } catch (e) {
        print('Decryption failed: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('RSA Encryption Example'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: textEditingController,
                decoration: const InputDecoration(
                  labelText: 'Enter text to encrypt',
                ),
              ),
              const SizedBox(height: 20),
              Text('Encrypted Text: $encryptedText'),
              const SizedBox(height: 20),
              Text('Decrypted Text: $decryptedText'),
              const SizedBox(height: 20),
              Text('Encryption Key (Public Key):',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SelectableText(encryptionKeyString),
              const SizedBox(height: 20),
              Text('Decryption Key (Private Key):',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SelectableText(decryptionKeyString),
              const SizedBox(height: 20),
              if (isLoading) const Center(child: CircularProgressIndicator()),
              if (!isLoading)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: _encryptText,
                      child: const Text('Encrypt'),
                    ),
                    ElevatedButton(
                      onPressed: _decryptText,
                      child: const Text('Decrypt'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
