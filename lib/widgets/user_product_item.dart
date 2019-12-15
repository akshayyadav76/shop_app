import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {

  final String title;
  final String imageUrl;

  UserProductItem(this.title,this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return  ListTile(
        title: Text(title),
        leading: CircleAvatar(child: Image.network(imageUrl),),
        trailing: Container(
          width: 100,
          child: Row(
              children: <Widget>[
                IconButton(icon: Icon(Icons.edit),onPressed: (){},),
                IconButton(icon: Icon(Icons.delete),onPressed: (){},)
              ]
          ),
        ),

    );
  }
}
