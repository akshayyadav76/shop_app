import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Product.dart';
import '../providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit_product_screen";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _focuse = FocusNode();
  final _descriptionFocus = FocusNode();
  final _editController = TextEditingController();
  final _imageUrl = FocusNode();
  final _formkey = GlobalKey<FormState>();

  /// this is the end i have to fix save mathod of form
  var _editedProdcut = Product(
    id: null,
    title: "",
    price: 0.0,
    description: "",
    imageUrl: "",
  );
  var isInit = true;
  var isProgress = false;

  var _productMap = {
    "title": "",
    "description": "",
    "price": "",
    "imageUrl": "",
  };

  @override
  void initState() {
    _imageUrl.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProdcut = Provider.of<Products>(context).findById(productId);
        _productMap = {
          "title": _editedProdcut.title,
          "description": _editedProdcut.description,
          "price": _editedProdcut.price.toString(),
          "imageUrl": "",
        };
        _editController.text = _editedProdcut.imageUrl;
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  void updateImage() {
    if (!_imageUrl.hasFocus) {
      if (_editController.text.isEmpty ||
          (!_editController.text.startsWith("http") &&
              !_editController.text.startsWith("https")) ||
          (!_editController.text.endsWith('png') &&
              !_editController.text.endsWith('jpg') &&
              !_editController.text.endsWith('jpeg'))) {
        return;
      }

      setState(() {});
    }
  }

  Future<void>  _saveForm() async{
    setState(() {
      isProgress = true;
    });

    // Navigator.of(context).pushNamed(UserProductScreen.routeName);
    final isValid = _formkey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formkey.currentState.save();
    if (_editedProdcut.id != null) {
      await Provider.of<Products>(context, listen: false)
          .updateProducts(_editedProdcut.id, _editedProdcut);

      Navigator.of(context).pop();
    } else {
      try{
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editedProdcut);
      }catch(err){
       await showDialog(
            context: context,
            builder: (cont)=>  AlertDialog(
              title: Text("error"),
              content: Text("some thing went wrong"),
              actions: <Widget>[
                FlatButton(
                  child: Text("ok"),
                  onPressed: () {
                    Navigator.of(cont).pop();
                  },
                )
              ],
            )
        );
      }
//      finally{
//        setState(() {
//          isProgress = false;
//        });
//        Navigator.of(context).pop();
//      }
    }
    setState(() {
      isProgress = false;
    });
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _focuse.dispose();
    _descriptionFocus.dispose();
    _editController.dispose();
    _imageUrl.removeListener(updateImage);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: _saveForm)
        ],
      ),
      body: isProgress
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formkey,
              child: ListView(
                padding: EdgeInsets.all(10),
                children: <Widget>[
                  TextFormField(
                    initialValue: _productMap["title"],
                    decoration: InputDecoration(labelText: "title"),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_focuse);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return "enter a title";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedProdcut = Product(
                          id: _editedProdcut.id,
                          title: value,
                          price: _editedProdcut.price,
                          description: _editedProdcut.description,
                          imageUrl: _editedProdcut.imageUrl,
                          isfavorite: _editedProdcut.isfavorite);
                    },
                  ),
                  TextFormField(
                      initialValue: _productMap["price"],
                      decoration: InputDecoration(labelText: "Price"),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _focuse,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descriptionFocus);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "enter a value";
                        }
                        if (double.tryParse(value) == null) {
                          return "enter a number value";
                        }
                        if (double.tryParse(value) <= 0) {
                          return "enter a value grater than 0";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProdcut = Product(
                            id: _editedProdcut.id,
                            title: _editedProdcut.title,
                            price: double.parse(value),
                            description: _editedProdcut.description,
                            imageUrl: _editedProdcut.imageUrl,
                            isfavorite: _editedProdcut.isfavorite);
                      }),
                  TextFormField(
                    initialValue: _productMap["description"],
                    decoration: InputDecoration(labelText: "Description"),
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    focusNode: _descriptionFocus,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "enter a value";
                      }
                      if (value.length < 10) {
                        return "enter a value grater than 10";
                      }
                      // if(double.tryParse(value)<=0){return "enter a value grater than 0";}
                      return null;
                    },
                    onSaved: (value) {
                      _editedProdcut = Product(
                          id: _editedProdcut.id,
                          title: _editedProdcut.title,
                          price: _editedProdcut.price,
                          description: value,
                          imageUrl: _editedProdcut.imageUrl,
                          isfavorite: _editedProdcut.isfavorite);
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1)),
                        margin: EdgeInsets.only(top: 8, right: 10),
                        child: _editController.text.isEmpty
                            ? Center(child: Text("Enter a URL"))
                            : FittedBox(
                                fit: BoxFit.cover,
                                child: Image.network(_editController.text),
                              ),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(labelText: "Image URL"),
                          keyboardType: TextInputType.url,
                          controller: _editController,
                          focusNode: _imageUrl,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "enter a url";
                            }
                            if (!value.startsWith("http") &&
                                !value.startsWith("https")) {
                              return "enter a valid url";
                            }
                            if (!value.endsWith("png") &&
                                !value.endsWith("jpg") &&
                                !value.endsWith("jpeg")) {
                              return "enter a valid url";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _editedProdcut = Product(
                                id: _editedProdcut.id,
                                title: _editedProdcut.title,
                                price: _editedProdcut.price,
                                description: _editedProdcut.description,
                                imageUrl: value,
                                isfavorite: _editedProdcut.isfavorite);
                          },
                          onFieldSubmitted: (value) {
                            _saveForm();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              )),
    );
  }
}
