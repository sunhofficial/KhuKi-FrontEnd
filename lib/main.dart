import 'package:flutter/material.dart';
import 'package:khukiting/src/config/configuartions.dart';
// import 'package:khukiting/Login/LoginView.dart';
import 'package:khukiting/src/presentation/views/MainPage/MainView.dart';
import 'package:khukiting/src/presentation/views/ProfileSetting/SecondView.dart';
import 'package:khukiting/src/presentation/views/ProfileSetting/ThirdView.dart';
import 'package:khukiting/src/presentation/views/ProfileSetting/firstView.dart';
import 'package:dio/dio.dart';
import './src/presentation/views/Login/LoginView.dart';
import 'package:get_it/get_it.dart';
Future<void> main() async {
// final Dio dio = Dio();
 WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  
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
