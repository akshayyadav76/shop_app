import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/http_exception.dart';


class Auth with ChangeNotifier{
    String _token;
  DateTime _expirtData;
  String  _userId;
  String password;

  bool get isAuth{
    return token !=null;
  }

  String get userId{
  return _userId; }

  String get token{
    if(_expirtData!=null&&_token!=null&&_expirtData.isAfter(DateTime.now())){
      return _token;
    }
    return null;
  }

  Future<void>signup(String email,String password)async{
    const url ="https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDiMGRjCFLqOnXsEzEETJensSdKEUEhLKE";
    final reponse = await http.post(url,body: json.encode({
      "email":email,
      "password":password,
      "returnSecureToken":true
    }));


    print(reponse.body);
  }

  Future<void>signIn(String email,String password)async{
    const url = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDiMGRjCFLqOnXsEzEETJensSdKEUEhLKE";
   try{
    final reponse = await http.post(url,body:json.encode( {
      "email":email,
      "password":password,
      "returnSecureToken":true
    })
    );
    final reponseData =json.decode(reponse.body);

    if(reponseData['error'] !=null ){
      throw HttpException(reponseData['error']['message']);
    }

    print(reponse.body);
    _token=reponseData['idToken'];
    _userId=reponseData['localId'];
    _expirtData =DateTime.now().add(Duration(seconds: int.parse(reponseData['expiresIn'])));
   }catch(ee){
     throw ee;
   }
   notifyListeners();
  }
}