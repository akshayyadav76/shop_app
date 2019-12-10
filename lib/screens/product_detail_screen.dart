import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {

  static const String routeName='/product-detail';

// final String productTitle;
//
//  ProductDetailScreen(this.productTitle);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProdcuts=Provider.of<Products>(context).items.firstWhere((pro)=>productId==pro.id);

    return Scaffold(
      appBar: AppBar(title: Text(loadedProdcuts.title),),
    );
}
}
