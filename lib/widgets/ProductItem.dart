import 'package:flutter/material.dart';

import '../screens/product_detail_screen.dart';



class ProductItem extends StatelessWidget {

  final String id;
  final String title;

  //final String description;
  //final double price;
  final String imageUrl;

  ProductItem(
    this.id,
    this.title,
    //this.description,
    this.imageUrl,
    //this.price
  );

  @override
  Widget build(BuildContext context) {


    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(

        child: GestureDetector(
          child: Image.network(
            imageUrl,
            fit: BoxFit.fill,
          ),
          onTap: (){
           Navigator.of(context).pushNamed(ProductDetailScreen.routeName,arguments: id);
          },
        ),

        footer: GridTileBar(
          leading: IconButton( icon: Icon(Icons.favorite_border,color: Theme.of(context).accentColor,
          ),onPressed: (){},),
          trailing: IconButton(icon:Icon(Icons.shopping_cart,color: Theme.of(context).accentColor,)
            ,onPressed: (){},),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),backgroundColor: Colors.black54,
        ),
      ),
    );
  }
}
