import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';
import '../screens/edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {

  static const routeName="/user_product_screen";

  @override
  Widget build(BuildContext context) {
    final data =Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(title: Text("User Products"),
      actions: <Widget>[

        IconButton(icon: Icon(Icons.add),onPressed: (){
          Navigator.of(context).pushNamed(EditProductScreen.routeName);
        },),
      ],),

        body: ListView.builder(itemCount:data.items.length, itemBuilder: (context,i){
        return UserProductItem(data.items[i].id,data.items[i].title,data.items[i].imageUrl);
    },),
      drawer: AppDrawer(),
    );
  }
}
