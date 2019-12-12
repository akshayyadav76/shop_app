import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../providers/Product.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget {
//  final String id;
//  final String title;
//
//  //final String description;
//  //final double price;
//  final String imageUrl;
//
//  ProductItem(
//    this.id,
//    this.title,
//    //this.description,
//    this.imageUrl,
//    //this.price
//  );

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context ,listen: false);
    final cartItems =Provider.of<Cart>(context,listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.fill,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: product.id);
          },
        ),
        footer: GridTileBar(

          leading: Consumer<Product>(
            builder: (context,product,_)=>
             IconButton(
              icon: Icon(product.isfavorite ? Icons.favorite:Icons.favorite_border,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {product.tonggleFavoriteStatus();},
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).accentColor,
            ),
            onPressed: ()=> cartItems.addCart(product.id, product.title, product.price),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black54,
        ),
      ),
    );
  }
}
