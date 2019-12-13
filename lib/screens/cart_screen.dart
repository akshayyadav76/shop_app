import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart'; //show Cart
import '../widgets/cart_item.dart' as ui;
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {

  static const cartRoute = "CartScreen";

  @override
  Widget build(BuildContext context) {
    final cartdata = Provider.of<Cart>(context);

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
            Chip(label: Text("\$${cartdata.totalAmount.toStringAsFixed(2)}",
              style: TextStyle(color: Colors.red),),),
            FlatButton(child: Text("order"), onPressed: () {
             Provider.of<Order>(context,listen: false).add(cartdata.cartItems.values.toList(),
                  cartdata.totalAmount
              );
             cartdata.cartClear();
            },)
          ],
        ),),
    ),
    SizedBox(height: 10,),
    Expanded(child: ListView.builder(itemCount: cartdata.cartCount,itemBuilder: (data,i){
      return ui.CartItem(cartdata.cartItems.values.toList()[i].id,
        cartdata.cartItems.keys.toList()[i],
        cartdata.cartItems.values.toList()[i].title,
        cartdata.cartItems.values.toList()[i].price,
        cartdata.cartItems.values.toList()[i].quantity,);
    }),)
    ],
    ),
    );
  }
}
