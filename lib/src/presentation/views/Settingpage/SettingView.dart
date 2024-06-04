import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class SettingView extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(middle: Text('설정',style: TextStyle(color: Colors.black),),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView(

          )
        ],
      ),
    );
  }
}