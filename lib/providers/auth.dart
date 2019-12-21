import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Auth with ChangeNotifier{
  String token;
  DateTime time;
  String password;


  Future<void>signup(String email,String password)async{
    const url ="https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDiMGRjCFLqOnXsEzEETJensSdKEUEhLKE";
    final reponse = await http.post(url,body: json.encode({
      "email":email,
      "password":password,
      "returnSecureToken":true
    }));
    print(reponse.body);
  }
}