import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

enum authMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = "/authoScreen";

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

//   final tranform =Matrix4.rotationZ(-8*pi/180);
//   tranform.translate(-10.0);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 1),
                  Color.fromRGBO(255, 188, 177, 1)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                //stops: [0,1]
              ),
            ),
          ),
          SingleChildScrollView(

            child: Container(

              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
                      transform: Matrix4.rotationZ(-8 * pi / 180)
                        ..translate(-10.0),
                      //..cascade operator
                      //padding: EdgeInsets.symmetric(),
                      child: Text(
                        "Shop",
                        style: TextStyle(
                            fontSize: 30, ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.deepOrange.shade600,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black,
                                blurRadius: 8,
                                offset: Offset(0, 4)),
                            //BoxShadow(color: Colors.blue,blurRadius: 8,offset: Offset(0,4)),
                          ]),
                    ),
                  ),

                  Flexible(
                    flex: deviceSize.width>600 ? 2:1,
                  child: AuthCard(),
                  ),


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {

  authMode _mode =authMode.Login;

  final GlobalKey<FormState> key=GlobalKey();

  Map<String,String>credentials={
    'email':'',
    'password':"",
};
  var _isLoading=false;
  final _passwordControler =TextEditingController();


  Future<void> _sumbit()async{
    if(!key.currentState.validate()){
      return ;
    }
    key.currentState.save();
    setState(() {
      _isLoading =true;
    });
    if(_mode ==authMode.Login){

    }else{
      print(credentials["email"]);
      await Provider.of<Auth>(context,listen: false).signup(credentials['email'], credentials['password']);
    }
    setState(() {
      _isLoading =false;
    });

  }

  void _switchMode(){
    if(_mode ==authMode.Login){
      setState(() {
        _mode =authMode.Signup;
      });
    }else{
      setState(() {
        _mode =authMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize=MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(

        height: _mode ==authMode.Signup ? 800: 800,

        constraints: BoxConstraints(
          minHeight: _mode ==authMode.Signup? 800: 800,
        ),
        width: deviceSize.width*0.85,
        padding: EdgeInsets.all(16),

        child: Form(
          key: key,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'e-mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value){
                    if(value.isEmpty||!value.contains('@')){
                      return "invalid email";
                    }
                    return null;
                  },
                  onSaved: (value){
                    credentials['email']=value;
                  },
                ),

                TextFormField(
                  decoration: InputDecoration(labelText: 'password'),
                  //keyboardType: TextInputType.number,
                  obscureText: true,
                  controller: _passwordControler,
                  validator: (value){
                    if(value.isEmpty|| value.length <5){
                      return "invalid password or short";
                    }
                    return null;
                  },
                  onSaved: (value){
                    credentials['password']=value;
                  },
                ),

                if(_mode==authMode.Signup)
                  TextFormField(
                    enabled: _mode==authMode.Signup,
                    decoration: InputDecoration(
                      labelText: 'confirm password',
                    ),
                    validator: _mode==authMode.Signup?(value){
                      if(value !=_passwordControler.text){
                        return "password do not match";
                      }
                      return null;
                    }:null,
                  ),
                SizedBox(height: 20,),

                if(_isLoading)
                  CircularProgressIndicator()
                else RaisedButton(
                  child: Text(_mode==authMode.Login ?"login":"sing up"),
                onPressed: _sumbit,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
                ),
                  padding: EdgeInsets.symmetric(horizontal: 30.0,vertical: 8.0),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).primaryTextTheme.button.color,
                ),
                FlatButton(
                  child: Text("${_mode==authMode.Login ?"sing up":"login"} insted",
                    style: TextStyle(color: Colors.blue),),
                  onPressed: _switchMode,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

                )
              ],
            )
          ),
        ),
      ),
    );
  }
}

