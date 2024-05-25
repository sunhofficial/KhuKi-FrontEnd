import 'dart:convert';
import 'dart:ffi';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:khukiting/src/config/configuartions.dart';
// import 'package:khukiting/src/domain/Model/User.dart';
import 'package:khukiting/src/domain/repository/LoginRepository.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:async';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:khukiting/src/domain/Model/response/LoginResponse.dart';

class LoginView extends StatelessWidget {
  final LoginRepository loginRepository = getIt<LoginRepository>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 88,),
            Image.asset("assets/logo.png", width: 384, height: 360,),
            SizedBox(height: 64,),
            Text("쿠키로 전하는 나의 마음",
              style: TextStyle(fontSize: 16, fontWeight:FontWeight.normal),),
            Text(
              "Khu-Ki DDIng",
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 80,),
            // 여기에 추가적인 위젯이나 기능을 구현하세요
            Text("계속하려면 로그인 하세요", style: TextStyle(fontSize: 16, fontWeight:FontWeight.normal),),
            Padding(padding: EdgeInsets.fromLTRB(27, 16, 27, 64),
            child: SignInWithAppleButton(
              onPressed: () async {
                _handleSigninwithApple(context);
              },
            ),
            )
          ],
        ),
      ),
    );
  }
  Future<void> _handleSigninwithApple(BuildContext context) async {
    try { 
      final rawNounce = generateNonce();
      final bytes = utf8.encode(rawNounce);
      final digest = sha256.convert(bytes);
      final nonce = digest.toString();
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );
      print(credential.authorizationCode);
      loginRepository.postLogin(credential.identityToken!);
      // await _authorizeUsingSiwa(identityToken: credential.identityToken, email: credential.email);
    } catch (error) {
      print("Apple login 실패: $error");
    }
  }

  Future<void> _authorizeUsingSiwa({required String? identityToken, required String? email}) async {
    try {
      if (identityToken == null) {
        throw Exception("IdentityToken is missing");
      }
      final response = await http.post(
        Uri.parse("https://9709-125-130-123-109.ngrok-free.app/api/auth/siwa"), // 여기에 서버의 URL을 입력하세요
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'appleIdentityToken': identityToken}),
      );
      
      if (response.statusCode == 200) {
        print("SIWA authorization success: $response");
        final decodeddata = LoginResponse.fromJson(jsonDecode(response.body));
        // Secure Storage에 저장
        final storage = FlutterSecureStorage();
        await storage.write(key: 'accessToken', value: decodeddata.accessToken);
        print(decodeddata.accessToken);
        print(decodeddata.email);
        print(decodeddata.id);
      } else {
        throw Exception("Failed to authorize with SIWA ${response.statusCode}");
      }
    } catch (error) {
      print("Failed to authorize with SIWA: $error");
    }
  }
}
