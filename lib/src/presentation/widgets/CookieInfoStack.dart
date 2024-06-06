import 'package:flutter/material.dart';
import 'package:khukiting/src/domain/Model/nameTag.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
final class CookieInfoStack extends StatelessWidget {
  String cookieInfo;
  NameTag nameTagSize;
  CookieInfoStack(this.cookieInfo, this.nameTagSize, {super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset('assets/nameTag.png',
            width: nameTagSize.tagWidth,
            height: nameTagSize.tagHeight,
            fit: BoxFit.contain),
        Text(
          cookieInfo,
          style:
              TextStyle(fontSize: nameTagSize.sizeofFont, color: Colors.black, fontFamily: 'uhBeeRegular'),
        ),
      ],
    );
  }
}
