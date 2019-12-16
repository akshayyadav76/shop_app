import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
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
  var _editedProdcut =
      Product(id: null, title: "", price: 0.0, description: "", imageUrl: "",);

  @override
  void initState() {
    _imageUrl.addListener(updateImage);
  }

  void updateImage() {
    if (!_imageUrl.hasFocus) {
      if(_editController.text.isEmpty || (!_editController.text.startsWith("http")
        && !_editController.text.startsWith("https"))||
          (!_editController.text.endsWith('png')&&!_editController.text.endsWith('jpg')
              &&!_editController.text.endsWith('jpeg'))
      )
      {return; }

      setState(() {
      });
    }
  }

  void _saveForm() {
    final isValid=_formkey.currentState.validate();
    if(!isValid){return;}
    _formkey.currentState.save();

    Provider.of<Products>(context,listen: false).addProduct(_editedProdcut);
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
      body: Form(
          key: _formkey,
          child: ListView(
            padding: EdgeInsets.all(10),
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: "title"),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_focuse);
                },
                validator: (value){
                  if(value.isEmpty){
                    return "enter a title";}
                  return null;
                },
                onSaved: (value){
                  _editedProdcut =Product(
                    id: _editedProdcut.id,
                    title: value,
                    price: _editedProdcut.price,
                    description : _editedProdcut.description,
                    imageUrl: _editedProdcut.imageUrl
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Price"),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _focuse,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
                  validator: (value){
                  if(value.isEmpty){return "enter a value";}
                  if(double.tryParse(value)==null){return "enter a number value";}
                  if(double.tryParse(value)<=0){return "enter a value grater than 0";}
                  return null;
                  },
    onSaved: (value) {
      _editedProdcut = Product(
          id: _editedProdcut.id,
          title: _editedProdcut.title,
          price: double.parse(value),
          description: _editedProdcut.description,
          imageUrl: _editedProdcut.imageUrl
      );
    }),
              TextFormField(
                decoration: InputDecoration(labelText: "Description"),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                focusNode: _descriptionFocus,
                validator: (value){
                  if(value.isEmpty){return "enter a value";}
                  if(value.length <10){return "enter a value grater than 10";}
                 // if(double.tryParse(value)<=0){return "enter a value grater than 0";}
                  return null;
                },
                onSaved: (value){
                  _editedProdcut =Product(
                      id: _editedProdcut.id,
                      title: _editedProdcut.title,
                      price: _editedProdcut.price,
                      description : value,
                      imageUrl: _editedProdcut.imageUrl
                  );
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
                      validator: (value){
                        if(value.isEmpty){return "enter a url";}
                        if(!value.startsWith("http")&& !value.startsWith("https"))
                        {return "enter a valid url";}
                        if(!value.endsWith("png")&& !value.endsWith("jpg")&&!value.endsWith("jpeg"))
                        {return "enter a valid url";}
                        return null;
                      },
                      onSaved: (value){
                        _editedProdcut =Product(
                            id: _editedProdcut.id,
                            title: _editedProdcut.title,
                            price: _editedProdcut.price,
                            description : _editedProdcut.description,
                            imageUrl: value,
                        );
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
