import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:minna_no_nihongo_kh/pages/kana_page.dart';
import 'package:minna_no_nihongo_kh/pages/quiz_page.dart';
import 'package:minna_no_nihongo_kh/ui_elements/gridbox_element.dart';


class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}//class HomePage extends StatefulWidget

class _HomePageState extends State<HomePage>{
  //=========================================
  void getKanaJson() async{
    String data = await DefaultAssetBundle.of(context).loadString("assets/data/kana1.json");
    List jsonResult = json.decode(data.toString());
    String data2 = await DefaultAssetBundle.of(context).loadString("assets/data/kana2.json");
    List jsonResult2 = json.decode(data2.toString());
    String data3 = await DefaultAssetBundle.of(context).loadString("assets/data/kana3.json");
    List jsonResult3 = json.decode(data3.toString());
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>KanaPage(jsonResult, jsonResult2, jsonResult3)));
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: MaterialButton(
          minWidth: 60,
          onPressed: ()=>{Navigator.pushNamed(context, '/about')},
          child: Icon(Icons.info, color: Colors.white,),
        ),
        centerTitle: true,
        title: Text("Minna No Nihongo 1"),
        backgroundColor: Colors.pinkAccent[100],
        elevation: 0.0,
        actions: <Widget>[
          MaterialButton(
            minWidth: 60,
            onPressed: ()=>{Navigator.pushNamed(context, '/result')},
            child: Icon(Icons.receipt, color: Colors.white,),
          ),
        ],
      ),
      backgroundColor: Colors.pink[100],
      body: Center(
        child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(10.0),
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          crossAxisCount: 1,
          childAspectRatio:2/1,
          children: <Widget>[
            GridboxElement(
              ()=>{
                getKanaJson()
                // Navigator.pushNamed(context, '/kana');
              }, 
              "តួអក្សរ", 
              "かな", 
              "kana", 
              Icons.description, 
              Colors.pinkAccent[100]
            ),
            GridboxElement(()=>{Navigator.pushNamed(context, '/lessons')}, "មេរៀន", "レッスン", "ressun", Icons.library_books, Colors.pinkAccent[100]),
            GridboxElement(()=>{_showQuizDialog()}, "សំនួរ", "クイズ", "kuizu", Icons.speaker_notes, Colors.pinkAccent[100]),
          ],
        ),
      ),
    );
  }
  var widgetTitle = {
    "hiragana":Text.rich(
      TextSpan(
        text: 'ひらがな', // default text style
        children: <TextSpan>[
          TextSpan(text: '\nhiragana', style: TextStyle(fontStyle: FontStyle.italic)),
        ],
      )
    ),
    "katakana":Text.rich(
      TextSpan(
        text: 'からかな', // default text style
        children: <TextSpan>[
          TextSpan(text: '\nkatakana', style: TextStyle(fontStyle: FontStyle.italic)),
        ],
      )
    ),
    "word":Text.rich(
      TextSpan(
        text: 'ពាក្យ', // default text style
        children: <TextSpan>[
          TextSpan(text: '\nことば（言葉）', style: TextStyle(fontStyle: FontStyle.italic)),
          TextSpan(text: '\nkotoba', style: TextStyle(fontStyle: FontStyle.italic)),
        ],
      )
    ),
    "grammar":Text.rich(
      TextSpan(
        text: 'វេយ្យាករណ៍', // default text style
        children: <TextSpan>[
          TextSpan(text: '\nぶんぽう（文法）', style: TextStyle(fontStyle: FontStyle.italic)),
          TextSpan(text: '\nbunpo', style: TextStyle(fontStyle: FontStyle.italic)),
        ],
      )
    ),
    
  };
  Future<void> _showQuizDialog() async {
    switch (await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('រើសជម្រើសខាងក្រោម'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () { Navigator.pop(context, 1); },
              child: Container(decoration:BoxDecoration(border: Border.all(color: Colors.pinkAccent[100]),), child: Padding(
                child: widgetTitle["hiragana"],
                padding: EdgeInsets.all(10.0),),),
            ),
            SimpleDialogOption(
              onPressed: () { Navigator.pop(context, 2); },
              child: Container(decoration:BoxDecoration(border: Border.all(color: Colors.pinkAccent[100]),), child: Padding(
                child: widgetTitle["katakana"],
                padding: EdgeInsets.all(10.0),),),
            ),
            SimpleDialogOption(
              onPressed: () { Navigator.pop(context, 3); },
              child: Container(decoration:BoxDecoration(border: Border.all(color: Colors.pinkAccent[100]),), child: Padding(
                child: widgetTitle["word"],
                padding: EdgeInsets.all(10.0),),),
            ),
          ],
        );
      }
    )) {
      
      case 1:
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>QuizPage(weapon: "hiragana",)));
      break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>QuizPage(weapon: "katakana",)));
      break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>QuizPage(weapon: "word",)));
      break;
    }
  }//showDialog
}//class