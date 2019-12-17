import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../providers/products.dart';

class UserProductItem extends StatelessWidget {

  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id,this.title,this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final deletProdcut = Provider.of<Products>(context,listen: true);
    return  ListTile(
        title: Text(title),
        leading: CircleAvatar(child: Image.network(imageUrl),),
        trailing: Container(
          width: 100,
          child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.edit),onPressed: (){
                  Navigator.of(context).pushNamed(EditProductScreen.routeName,arguments: id);
                },),
                IconButton(icon: Icon(Icons.delete),onPressed: (){
                  deletProdcut.deleteProduct(id);

                },)
              ]
          ),
        ),

    );
  }
}
