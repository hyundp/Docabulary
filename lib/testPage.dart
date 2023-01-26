import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPage createState() => _TestPage();
}

class _TestPage extends State<TestPage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text('시험'),
        ),
        body: Container(
            child: const Center(
              child: Text('Test Page'),
            )
        )
    );
  }
}

