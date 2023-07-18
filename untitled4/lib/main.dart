import 'Accueil.dart';
import 'authentification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() => runApp(MyApp());

// First put json file in android and json
// use gradle in android plugin
// yaml for firebase

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MYSQL Login',
      theme: ThemeData(),
      home: LoginPage(),
      routes: {
        '/loginPage': (BuildContext context)=> LoginPage(),
        '/home2': (BuildContext context)=> AccueilPage(),
      },
    );
  }
}