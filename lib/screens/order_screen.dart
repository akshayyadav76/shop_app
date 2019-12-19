import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../providers/orders.dart' show Order;
import '../widgets/order_items.dart';
import '../widgets/app_drawer.dart';




class OrderScreen  extends StatefulWidget {
  static const routeName ="/orderscreen";

  @override
  _OrderScreenState createState() => _OrderScreenState();
}



class _OrderScreenState extends State<OrderScreen> {

  var isLoading =false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_)async{
      setState(() {
        isLoading = true;
      });
      await Provider.of<Order>(context,listen: false).fetchSetOrders();
      setState(() {
        isLoading =false;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final orderData=Provider.of<Order>(context);
    return Scaffold(
      appBar: AppBar(title: Text("your orders"),

      ),
      body: ListView.builder(itemCount: orderData.orders.length,itemBuilder: (cont,i){
        return isLoading ? Center(child: CircularProgressIndicator(),):OrderItem(orderData.orders[i]);
      },),
      drawer: AppDrawer(),
    );
  }
}
