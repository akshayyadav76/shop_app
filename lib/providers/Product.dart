import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart'as http;


class Product with ChangeNotifier{
  @required
  final String id;
  @required
  final String title;
  @required
  final String description;
  @required
  final double price;
  @required
  final String imageUrl;
  bool isfavorite;

  Product(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.imageUrl,
      this.isfavorite = false});

  void _setvalue(bool oldvalue){
    isfavorite = oldvalue;
    notifyListeners();
  }

  Future<void> tonggleFavoriteStatus(String token, String userId)async{
    final url="https://fir-9a1fe.firebaseio.com/userFavorites/$userId/$id.json?auth=$token";
    final oldStatus =isfavorite;
    isfavorite = !isfavorite;
    notifyListeners();

    try{
    final reponse = await http.put(url,body: json.encode(isfavorite));
    if(reponse.statusCode >= 400 ){
      _setvalue(oldStatus);
    }
  }catch(err){
      _setvalue(oldStatus);
    }
  }
}
