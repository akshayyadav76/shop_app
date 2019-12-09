import 'package:flutter/foundation.dart';

class Products {
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

  Products(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.imageUrl,
      this.isfavorite = false});
}
