import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/order_screen.dart';
import '../screens/user_products_screen.dart';
import '../providers/auth.dart';



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
            },),

          Divider(),
          ListTile(leading: Icon(Icons.panorama),title: Text("Mange Products"),
            onTap: (){
              Navigator.of(context).pushReplacementNamed(UserProductScreen.routeName);
            },),
          Divider(),
          ListTile(leading: Icon(Icons.exit_to_app),title: Text("Logout"),
            onTap: (){
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed('/');
           //   Navigator.of(context).pushReplacementNamed(UserProductScreen.routeName);
              Provider.of<Auth>(context,listen: false).logout();
            },),

        ],
      ),
    );
  }
}
