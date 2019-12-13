import 'package:flutter/material.dart';
import '../screens/order_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(title: Text("hello friernd"),
          automaticallyImplyLeading: false,),

          Divider(),
          ListTile(leading: Icon(Icons.shop),title: Text("shop"),
          onTap: (){
            Navigator.of(context).pushReplacementNamed('/');
          },),

          Divider(),
          ListTile(leading: Icon(Icons.payment),title: Text("payment"),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
            },)
        ],
      ),
    );
  }
}
