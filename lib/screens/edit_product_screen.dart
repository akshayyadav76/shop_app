import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "/edit_product_screen";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _focuse = FocusNode();
  final _descriptionFocus = FocusNode();
  final _editController = TextEditingController();
  final _imageUrl=FocusNode();
  final _formkey =GlobalKey<FormState>();/// this is the end i have to fix save mathod of form


  @override
  void initState() {
    _imageUrl.addListener(updateImage);

  }

  void updateImage(){
    if(!_imageUrl.hasFocus){
      setState(() {});
    }
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
        actions: <Widget>[IconButton(icon: Icon(Icons.save),onPressed: (){},)],
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
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Price"),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            focusNode: _focuse,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_descriptionFocus);
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Description"),
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            focusNode: _descriptionFocus,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                height: 100,
                width: 100,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey,width: 1)),
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
                  onFieldSubmitted: (value){

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
