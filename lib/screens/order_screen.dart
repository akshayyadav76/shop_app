import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Order;
import '../widgets/order_items.dart';
import '../widgets/app_drawer.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = "/orderscreen";

  @override
  Widget build(BuildContext context) {
    print("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb");
    //final orderData = Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("your orders"),
      ),
      body:FutureBuilder(future: Provider.of<Order>(context,listen: false).fetchSetOrders(),
        builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }else if(snapshot.error !=null){
          //return somethibg
        }else{
          return Consumer<Order>(builder: (cont,orderData,child){
            return ListView.builder(
              itemCount: orderData.orders.length,
              itemBuilder: (cont, i) {
                return OrderItem(orderData.orders[i]);
              },
            );
          },);
        }
        return null;
        },
      ),
      drawer: AppDrawer(),
    );
  }



}
