import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Product.dart';

class Products with ChangeNotifier{
static const url="https://fir-9a1fe.firebaseio.com/products.json";

  List<Product> _items = [

    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
      'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
      'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];


  List<Product> get items{
    return [..._items];
  }

    List<Product> get favoritesItems{
    return _items.where((prots)=>prots.isfavorite).toList();
    }

  Product findById(String id){
   return _items.firstWhere((list)=>list.id ==id);
  }

  Future<void> getData()async{
    try{

    final getresponse=await http.get(url);
    print(json.decode(getresponse.body));
    final extractedData=json.decode(getresponse.body) as Map<String,dynamic> ;

  }catch(er){
      throw er;
    }
  }

  Future<void> addProduct(Product productt)async{


    try {

      final response = await http.post(url, body: json.encode({
        "title": productt.title,
        "description": productt.description,
        "price": productt.price,
        "imageUrl": productt.imageUrl,
        "IsFavorite": productt.isfavorite
      }));
      print(json.decode(response.body));
      final _enterNewProduct= Product(
        title: productt.title,
        imageUrl: productt.imageUrl,
        description: productt.description,
        price: productt.price,
        id: json.decode(response.body)['name'],
      );
      _items.add(_enterNewProduct);
      // _items.insert(0, _enterNewProduct) at 0 intex will added
      notifyListeners();
    }catch(error){
      print(error);
      throw error;
    }




   //return Future.value();


  }

  void updateProducts(String id,Product newProcut){
    final productIndex=items.indexWhere((te){return te.id ==id;});
    if(productIndex>=0){
      _items[productIndex] =newProcut;
      notifyListeners();
    }else{
      print("dd");
    }

  }

  void deleteProduct(String id){
    _items.removeWhere((dd){return dd.id ==id;});
    notifyListeners();
  }
}