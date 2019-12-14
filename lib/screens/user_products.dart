import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class UserProduct extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final data =Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(title: Text("User Products"),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.add),onPressed: (){

        },),
      ],),body: ListView.builder(itemCount:data.items.length, )
    );
  }
}
