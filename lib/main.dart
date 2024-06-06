import 'package:flutter/material.dart';
import 'package:khukiting/src/config/configuartions.dart';
import 'package:khukiting/src/utils/ColorStyles.dart';
// import 'package:khukiting/Login/LoginView.dart';
import './src/presentation/views/Login/LoginView.dart';
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
      title: "khukiDDIng",

      theme: ThemeData(fontFamily: 'cafeFonts',scaffoldBackgroundColor: ColorStyles.Custombackground),
      

      
      home: LoginView(),
    );
  }
}
