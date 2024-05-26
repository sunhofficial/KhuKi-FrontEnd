
// import 'package:flutter/cupertino.dart';
// import 'package:khukiting/src/presentation/widgets/PickedCookieStack.dart';
// import 'package:khukiting/src/presentation/widgets/CookieDetailBottomModal.dart';
// import 'package:khukiting/src/presentation/views/MainPage/MainView.dart';

// import 'package:khukiting/src/domain/Model/Cookie.dart';
// import 'package:khukiting/src/domain/Model/nameTag.dart';
// import 'package:flutter/material.dart';

// // class PickedCookiesView extends StatelessWidget {
// //   @override 
// //   Widget build(BuildContext context) {
// //     // TODO: implement build
// //     return ListView

// //   }
  
// // }
// class PickedCookieListPage extends StatefulWidget {
//   @override 
//   _PickedCookieListPageState createState() => _PickedCookieListPageState();
// }
// class _PickedCookieListPageState extends State<PickedCookieListPage> {
// List<Cookie> cookies = [Cookie(info: "hihihi", cookieType: "khu"), Cookie(info: "내이름은", cookieType: "white"), Cookie(info: "holymoly", cookieType: "normal")];

// @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("내가 뽑은 쿠키"),),
//       body:  Padding(padding: EdgeInsets.symmetric(horizontal: 32),
//       child:    ListView.builder(itemCount: cookies.length, itemBuilder: (context, index) {
//         return GestureDetector(onTap: () {
//           _showCookieDetailModal(context, cookies[index]);
//         }, child: Container(
//               margin: EdgeInsets.symmetric(vertical:  16), // 아이템 사이의 간격
//               child: PickedCookieStack(
//                 cookie: cookies[index],
//                 isHistory: true,
//               ),
//             ),);
//       }),),
   
//     );
//   }
//   _showCookieDetailModal(BuildContext context, Cookie cookie) {
//     showCupertinoModalPopup(
//       context: context,
//       builder: (BuildContext context) {
//         return CookieDetailBottomModal(cookie);
//       },
//     );
//   }
// }