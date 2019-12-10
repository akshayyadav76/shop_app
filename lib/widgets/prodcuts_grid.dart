import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/ProductItem.dart';



class ProdcutGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products =productData.items;
    return GridView.builder(
      itemCount: products.length,
      itemBuilder: (context, i)=>ProductItem(
        products[i].id,
        products[i].title,
        products[i].imageUrl,
      ),

      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3/2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
