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
     // appBar: AppBar(title: Text(loadedProdcuts.title),),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight:  360,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(title: Text(loadedProdcuts.title),
            background: Hero(
                tag: loadedProdcuts.id,
                child: Image.network("${loadedProdcuts.imageUrl}",fit: BoxFit.cover,)),
            ),
          ),
          SliverList(
            delegate:SliverChildListDelegate(
              [
                SizedBox(height: 10,),

                Text("${loadedProdcuts.price}"),
                SizedBox(height: 10,),

                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: double.infinity,
                    child: Text("${loadedProdcuts.title}")),
                SizedBox(height: 700,)
              ]
            ) ,
          ),
        ],
//        child: Column(
//          children: <Widget>[
//            Container(
//              height: 360,
//                width: double.infinity,
//                child:
//            ,
//            ),
//
//
//          ],
//        ),
      ),
    );
  }
}
