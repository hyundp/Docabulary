import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

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
  void initState(){
    super.initState();
    initData();
  }

  void initData() async {
    var w_result = await readFile('words');
    var m_result = await readFile('meaning');

    setState(() {
      words.addAll(w_result);
      meaning.addAll(m_result);
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text('단어 목록'),
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
                        writeFile('words', inputEng);
                        writeFile('meaning', inputKor);
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
                                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                        String w = words[index];
                        deleteFile('words', w);
                        String m = meaning[index];
                        deleteFile('meaning', m);
                        setState(() {
                          words.remove(w);
                          meaning.remove(m);
                        });
                          }),
                    )

                ));
          }),
    );
  }

  // 파일 쓰기
  void writeFile(String filename, String value) async {
    var dir = await getApplicationDocumentsDirectory();
    var file = await File(dir.path + '/${filename}.txt').readAsString();
    if (file == null || file.isEmpty){
      file = value;
    }
    else{
      file = file + '\n' + value;
    }
    File(dir.path+ '/${filename}.txt').writeAsStringSync(file);
  }


  //파일 내용 삭제
  void deleteFile(String filename, String value) async {
    var dir = await getApplicationDocumentsDirectory();
    String new_file = '';
    var file = await File(dir.path + '/${filename}.txt').readAsString();
    var array = file.split('\n');
    for (var item in array){
      if (item == value){
        continue;
      }
      if (new_file == null || new_file.isEmpty || new_file == ''){
        new_file = item;
      }
      else{
        new_file = new_file + '\n' + item;
      }
    }
    File(dir.path+ '/${filename}.txt').writeAsStringSync(new_file);
  }

    // 파일 읽기
    Future<List<String>> readFile(String filename) async {
    List<String> res = [];
    var dir = await getApplicationDocumentsDirectory();
    bool fileExist = await File(dir.path +
    '/${filename}.txt').exists();
    if(fileExist == false){
      File(dir.path+ '/${filename}.txt').writeAsStringSync('');
      return res;
    }
    else{
      var file = await File(dir.path + '/${filename}.txt').readAsString();
      if (file == null || file.isEmpty){
        return res;
      }
      var array = file.split('\n');
      for (var item in array){
        res.add(item);
      }
      return res;
    }
  }
}