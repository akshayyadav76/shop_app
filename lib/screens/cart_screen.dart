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
            flateButton(cartdata),
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


class flateButton extends StatefulWidget {

  final  Cart cart;
  flateButton(this.cart);



  @override
  _flateButtonState createState() => _flateButtonState();
}

class _flateButtonState extends State<flateButton> {
    //final dd;
  var isLoading =false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: isLoading ?CircularProgressIndicator():Text("order"),
      onPressed: (widget.cart.totalAmount<=0|| isLoading)?null:()
      async{
        setState(() {
          isLoading =true;
        });
     await Provider.of<Order>(context,listen: false).add(
          widget.cart.cartItems.values.toList(),
          widget.cart.totalAmount
     );
     setState(() {
       isLoading =false;
     });


          widget.cart.cartClear();
       },
    );
  }
}

