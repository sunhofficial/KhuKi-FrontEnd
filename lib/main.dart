import 'package:flutter/material.dart';
import 'package:khukiting/Login/LoginView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login",
      home: LoginView(),
    );
  }
}
