import 'package:flutter/material.dart';

class WordPage extends StatefulWidget {
  @override
  _WordPage createState() => _WordPage();
}

class _WordPage extends State<WordPage>{
  List words = [];
  List meaning = [];
  String inputEng = "";
  String inputKor = "";
  final formKey = GlobalKey<FormState>();
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
                  content: Form(
                    key: this.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          autovalidateMode: AutovalidateMode.always,
                          decoration: InputDecoration(hintText: '단어'),
                          onSaved: (value){
                            setState((){
                              inputEng = value as String;
                            });
                          },
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return '필수사항입니다';
                            }
                          },
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.always,
                          decoration: InputDecoration(hintText: '뜻'),
                          onSaved: (value){
                            setState((){
                              inputKor = value as String;
                            });
                          },
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return '필수사항입니다';
                            }
                          },
                        )
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    FloatingActionButton(onPressed: (){
                      if (this.formKey.currentState!.validate()){
                        this.formKey.currentState!.save();
                        setState(() {
                          words.add(inputEng);
                          meaning.add(inputKor);
                        });
                        Navigator.of(context).pop();
                      }

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
            return Dismissible(
                key: Key(words[index]),
                child: Card(
                    elevation: 4,
                    margin: EdgeInsets.all(7),
                    shape: RoundedRectangleBorder(borderRadius:
                    BorderRadius.circular(8)
                    ),
                    child: ListTile(
                      title: Text(words[index]),
                      onTap: ()=> showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colors.transparent,
                          insetPadding: EdgeInsets.all(10),
                          content: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: 300,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.lightGreen,
                                ),
                                padding: EdgeInsets.fromLTRB(20, 110, 20, 20),
                                child: Column(
                                  children: [
                                    Text(meaning[index],
                                      style: TextStyle(fontSize: 36),
                                        textAlign: TextAlign.center
                                    )
                                  ]
                                )
                              ),
                              Positioned(
                                top: 0,
                                left:0,
                                child: Image.asset('image/light_purple_butterfly.png', width: 50, height: 50,),
                              )
                            ],
                          ),
                        )
                      ),
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