import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Product.dart';
import '../models/http_exception.dart';


class Products with ChangeNotifier{


  List<Product> _items = [

//    Product(
//      id: 'p1',
//      title: 'Red Shirt',
//      description: 'A red shirt - it is pretty red!',
//      price: 29.99,
//      imageUrl:
//      'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
//    ),
//    Product(
//      id: 'p2',
//      title: 'Trousers',
//      description: 'A nice pair of trousers.',
//      price: 59.99,
//      imageUrl:
//      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
//    ),
//    Product(
//      id: 'p3',
//      title: 'Yellow Scarf',
//      description: 'Warm and cozy - exactly what you need for the winter.',
//      price: 19.99,
//      imageUrl:
//      'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
//    ),
//    Product(
//      id: 'p4',
//      title: 'A Pan',
//      description: 'Prepare any meal you want.',
//      price: 49.99,
//      imageUrl:
//      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
//    ),
  ];
  String token;
  final String userId;

Products(this.token,this.userId,this._items,);

  List<Product> get items{
    return [..._items];
  }

    List<Product> get favoritesItems{
    return _items.where((prots)=>prots.isfavorite).toList();
    }

  Product findById(String id){
   return _items.firstWhere((list)=>list.id ==id);
  }

  Future<void> getData([bool firlterByUser =false])async{
    final filerUrl =firlterByUser?'orderBy="creater"&equalTo="$userId"':'';
 var  url='https://fir-9a1fe.firebaseio.com/products.json?auth=$token&$filerUrl';

   // https://fir-9a1fe.firebaseio.com/products/-LwMav6Rcg9cpPMpEkNu/creater
    //print("wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww$url");

    try{
    final getresponse=await http.get(url);
    //print('AAAAAAAAAAAAAAAAAAAAAAAA${json.encode(getresponse.body)}');
    final extractedData=json.decode(getresponse.body) as Map<String,dynamic> ;
    if(extractedData==null){return;
    }
    print(extractedData);
    url ="https://fir-9a1fe.firebaseio.com/userFavorites/$userId.json?auth=$token";
   final favoritResponse= await http.get(url);
   final favoritData=json.decode(favoritResponse.body);
    final List<Product> LoadedList =[];

    extractedData.forEach((productId,productData){
     /// getProduct = Products()
      LoadedList.add(Product(
        id: productId,
        title: productData['title'],
        description: productData['description'],
        price: productData['price'],
        imageUrl: productData['imageUrl'],
        isfavorite: favoritData == null?false:favoritData[productId]??false
      ));
    });
    _items= LoadedList;
    print(LoadedList);
    notifyListeners();
  }catch(er){
      throw er;
    }
  }

  Future<void> addProduct(Product productt)async{
    final url="https://fir-9a1fe.firebaseio.com/products.json?auth=$token";

    try {

      final response = await http.post(url, body: json.encode({
        "title": productt.title,
        "description": productt.description,
        "price": productt.price,
        "imageUrl": productt.imageUrl,
        'creater': userId
        //"IsFavorite": productt.isfavorite
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

  Future<void> updateProducts(String id,Product newProcut) async{

    final productIndex=items.indexWhere((te){return te.id ==id;});
    if(productIndex>=0){
      final url="https://fir-9a1fe.firebaseio.com/products/$id.json?auth=$token";
     await http.patch(url,body: json.encode({
        "title": newProcut.title,
        "description": newProcut.description,
        "price": newProcut.price,
        "imageUrl": newProcut.imageUrl,
       // "IsFavorite": newProcut.isfavorite
      }));
      _items[productIndex] =newProcut;
      notifyListeners();
      print("blanck screen");
    }else{
      print("dd");
    }

  }

  Future<void> deleteProduct(String id)async{
    //optimastic updating
    // error status code server sent back send code
    // 200 201 everyting is right
    //300 you were redericted 400 something is wrong

    final url="https://fir-9a1fe.firebaseio.com/products/$id.json?auth=$token";
    final exeistingProductIndex =_items.indexWhere((dd){return dd.id ==id;});
    var exstingProduct =_items[exeistingProductIndex];
    _items.removeAt(exeistingProductIndex);
    notifyListeners();

    final reponse= await http.delete(url);
      if(reponse.statusCode>=400) {
        _items.insert(exeistingProductIndex, exstingProduct);
        notifyListeners();
        throw HttpException("could not delete product");
      }
      exstingProduct=null;

  }
}