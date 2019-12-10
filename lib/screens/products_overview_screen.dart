import 'package:flutter/material.dart';


import '../widgets/prodcuts_grid.dart';


class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("shop app"),
      ),
      body: ProdcutGrid(),
    );
  }
}
