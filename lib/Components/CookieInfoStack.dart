import 'package:flutter/material.dart';
import 'package:khukiting/MainPage/MainView.dart';
import 'package:khukiting/Model/NameTag.dart';
import 'package:khukiting/Model/Cookie.dart';
import 'package:flutter/cupertino.dart';
final class CookieInfoStack extends StatelessWidget {
  String cookieInfo;
  NameTag nameTagSize;
  CookieInfoStack(this.cookieInfo, this.nameTagSize );
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
          style: TextStyle(fontSize: nameTagSize.sizeofFont, color: Colors.black),
        ),
      ],
    );
  
}
}