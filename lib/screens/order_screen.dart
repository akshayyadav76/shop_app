import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../providers/orders.dart' show Order;
import '../widgets/order_items.dart';




class OrderScreen  extends StatelessWidget {
  static const routeName ="/orderscreen";

  @override
  Widget build(BuildContext context) {
    final orderData=Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(title: Text("your orders"),

      ),
      body: ListView.builder(itemCount: orderData.orders.length,itemBuilder: (cont,i){
        return OrderItem(orderData.orders[i]);
      },),
    );
  }
}
