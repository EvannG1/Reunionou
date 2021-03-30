import 'package:flutter/material.dart';
import 'package:reunionou_app/models/Auth.dart';
import 'package:reunionou_app/pages/Auth/Login.dart';
import 'package:reunionou_app/pages/Auth/Signin.dart';
import 'package:reunionou_app/pages/EventPage.dart';
import 'package:reunionou_app/pages/Home.dart';
import 'package:hexcolor/hexcolor.dart';

class ReunionouApp extends StatefulWidget {

  @override
  _ReunionouAppState createState() => _ReunionouAppState();
}

class _ReunionouAppState extends State<ReunionouApp>{
  Auth userAuth = Auth();

  void _onAuthUpdateEvent(Auth user){
    setState(() {
      userAuth = user;
      print("set state called userAuth modifié");
    });
  }

  @override
  Widget build(BuildContext context){
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
      initialRoute: '/',
      routes: {
        //attention peu importe la route initial, quand l'app se lance elle passe toujours par la route "/"
        //on fait donc la vérification user connected dans la route "/"
        '/': (context) => (userAuth.token != null) ? Home(userAuth) : Login(userAuth: userAuth, onAuthUpdateCallback: _onAuthUpdateEvent),
        '/login': (context) => Login(userAuth: userAuth, onAuthUpdateCallback: _onAuthUpdateEvent),
        '/signin': (context) => Signin(),
        '/event': (context) => EventPage(userAuth),
      },
    );
  }
}