import 'dart:convert';
import 'dart:async';


import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Auth with ChangeNotifier{
    String _token;
  DateTime _expirtData;
  String  _userId;
  String password;
  Timer  authTimer;

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

  Future<void> logout()async{
    _token =null;
    _userId=null;
    _expirtData =null;
    if(authTimer !=null){
     authTimer.cancel();
     authTimer =null;
    }
    notifyListeners();
    final prfs = await SharedPreferences.getInstance();
    prfs.clear();
  }

  void _autoLogout(){
    if(authTimer !=null){
      authTimer.cancel();
    }
   final timerToEx =_expirtData.difference(DateTime.now()).inSeconds;
   authTimer = Timer(Duration(seconds: timerToEx),logout);
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

  Future<bool>tryAutolog()async{
    final prfs =await SharedPreferences.getInstance();
    if(!prfs.containsKey('userData')){
      return false;
    }
    final extrctedData = json.decode(prfs.getString("userData")) as Map<String ,Object>;
    final expirDate=DateTime.parse(extrctedData['expritDate']);

    if(expirDate.isBefore(DateTime.now())){
      return false;
    }

    _token =extrctedData['token'];
    _userId=extrctedData['userId'];
    _expirtData=expirDate;
    notifyListeners();
    _autoLogout();
    return true;
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
    _expirtData =DateTime.now().add(Duration(
        seconds: int.parse(reponseData['expiresIn'])));
    _autoLogout();
    notifyListeners();

    final prfs=await SharedPreferences.getInstance();
     final userData=json.encode({
       "token":_token,
       "userId":_userId,
       "expritDate":_expirtData.toIso8601String(),
     });
    prfs.setString("userData", userData);

   }catch(ee){
     throw ee;
   }

  }
}