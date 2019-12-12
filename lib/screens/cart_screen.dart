import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartScreen extends StatelessWidget {

  static const cartRoute ="CartScreen";
  @override
  Widget build(BuildContext context) {
    final cartdata=Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(title: Text("your cart"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(padding: EdgeInsets.all(18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Total"),
                Spacer(),
                Chip(label: Text("\$${cartdata.totalAmount}",style: TextStyle(color: Colors.red),),),
                FlatButton(child: Text("order"),onPressed: (){},)
              ],
            ),),
          )
        ],
      ),
    );
  }
}
