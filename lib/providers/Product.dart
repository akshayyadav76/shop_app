import 'package:flutter/foundation.dart';



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

  void tonggleFavoriteStatus(){
    isfavorite =!isfavorite;
    notifyListeners();
  }
}
