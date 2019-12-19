import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';


import 'cart.dart';

class OrderItem{
  final String id;
  final double price;
  final List<CartItem> products;
  final DateTime  dateTime;

  OrderItem({this.id,this.price,this.products,this.dateTime});



}
class Order with ChangeNotifier {

  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }


  Future<void> fetchSetOrders()async{
    final url="https://fir-9a1fe.firebaseio.com/order.json";
    final respons = await http.get(url);
    final List<OrderItem> loadorders =[];
    final extractedData = json.decode(respons.body) as Map<String ,dynamic>;
    if(extractedData==null){
      return;
    }
    extractedData.forEach((prodcutId,productData){
      loadorders.add(OrderItem(
        id: prodcutId,
        price: productData['price'],
        dateTime: DateTime.parse(productData['dateTime'],),
        products: (productData['products'] as List<dynamic>).map((s){
          return CartItem(
            id: s['id'],
            price: s['price'],
            title: s['title'],
           quantity: s['quantity'],
          );
        }).toList()
      ));
    });
    _orders =loadorders;
    notifyListeners();

  }


  Future<void> add(List<CartItem>cartProducts, double total) async{

      final timeStamp =DateTime.now();
    final url="https://fir-9a1fe.firebaseio.com/order.json";
   final reponse= await http.post(url,body: json.encode({
      'price': total,
      'dateTime': timeStamp.toIso8601String(),
      'products':cartProducts.map((ss){
        return {
    "id": ss.id,
    "title": ss.title,
    "price": ss.price,
    "quantity": ss.quantity,
    };
      }).toList()
    }));
    _orders.insert(0, OrderItem(
      id: json.decode(reponse.body)['name'],
      price: total,
      dateTime: timeStamp,
      products: cartProducts,
    ));
  }



}