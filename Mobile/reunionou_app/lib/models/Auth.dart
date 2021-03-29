import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Auth{
  int id;
  String fullname;
  String email;
  String token;

  void seConnecter(String login, String password, context) async{
    final url = Uri.parse('http://api.local:19080/signin');
    final response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"},
        body: {
          'email': login,
          'password': password
        });
    print('donné reçu');
    if(response.statusCode == 200){
      final data = convert.jsonDecode(response.body);
      if(data['fullname'] != null){
        this.fullname = data['fullname'];
        this.email = data['email'];
        this.token = data['token'];
        print('connected');
      }
      else//faire les messages d'erreur (snackbar) en widget sinon on doit tout modifier à chaque modif de l'ui
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Vos identifiants de connexion sont incorrects, veuillez réessayer!")));
    }
    else
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Une erreur a été rencontré, vérifiez votre connexion. Si le problème persiste veuillez contacter l'administrateur.")));
  }

}