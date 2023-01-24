import 'package:flutter/material.dart';

class ImageWidgetApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _ImageWidgetApp();
  }
}

class _ImageWidgetApp extends State<ImageWidgetApp>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Image'),),
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