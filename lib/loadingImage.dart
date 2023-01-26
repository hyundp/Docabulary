import 'dart:async';
import 'package:flutter/material.dart';
import 'main.dart';
import 'mainPage.dart';

class LoadingImagePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _LoadingImagePage();
  }
}

class _LoadingImagePage extends State<LoadingImagePage>{
  @override
  void initState() {
    Timer(Duration(milliseconds: 5000), () {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) => MyHomePage(title: 'Doca')),
          (route) => false,
      );
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Loading'),),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('image/logo7.png', width: 200, height: 100,),
              const Text(
                "Docabulary",
                textAlign: TextAlign.center,
                style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 30,
                fontFamily: 'Pacifico'
              )
              )
            ],
          )
        )
      )
    );
  }

}