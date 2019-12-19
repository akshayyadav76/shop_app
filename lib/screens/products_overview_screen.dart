import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/prodcuts_grid.dart';
import '../widgets/badge.dart.dart';
import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../providers/products.dart';

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
  var isinit =true;
  var isLoading = false;
  @override
  void initState() {
    //Provider.of<Products>(context).getData(); don't work here there is no context...works only if lisen false

//        Future.delayed(Duration.zero).then((_){   //it also work for modelsheet and where we need context in inintstate
//      //Provider.of<Products>(context).getData();
//     });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(isinit){
      setState(() {
        isLoading =true;
      });
    Provider.of<Products>(context).getData().then((_){
      setState(() {
        isLoading =false;
      });
    });
    }
    isinit =false;
    super.didChangeDependencies();
  }

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
      body: isLoading ? Center(child: CircularProgressIndicator()):ProdcutGrid(_SelectedFavorites),
      drawer: AppDrawer(),
    );
  }
}
