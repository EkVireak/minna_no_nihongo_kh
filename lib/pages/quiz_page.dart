import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'package:minna_no_nihongo_quiz/ui_elements/gridbox_element.dart';
import 'package:minna_no_nihongo_quiz/pages/quiz_single_page.dart';



class QuizPage extends StatefulWidget{
  final String weapon;
  QuizPage({Key key, this.weapon}) : super(key:key);
  
  @override
  _QuizPageState createState() => _QuizPageState();
}
class _QuizPageState extends State<QuizPage>{
  final childGrid = <Widget>[];
  final childGrid2 = <Widget>[];
  final childBody = <Widget>[];
  void wordCallback(int key) async{
    // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>QuizSinglePage(weapon: widget.weapon, lesson: key, assetFile: "assets/data/word_lesson_$key.json",)));
    var assetFile = "assets/data/word_lesson_$key.json";
    String data = await DefaultAssetBundle.of(context).loadString(assetFile);
    List jsonResult = json.decode(data.toString());
    int qLength = jsonResult.length;
    _dialogChooseLength(Text("Choose Length"), qLength, (qaLength){Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>QuizSinglePage(weapon: widget.weapon, qaLength: qaLength, jsonData: jsonResult, isListening: false, keyNum: key,)));});
  }
  @override
  void initState() {    
    initFuncs();
    super.initState();
  }
  void initFuncs() async{
    if(widget.weapon=="word"){
      for(var i = 1; i <=25; i++) {
        childGrid.add(GridboxElement(()=>{wordCallback(i)}, "មេរៀនទី $i", "だい $i か", "", Icons.library_books, Colors.pinkAccent[100]));
      }
      childBody.add(
        Expanded(
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(10.0),
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 2.0,
            crossAxisCount: 3,
            children: childGrid
          ),
        )
      );
    }
    else{
      childGrid.add(GridboxElement(()=>{kanaCallback(1, false)}, "មូលដ្ឋាន", "${widget.weapon=='hiragana'?'ひらがな':'からかな'}", "${widget.weapon}", Icons.description, Colors.pinkAccent[100]));
      childGrid.add(GridboxElement(()=>{kanaCallback(2, false)}, "សម្លេងធ្ងន់", "${widget.weapon=='hiragana'?'ひらがな':'からかな'}", "${widget.weapon}", Icons.description, Colors.pinkAccent[100]));
      childGrid.add(GridboxElement(()=>{kanaCallback(3, false)}, "អក្សរផ្សំ", "${widget.weapon=='hiragana'?'ひらがな':'からかな'}", "${widget.weapon}", Icons.description, Colors.pinkAccent[100]));
      childGrid.add(Container());
      childGrid.add(GridboxElement(()=>{kanaCallback(0, false)}, "ចម្រុះ", "${widget.weapon=='hiragana'?'ひらがな':'からかな'}", "${widget.weapon}", Icons.description, Colors.pinkAccent[100]));
      
      // childGrid2.add(GridboxElement(()=>{kanaCallback(1, true)}, "មូលដ្ឋាន", "${widget.weapon=='hiragana'?'ひらがな':'からかな'}", "${widget.weapon}", Icons.description, Colors.pinkAccent[100]));
      // childGrid2.add(GridboxElement(()=>{kanaCallback(2, true)}, "សម្លេងធ្ងន់", "${widget.weapon=='hiragana'?'ひらがな':'からかな'}", "${widget.weapon}", Icons.description, Colors.pinkAccent[100]));
      // childGrid2.add(GridboxElement(()=>{kanaCallback(3, true)}, "អក្សរផ្សំ", "${widget.weapon=='hiragana'?'ひらがな':'からかな'}", "${widget.weapon}", Icons.description, Colors.pinkAccent[100]));

      // childBody.add(
      //   Card(
      //     child: Container(
      //       alignment: Alignment.center,
      //       padding: EdgeInsets.all(5),
      //       child: Text("អក្សរ", style: TextStyle(fontSize: 20),),
      //     ),
      //   ),
      // );
      childBody.add(
        Expanded(
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(10.0),
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 2.0,
            crossAxisCount: 3,
            children: childGrid,
            // physics: NeverScrollableScrollPhysics(),
          ),
        )
      );
      // childBody.add(
      //   Card(
      //     child: Container(
      //       alignment: Alignment.center,
      //       padding: EdgeInsets.all(5),
      //       child: Text("ស្ដាប់", style: TextStyle(fontSize: 20),),
      //     ),
      //   ),
      // );
      // childBody.add(
      //   Expanded(
      //     child: GridView.count(
      //       primary: false,
      //       padding: const EdgeInsets.all(10.0),
      //       crossAxisSpacing: 2.0,
      //       mainAxisSpacing: 2.0,
      //       crossAxisCount: 3,
      //       children: childGrid2,
      //       // physics: NeverScrollableScrollPhysics(),
      //     ),
      //   )
      // );
    }
  }
  void kanaCallback(int key, bool isListening) async{
    List jsonResult = [];
    var assetFile;
    if(key == 0){
      for(var i=1; i<=3; i++){
        assetFile = "assets/data/kana$i.json";
        String data = await DefaultAssetBundle.of(context).loadString(assetFile);
        List jsonResultDraft = json.decode(data.toString());
        // jsonResult.add(jsonResultDraft.toString());
        jsonResult..addAll(jsonResultDraft);
      }
    }
    else{
      assetFile = "assets/data/kana$key.json";
      String data = await DefaultAssetBundle.of(context).loadString(assetFile);
      jsonResult = json.decode(data.toString());
    }
    int qLength = jsonResult.length;
    _dialogChooseLength(Text("រើសចំនួន"), qLength, (qaLength){Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>QuizSinglePage(weapon: widget.weapon, qaLength: qaLength, jsonData: jsonResult, isListening: isListening, keyNum: key,)));});
  }
  Future<Null> _dialogChooseLength(Widget widgetTitle, int maxLength, callback(qaLength)) async {
    List<Widget> simpleDialogOption = [];
    String subfix= "ពាក្យ";
    if(widget.weapon != "word"){
      subfix= "អក្សរ";
    }
    if(maxLength>0){
      int l = 0;
      if(maxLength<=10){
        l = maxLength;
        simpleDialogOption.add(
          SimpleDialogOption(
            onPressed: () { Navigator.pop(context, l); },
            child: Container(decoration:BoxDecoration(border: Border.all(color: Colors.pinkAccent[100]),), child: Padding(
              child: Text("$l $subfix"),
              padding: EdgeInsets.all(10.0),),),
          )
        );
      }
      else{
        l = 10;
        simpleDialogOption.add(
          SimpleDialogOption(
            onPressed: () { Navigator.pop(context, 10); },
            child: Container(decoration:BoxDecoration(border: Border.all(color: Colors.pinkAccent[100]),), child: Padding(
              child: Text("$l $subfix"),
              padding: EdgeInsets.all(10.0),),),
          )
        );
        if(maxLength<=25){
          l = maxLength;
          simpleDialogOption.add(
            SimpleDialogOption(
              onPressed: () { Navigator.pop(context, l); },
              child: Container(decoration:BoxDecoration(border: Border.all(color: Colors.pinkAccent[100]),), child: Padding(
                child: Text("$l $subfix"),
                padding: EdgeInsets.all(10.0),),),
            )
          );
        }
        else{
          l = 25;
          simpleDialogOption.add(
            SimpleDialogOption(
              onPressed: () { Navigator.pop(context, 25); },
              child: Container(decoration:BoxDecoration(border: Border.all(color: Colors.pinkAccent[100]),), child: Padding(
                child: Text("$l $subfix"),
                padding: EdgeInsets.all(10.0),),),
            )
          );
          if(maxLength<=50){
            l = maxLength;
            simpleDialogOption.add(
              SimpleDialogOption(
                onPressed: () { Navigator.pop(context, l); },
                child: Container(decoration:BoxDecoration(border: Border.all(color: Colors.pinkAccent[100]),), child: Padding(
                  child: Text("$l $subfix"),
                  padding: EdgeInsets.all(10.0),),),
              )
            );
          }
          else{
            l = 50;
            simpleDialogOption.add(
              SimpleDialogOption(
                onPressed: () { Navigator.pop(context, 50); },
                child: Container(decoration:BoxDecoration(border: Border.all(color: Colors.pinkAccent[100]),), child: Padding(
                  child: Text("$l $subfix"),
                  padding: EdgeInsets.all(10.0),),),
              )
            );
            if(maxLength<=75){
              l = maxLength;
              simpleDialogOption.add(
                SimpleDialogOption(
                  onPressed: () { Navigator.pop(context, l); },
                  child: Container(decoration:BoxDecoration(border: Border.all(color: Colors.pinkAccent[100]),), child: Padding(
                    child: Text("$l $subfix"),
                    padding: EdgeInsets.all(10.0),),),
                )
              );
            }
            else{
              l = 75;
              simpleDialogOption.add(
                SimpleDialogOption(
                  onPressed: () { Navigator.pop(context, 75); },
                  child: Container(decoration:BoxDecoration(border: Border.all(color: Colors.pinkAccent[100]),), child: Padding(
                    child: Text("$l $subfix"),
                    padding: EdgeInsets.all(10.0),),),
                )
              );
            }
            if(maxLength>75){
              l = maxLength;
              simpleDialogOption.add(
                SimpleDialogOption(
                  onPressed: () { Navigator.pop(context, l); },
                  child: Container(decoration:BoxDecoration(border: Border.all(color: Colors.pinkAccent[100]),), child: Padding(
                    child: Text("$l $subfix"),
                    padding: EdgeInsets.all(10.0),),),
                )
              );
            }
          }
        }
      }
    }//if
    var qaLength = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: widgetTitle,
          children: simpleDialogOption
        );
      }
    );
    print(qaLength);
    if(qaLength!=null){
      if(qaLength>0){
        callback(qaLength);
      }
    }
  }//Future<Null> _dialogChooseLength
  
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("សំនួរ ${widget.weapon=='word'?'ពាក្យ':widget.weapon}"),
        backgroundColor: Colors.pinkAccent[100],
      ),
      backgroundColor: Colors.pink[100],
      body: Center(
        child: Column(
          children: childBody,
        )
      )
    );
  }
}//class _QuizPageState