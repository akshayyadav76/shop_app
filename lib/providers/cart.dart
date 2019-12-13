import 'package:flutter/foundation.dart';

class CartItem {
  @required
  final String id;
  @required
  final String title;
  @required
  final int quantity;
  @required
  final double price;

  CartItem({this.id, this.title, this.quantity, this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _cartaItems={};

  Map<String, CartItem> get cartItems{
    return _cartaItems;
}

void deleteCart(String id){
    _cartaItems.remove(id);
    notifyListeners();
}

double get totalAmount{
    var total =0.0;
   _cartaItems.forEach((di,cartitems){
      total +=cartitems.price*cartitems.quantity;
    });return total;
}

   int get cartCount  {
    return _cartaItems.length;
}

void cartClear(){
    _cartaItems={};
    notifyListeners();
}

  void addCart(String id, String title, double price) {
    if (_cartaItems.containsKey(id)) {
      _cartaItems.update(id, (exitingCartItems) =>
          CartItem(id: exitingCartItems.id,
              title: exitingCartItems.title,
              price: exitingCartItems.price,
              quantity: exitingCartItems.quantity + 1));
    } else {
      _cartaItems.putIfAbsent(
          id,
              () =>
              CartItem(
                  id: DateTime.now().toString(),
                  title: title,
                  price: price,
                  quantity: 1));
    }
    notifyListeners();
  }
}
