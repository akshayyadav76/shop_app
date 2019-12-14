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

    final loadedProdcuts=Provider.of<Products>(context).findById(productId);

    return Scaffold(
      appBar: AppBar(title: Text(loadedProdcuts.title),),
      body: Column(
        children: <Widget>[
          Container(
            height: 400,
              width: double.infinity,
              child: Image.network("${loadedProdcuts.imageUrl}",fit: BoxFit.cover,)
          ,
          ),
          Text("${loadedProdcuts.price}"),
          Text("${loadedProdcuts.title}")


        ],
      ),
    );
  }
}
