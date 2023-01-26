import 'package:flutter/material.dart';

class WordPage extends StatefulWidget {
  @override
  _WordPage createState() => _WordPage();
}

class _WordPage extends State<WordPage>{
  List words = [];
  String input = "";
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text('단어'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showDialog(
              context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  title: Text("add your word"),
                  content: TextField(
                    onChanged: (String value){
                      input = value;
                    },
                  ),
                  actions: <Widget>[
                    FloatingActionButton(onPressed: (){
                      setState(() {
                        words.add(input);
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text("Add"),),
                  ],
                );
              }
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      body: ListView.builder(
          itemCount: words.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(	// 삭제 버튼 및 기능 추가
                key: Key(words[index]),
                child: Card(
                    elevation: 4,
                    margin: EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(borderRadius:
                    BorderRadius.circular(8)
                    ),
                    child: ListTile(
                      title: Text(words[index]),
                      trailing: IconButton(icon: Icon(
                          Icons.delete,
                          color: Colors.red
                      ),
                          onPressed: () {
                            setState(() {
                              words.removeAt(index);
                            });
                          }),
                    )
                ));
          }),
    );
  }
}