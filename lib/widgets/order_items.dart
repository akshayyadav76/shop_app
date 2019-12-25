import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart' as or;

class OrderItem extends StatefulWidget {
  final or.OrderItem order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool isExpand =false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInBack,
      height: isExpand? min(widget.order.products.length*20.0+110,200):94,

      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ListTile(title: Text("\$${widget.order.price}"),
            subtitle: Text(DateFormat("dd-mm-yyyy").format(widget.order.dateTime)),
            trailing: IconButton(icon: isExpand ?Icon(Icons.expand_less):Icon(Icons.expand_more),
              onPressed: (){
               setState(() {
                 isExpand =!isExpand;
               });
            },),
            ),


              AnimatedContainer(
                duration: Duration(milliseconds: 300),
              height: isExpand? min(widget.order.products.length*20.0+10,100):0,
              child: ListView(
                children: widget.order.products.map((pro)=>Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(pro.title),
                    Text("${pro.quantity}x \$${pro.price}")
                  ],
                )).toList()


              ),
            )

          ],
        ),
      ),
    );
  }
}
