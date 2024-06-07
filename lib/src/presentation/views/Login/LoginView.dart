import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:khukiting/src/config/configuartions.dart';
import 'package:khukiting/src/data/datasources/local/AccessTokenProvider.dart';
import 'package:khukiting/src/domain/repository/UserRepository.dart';
import 'package:khukiting/src/presentation/views/Login/LoginViewModel.dart';
import 'package:khukiting/src/presentation/views/MainPage/MainView.dart';
import 'package:khukiting/src/presentation/views/ProfileSetting/First/FirstView.dart';
import 'package:khukiting/src/presentation/views/ProfileSetting/Second/SecondView.dart';
import 'package:khukiting/src/utils/ColorStyles.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:async';
import 'package:crypto/crypto.dart';
import '.../../../../../utils/ColorStyles.dart';
class LoginView extends StatelessWidget {
  final UserRepository loginRepository = getIt<UserRepository>();
  final LoginViewModel _loginViewModel;
  LoginView({Key? key})
      : _loginViewModel = LoginViewModel(
            getIt<UserRepository>(), getIt<AccessTokenProvider>()),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double imageSize = screenWidth - 16; 
    return Scaffold(
      backgroundColor: ColorStyles.LoginPageBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 88,
            ),
            Image.asset(
              "assets/logo.png",
              width: imageSize,
              height: imageSize,
            ),
            const SizedBox(
              height: 64,
            ),
            const Text(
              "쿠키로 전하는 나의 마음",
              style: TextStyle(fontSize: 18, fontFamily: 'uhBeeBold', color: Colors.white),
            ),
            const SizedBox(height: 8,),
            const Text(
              "Khu-Ki DDIng",
              style: TextStyle(fontSize: 48, color:  Colors.white),
            ),
            const SizedBox(
              height: 72,
            ),
            // 여기에 추가적인 위젯이나 기능을 구현하세요
            const Text(
              "계속하려면 로그인 하세요",
              style: TextStyle(fontSize: 16,color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: SignInWithAppleButton(
                onPressed: () async {
                  _handleSigninwithApple(context);
                },
                style: SignInWithAppleButtonStyle.white,
                height: 56,
                borderRadius: BorderRadius.circular(16),
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
      final message =
          await _loginViewModel.signInwithApple(credential.identityToken!);
      if (message == "회원가입성공" || message == "첫번째프로필") {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => FirstView()));
      } else if (message == "두번째프로필") {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SecondView()));
      } else if (message == "로그인성공") {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainView()));
      }
    } catch (error) {
      print("Apple login 실패: $error");
    }
  }
}
