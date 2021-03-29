import 'package:flutter/material.dart';
import 'package:reunionou_app/models/Auth.dart';
import 'package:reunionou_app/pages/Auth/Login.dart';

class Home extends StatelessWidget{
  static const routeName = '/';
  static const routeIndex = 0;

  final Auth loggedUser;

  Home(Auth this.loggedUser);

  @override
  Widget build(BuildContext context){
    print("je suis là");
    return Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/images/logo_762x341.png'),
                  width: 120,
                )
              ],
            )),
        body: Center(
          child:
          Text(
            "salut",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        )
    );
  }
}