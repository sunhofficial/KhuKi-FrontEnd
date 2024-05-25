import 'package:flutter/material.dart';
import 'package:khukiting/src/presentation/views/MainPage/MainView.dart';
import 'package:khukiting/src/presentation/widgets/CookieInfoStack.dart';
import 'package:khukiting/src/domain/Model/Cookie.dart';
import 'package:khukiting/src/domain/Model/nameTag.dart';
import 'package:flutter/cupertino.dart';


class PickedCookieStack extends StatelessWidget {
  final Cookie cookie;
  final bool isHistory;

  PickedCookieStack({required this.cookie, required this.isHistory});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(constraints: BoxConstraints(maxWidth: 320, maxHeight: isHistory ? 224 : 208),child: 
     DecoratedBox(
      decoration: isHistory ? BoxDecoration( 
        border: Border.all(color: Colors.red, width: 2),
      borderRadius: BorderRadius.circular(10),
      color: Colors.pink
      ) : BoxDecoration(),
      child: Stack(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(8, 32, 8, 32),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(children: [
              Image.asset(
                'assets/cookieType/${cookie.cookieType}.png',
                width: isHistory ? 128 : 140,
                height: isHistory ? 128 : 140,
              ),
              if (isHistory == true)...[
                SizedBox(height: 4,),
                CookieInfoStack(cookie.info, NameTag.small),]
              ],
              ),
              SizedBox(width: 8,),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 8,),
                  Text("연락수단"),
                  SizedBox(height: 4),
                  Text("010-3348-9055"),
                  SizedBox(height: 8),
                  Text("이렇게 연락해죠"),
                  SizedBox(height: 4),
                  Text("안녕 날 소개하지 내이름은"),
                ],
              ),
            ],
          ),
        ),
        if (isHistory == false)
          Positioned(
            right: 4,
            top: 8,
            child: IconButton(
              icon: Icon(
                CupertinoIcons.xmark,
                color: Colors.red,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          )
      ],
    ),
    ),
    );
   
  }
}
