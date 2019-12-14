import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;

  CartItem(this.id, this.productId,this.title, this.price, this.quantity);

  @override
  Widget build(BuildContext context) {
    return Dismissible(key: ValueKey(id),
      confirmDismiss: (direction){
      return showDialog(context: context,builder: (ctx){
       return AlertDialog(title: Text("are you sure?"),content: Text("do you wnat to remove from card"),
       actions: <Widget>[
         FlatButton(child: Text("No"),onPressed: (){
           Navigator.of(ctx).pop(false);
         },),
         FlatButton(child: Text("yes"),onPressed: (){
           Navigator.of(ctx).pop(true);
         },)
       ],
       );
      });
      },
      background: Container(color: Colors.red,child: Icon(Icons.delete),alignment:Alignment.centerRight,),
      direction: DismissDirection.endToStart,
      onDismissed: (dir){
      final delteCart =Provider.of<Cart>(context,listen: false);
      delteCart.deleteCart(productId);
      },

      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),

        child: ListTile(
          leading: CircleAvatar(child: FittedBox(child: Text("\$$price"))),
          title: Text(title),
           subtitle: Text("Total: \$${price*quantity}"),
          trailing: Text("$quantity X "),
        ),
      ),
    );
  }
}
