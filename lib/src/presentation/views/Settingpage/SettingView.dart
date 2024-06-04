import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class SettingView extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(middle: Text('설정',style: TextStyle(color: Colors.black),),),
      body: ListView(padding: const EdgeInsets.all(8),
      children: <Widget>[
        Text("내 쿠키 바꾸기"),
        Text("소개 변경하기"),
        Text("회원 탈퇴"),
        Text("로그아웃"),

      ],)
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
       
      //   ],
      // ),
    );
  }
}