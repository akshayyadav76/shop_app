import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/prodcuts_grid.dart';
import '../widgets/badge.dart.dart';
import '../providers/cart.dart';
import '../screens/cart_screen.dart';

enum filterOptions {
  favorites,
  all,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _SelectedFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("shop app"),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) =>
            [
              PopupMenuItem(
                child: Text("only favorites"),
                value: filterOptions.favorites,
              ),
              PopupMenuItem(
                child: Text("Show All"),
                value: filterOptions.all,
              ),
            ],
            onSelected: (filterOptions filterValue) {
              setState(() {
                if (filterValue == filterOptions.favorites)
                  _SelectedFavorites = true;
                else {
                  _SelectedFavorites = false;
                }
              });
            },
          ),
          Consumer<Cart>(
            builder: (_, cartData, ch) =>
                Badge(
                  child:ch,
                  value: cartData.cartCount.toString(),
                ),
            child:  IconButton(icon: Icon(Icons.shopping_cart), onPressed:(){
              Navigator.of(context).pushNamed(CartScreen.cartRoute);
            },)
          ),
        ],
      ),
      body: ProdcutGrid(_SelectedFavorites),
    );
  }
}
