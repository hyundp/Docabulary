import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class SentencePage extends StatefulWidget {
  @override
  _SentencePage createState() => _SentencePage();
}

class _SentencePage extends State<SentencePage>{
  List sentence = [];
  List interpret = [];
  String inputEng = "";
  String inputKor = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    initData();
  }

  void initData() async {
    var s_result = await readFile('sentence');
    var i_result = await readFile('interpret');

    setState(() {
      sentence.addAll(s_result);
      interpret.addAll(i_result);
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('문장 목록'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
              context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  title: Text("add your sentence"),
                  content: Form(
                    key: this.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          autovalidateMode: AutovalidateMode.always,
                          decoration: InputDecoration(hintText: '문장'),
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
                          decoration: InputDecoration(hintText: '해석'),
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
                        writeFile('sentence', inputEng);
                        writeFile('interpret', inputKor);
                        setState(() {
                          sentence.add(inputEng);
                          interpret.add(inputKor);
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
          itemCount: sentence.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
                key: Key(sentence[index]),
                child: Card(
                    elevation: 4,
                    margin: EdgeInsets.all(7),
                    shape: RoundedRectangleBorder(borderRadius:
                    BorderRadius.circular(8)
                    ),
                    child: ListTile(
                      title: Text(sentence[index]),
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
                                    child: Center(
                                      child: SingleChildScrollView(
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(interpret[index],
                                                    style: TextStyle(fontSize: 27),
                                                    textAlign: TextAlign.center
                                                )
                                              ]
                                          )
                                      ),
                                    )
                                ),
                                Positioned(
                                  top: 0,
                                  right:0,
                                  child: Image.asset('image/book_turtle.png', width: 50, height: 50,),
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
                            String w = sentence[index];
                            deleteFile('sentence', w);
                            String m = interpret[index];
                            deleteFile('interpret', m);
                            setState(() {
                              sentence.remove(w);
                              interpret.remove(m);
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