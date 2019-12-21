import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './screens/cart_screen.dart';
import './providers/orders.dart';
import './screens/order_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import  './screens/auth_screen.dart';
import './providers/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers:[
        ChangeNotifierProvider.value(value: Products(),),
        ChangeNotifierProvider.value(value: Cart()),
          ChangeNotifierProvider.value(value: Order(),),
          ChangeNotifierProvider.value(value: Auth())

    ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.deepOrange,
          fontFamily: "Lato",
        ),
        home:  AuthScreen(),                  //ProductOverviewScreen(),
        routes: {
         ProductDetailScreen.routeName :(cont)=>ProductDetailScreen(),
          CartScreen.cartRoute:(context)=>CartScreen(),
          OrderScreen.routeName:(con)=>OrderScreen(),
          UserProductScreen.routeName:(context)=>UserProductScreen(),
          EditProductScreen.routeName:(context)=>EditProductScreen(),
          AuthScreen.routeName:(context)=>AuthScreen(),
        },

      ),
    );
  }
}


