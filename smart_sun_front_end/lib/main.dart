import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_sun/pages/login.dart';
import 'package:smart_sun/pages/navbar.dart';
import 'package:smart_sun/pages/register.dart';

Future main() async {
  await dotenv.load();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: {
        LoginPage.routeName: (context) => LoginPage(),
        RegisterPage.routeName: (context) => RegisterPage(),
        NavBar.routeName: (context) => NavBar(),
      },
    );
  }
}
