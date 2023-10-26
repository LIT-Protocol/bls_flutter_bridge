import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'ffi.dart' if (dart.library.html) 'ffi_web.dart';
import 'dart:typed_data';
import 'package:convert/convert.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '🧪 Manual Tests | Lit Flutter SDK'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

extension<L, R> on (FutureOr<L>, FutureOr<R>) {
  // A convenience method enabled by Dart 3, which will be useful later.
  Future<(L, R)> join() async {
    final fut =
        await Future.wait([Future.value(this.$1), Future.value(this.$2)]);
    return (fut[0] as L, fut[1] as R);
  }
}

class LitButton extends StatefulWidget {
  final String buttonText;
  final Future<dynamic> Function() callback;

  LitButton({required this.buttonText, required this.callback});

  @override
  _LitButtonState createState() => _LitButtonState();
}

class _LitButtonState extends State<LitButton> {
  String result = 'Press button to run function';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            var data = await widget.callback();
            if (data == null) {
              data = "Error or null value returned from function";
            }
            setState(() {
              result = data;
            });

            setState(() {
              result = data;
            });
            print('Result from function: $data');
          },
          child: Text(widget.buttonText),
        ),
        Text(result),
      ],
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  // These futures belong to the state and are only initialized once,
  // in the initState method.
  late Future<Platform> platform;
  late Future<bool> isRelease;

  @override
  void initState() {
    super.initState();
    platform = api.platform();
    isRelease = api.rustReleaseMode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(margin: const EdgeInsets.only(top: 24)),
            Text("BLS-SDK", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Container(margin: const EdgeInsets.only(top: 24)),
            LitButton(
              buttonText: "encrypt",
              callback: () async {
                  const publicKey = '8e29447d7b0666fe41c357dbbdbdac0ac8ac973f88439a07f85fa31fa6fa3cea87c2eaa8b367e1c97764800fb5636892';
                  final secretMessage = Uint8List.fromList([
                    240, 23, 185, 6, 87, 33, 173, 216, 53, 84, 80, 135, 190, 16, 58, 85, 97, 75,
                    3, 192, 215, 82, 217, 5, 40, 65, 2, 214, 40, 177, 53, 150,
                  ]);

                  // String = "encrypt_decrypt_works"
                  final identityParam = Uint8List.fromList([
                    101, 110, 99, 114, 121, 112, 116, 95, 100, 101, 99, 114, 121, 112, 116, 95,
                    119, 111, 114, 107, 115,
                  ]);

                  String encodedMessage = hex.encode(secretMessage);
                  String encodedIdentity = hex.encode(identityParam);

                  var data = await api.encrypt(
                    publicKey: publicKey, 
                    message: encodedMessage, 
                    identity: encodedIdentity
                  );
                return data;
              },
            ),
            LitButton(
              buttonText: "combineSignatureShares",
              callback: () async {

                final signatureShares = [
                  '01b2b44a0bf7184f19efacad98e213818edd3f8909dd798129ef169b877d68d77ba630005609f48b80203717d82092a45b06a9de0e61a97b2672b38b31f9ae43e64383d0375a51c75db8972613cc6b099b95c189fd8549ed973ee94b08749f4cac',
                  '02a8343d5602f523286c4c59356fdcfc51953290495d98cb91a56b59bd1a837ea969cc521382164e85787128ce7f944de303d8e0b5fc4becede0c894bec1adc490fdc133939cca70fb3f504b9bf7b156527b681d9f0619828cd8050c819e46fdb1',
                  '03b1594ab0cb56f47437b3720dc181661481ca0e36078b79c9a4acc50042f076bf66b68fbd12a1d55021a668555f0eed0a08dfe74455f557b30f1a9c32435a81479ca8843f5b74b176a8d10c5845a84213441eaaaf2ba57e32581584393541c5aa',
                ].map((s) => '{"ProofOfPossession":"$s"}').toList();

                print("\n---------- 🦋 Flutter Frontend ----------\n");
                print("signatureShares: $signatureShares");

                print("\n---------- 🦀 RUST Backend ----------\n");
                var data = await api.combineSignatureShares(shares: signatureShares);
                print("Rust returned data: $data");

                // -- assert
                const expectedResult = '911bf01a53576c53cf7667e32ef76799711f881a72d8894aa6a7186b5189e0345065a29e5dda5a19571b63ada860b03d07125369bfd902280599052475959f34a937f1075ef1acfb8baff9b8a22fc8b0d0655ad7b6e2860117029ebc98e47898';

                if(expectedResult == data){
                  print("✅ SUCCESS, data matches expected result");
                } else {
                  print("❌ FAILED, expected: $expectedResult, got: $data");
                }
                return data;
              }
            ),
            LitButton(
              buttonText: "verifyAndDecryptWithSignatureShares",
              callback: () async {

                const publicKey = '8e29447d7b0666fe41c357dbbdbdac0ac8ac973f88439a07f85fa31fa6fa3cea87c2eaa8b367e1c97764800fb5636892';

                // -- original data
                final secretMessage = Uint8List.fromList([
                  240, 23, 185, 6, 87, 33, 173, 216, 53, 84, 80, 135, 190, 16, 58, 85, 97, 75,
                  3, 192, 215, 82, 217, 5, 40, 65, 2, 214, 40, 177, 53, 150,
                ]);
                
                // -- This is copied from the output of the encrypt function
                const ciphertext = 'jxRc7vOr+ubf/Z1fAOr0VXT2veeqE+r90eLPpnrxnV5VcrjnhHxKXfM92nAAGBQ/5KU5BH5NpBjfozjAECBzd2ncD9qe48lnVo8pBoE5evwhfDtxv/CI4U0UR8eXlsvywxjiUbNVja9vzwvD+r7IGli7Aw==';

                final signatureShares = [
                  '01b2b44a0bf7184f19efacad98e213818edd3f8909dd798129ef169b877d68d77ba630005609f48b80203717d82092a45b06a9de0e61a97b2672b38b31f9ae43e64383d0375a51c75db8972613cc6b099b95c189fd8549ed973ee94b08749f4cac',
                  '02a8343d5602f523286c4c59356fdcfc51953290495d98cb91a56b59bd1a837ea969cc521382164e85787128ce7f944de303d8e0b5fc4becede0c894bec1adc490fdc133939cca70fb3f504b9bf7b156527b681d9f0619828cd8050c819e46fdb1',
                  '03b1594ab0cb56f47437b3720dc181661481ca0e36078b79c9a4acc50042f076bf66b68fbd12a1d55021a668555f0eed0a08dfe74455f557b30f1a9c32435a81479ca8843f5b74b176a8d10c5845a84213441eaaaf2ba57e32581584393541c5aa',
                ].map((s) => '{"ProofOfPossession":"$s"}').toList();

                // String = "encrypt_decrypt_works"
                final identityParam = Uint8List.fromList([
                  101, 110, 99, 114, 121, 112, 116, 95, 100, 101, 99, 114, 121, 112, 116, 95,
                  119, 111, 114, 107, 115,
                ]);

                print("\n---------- 🦀 RUST Backend ----------\n");

                String encodedIdentity = hex.encode(identityParam);

                var decryptedBase64Data = await api.verifyAndDecryptWithSignatureShares(
                  publicKey: publicKey,
                  identity: encodedIdentity,
                  ciphertext: ciphertext,
                  shares: signatureShares
                );
                
                // -- assert
                print("Rust returned (base64): $decryptedBase64Data");
                var decryptedUint8ArrayData = base64Decode(decryptedBase64Data);

                var expectedBase64Encoded = base64Encode(secretMessage);;
                print("Expected (base64): $expectedBase64Encoded");

                if(expectedBase64Encoded == decryptedBase64Data){
                  print("✅ SUCCESS, data matches expected result");
                } else {
                  print("❌ FAILED, expected: $expectedBase64Encoded, got: $decryptedBase64Data");
                }

                return decryptedBase64Data;
              },
            ),
            LitButton(
              buttonText: "verifySignature",
              callback: () async {
                  const publicKey = 'ad1bd6c66f849ccbcc20fa08c26108f3df7db0068df032cc184779cc967159da4dd5669de563af7252b540f0759aee5a';

                  // base64 str
                  const message = 'ZXlKaGJHY2lPaUpDVEZNeE1pMHpPREVpTENKMGVYQWlPaUpLVjFRaWZRLmV5SnBjM01pT2lKTVNWUWlMQ0p6ZFdJaU9pSXdlRFF5TlRsbE5EUTJOekF3TlRNME9URmxOMkkwWm1VMFlURXlNR00zTUdKbE1XVmhaRFkwTm1JaUxDSmphR0ZwYmlJNkltVjBhR1Z5WlhWdElpd2lhV0YwSWpveE5qZzNOVFl5TWpjMUxDSmxlSEFpT2pFMk9EYzJNRFUwTnpVc0ltRmpZMlZ6YzBOdmJuUnliMnhEYjI1a2FYUnBiMjV6SWpwYmV5SmpiMjUwY21GamRFRmtaSEpsYzNNaU9pSWlMQ0pqYUdGcGJpSTZJbVYwYUdWeVpYVnRJaXdpYzNSaGJtUmhjbVJEYjI1MGNtRmpkRlI1Y0dVaU9pSWlMQ0p0WlhSb2IyUWlPaUlpTENKd1lYSmhiV1YwWlhKeklqcGJJanAxYzJWeVFXUmtjbVZ6Y3lKZExDSnlaWFIxY201V1lXeDFaVlJsYzNRaU9uc2lZMjl0Y0dGeVlYUnZjaUk2SWowaUxDSjJZV3gxWlNJNklqQjROREkxT1VVME5EWTNNREExTXpRNU1VVTNZalJHUlRSQk1USXdRemN3WW1VeFpVRkVOalEyWWlKOWZWMHNJbVYyYlVOdmJuUnlZV04wUTI5dVpHbDBhVzl1Y3lJNmJuVnNiQ3dpYzI5c1VuQmpRMjl1WkdsMGFXOXVjeUk2Ym5Wc2JDd2lkVzVwWm1sbFpFRmpZMlZ6YzBOdmJuUnliMnhEYjI1a2FYUnBiMjV6SWpwdWRXeHNmUQ==';

                  // base64 str
                  const signature = 'trkIFY8XLxWAHvErjc5sEMfyEMjDVW0m4zSEiO8Ladb+F2vsaUmBMPIR4axyHdayDJ7/qdxUsxM1Xt/AUMcYRCVbUqNZZmkAGtOFGODAjieGdv9Q3aPnsrQXkDzW0ITP';

                  print("\n---------- 🦀 RUST Backend ----------\n");
                  try{
                    await api.verifySignature(publicKey: publicKey, message: message, signature: signature);
                    print("✅ SUCCESS, signature is valid");
                    return "✅ SUCCESS, signature is valid";
                  }catch(e){
                    print("❌ FAILED, signature is invalid");
                    return "❌ FAILED, signature is invalid";
                  }
              }
            ),
          ],
        ),
      ),
    );
  }
}
