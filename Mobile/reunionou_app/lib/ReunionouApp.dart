import 'package:flutter/material.dart';
import 'package:reunionou_app/models/Auth.dart';
import 'package:reunionou_app/pages/Auth/Login.dart';
import 'package:reunionou_app/pages/Auth/Signin.dart';
import 'package:reunionou_app/pages/Home.dart';
import 'package:hexcolor/hexcolor.dart';

class ReunionouApp extends StatefulWidget {

  @override
  _ReunionouAppState createState() => _ReunionouAppState();
}

class _ReunionouAppState extends State<ReunionouApp>{
  Auth userAuth = Auth();

  @override
  Widget build(BuildContext context){
    String _defaultRoute = '/login';
    if(userAuth.token != null){
      _defaultRoute = '/';
    }

    return MaterialApp(
      title: 'ReunionOu',
      theme: ThemeData(
        primaryColor: Colors.black,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: HexColor('#AC3A3A'),
            onPrimary: Colors.white,
          )
        ),
      ),
      initialRoute: _defaultRoute,
      routes: {
        '/': (context) => Home(userAuth),
        '/login': (context) => Login(userAuth: userAuth),
        '/signin': (context) => Signin(),
      },
    );
  }
}