import 'package:flutter/material.dart';

class SentencePage extends StatefulWidget {
  @override
  _SentencePage createState() => _SentencePage();
}

class _SentencePage extends State<SentencePage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text('문장 목록'),
        ),
        body: Container(
            child: const Center(
              child: Text('Sentence Page'),
            )
        )
    );
  }
}

