import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:reunionou_app/models/Auth.dart';
import 'package:reunionou_app/pages/Home.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart';
import 'package:geolocation/geolocation.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';
  static const routeIndex = 1;

  final Auth userAuth;
  final Function onAuthUpdateCallback;

  const Login({ Key key, this.userAuth, this.onAuthUpdateCallback  }) : super(key: key);

  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  var _userAuth;
  GlobalKey _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _userAuth = this.widget.userAuth;
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 40.0, right: 40.0, top: 40.0),
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 48.0,
                child: Image.asset('assets/images/logo_1024x1024.png'),
              ),
              SizedBox(height: 48.0),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: 'Adresse mail',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                ),
                onSaved: (String value){email=value;},
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Entrez une adresse mail valide';
                  }
                  else if (!value.contains('@')) {
                    return 'Adresse mail invalide, l\'adresse doit contenir @';
                  }
                  else if (!value.contains('.')) {
                    return 'Adresse mail invalide, l\'adresse doit contenir .';
                  }
                  else
                    return null;
                },
              ),
              SizedBox(height: 12.0),
              TextFormField(
                autofocus: false,
                obscureText: true,
                decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  labelText: 'Mot de passe',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
                ),
                onSaved: (String value){password=value;},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un mot de passe valide.';
                  }else
                    return null;
                },
              ),
              SizedBox(height: 24.0),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    final FormState form = _formKey.currentState;
                    if(form.validate()){
                      form.save();
                      () async {
                        _userAuth = await _userAuth.seConnecter(email, password, context);
                        if(_userAuth.connected){
                          //widget.onAuthUpdateCallback(_userAuth);
                          () async {
                            Geolocation.enableLocationServices().then((result) {
                              // Request location

                              print(result);
                            }).catchError((e) {
                              // Location Services Enablind Cancelled
                              print(e);
                            });

                            Geolocation.currentLocation(accuracy: LocationAccuracy.best)
                                .listen((result) {
                              if (result.isSuccessful) {
                                _userAuth.lat = result.location.latitude;
                                _userAuth.long = result.location.longitude;
                              }
                            });
                          }();
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: Home(_userAuth),
                            ),
                          );
                        }
                      }();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )
                  ),
                  child: Text('Log In', style: TextStyle(color: Colors.white)),
                ),
              ),
              TextButton(
                child: Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                onPressed: () {
                  print("mot de passe oublié");
                },
              ),
              TextButton(
                child: Text(
                  'Create New Account',
                  style: TextStyle(
                      color: Colors.black87,
                      decoration: TextDecoration.underline),
                ),
                onPressed: () {
                  print("Signin");
                },
              ),
            ],
          ),
        ),
    );
  }
}
