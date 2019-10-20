import 'dart:async';
import 'dart:convert';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:minna_no_nihongo_quiz/functions/datetime_format.dart';
import "dart:math";

import 'package:minna_no_nihongo_quiz/pages/quiz_result_page.dart';
import 'package:sqflite/sqflite.dart';

class QuizSinglePage extends StatelessWidget {
  final String weapon;
  final int lesson;
  final int qaLength;
  final jsonData;
  final bool isListening;
  final keyNum;
  QuizSinglePage({Key key, this.weapon, this.lesson, this.qaLength, this.jsonData, this.isListening, this.keyNum}) : super(key:key);

  @override
  Widget build(BuildContext context){
    return _QuizSinglePage(weapon: this.weapon, lesson: this.lesson, qaLength: this.qaLength, data: this.jsonData, isListening: this.isListening, keyNum: this.keyNum,);
  }

}

class _QuizSinglePage extends StatefulWidget {
  final String weapon;
  final int lesson;
  final data;
  final int qaLength;
  final bool isListening;
  final keyNum;
  _QuizSinglePage({Key key, this.weapon, this.lesson, this.qaLength, this.data, this.isListening, this.keyNum}) : super(key:key);
  @override
  _QuizSinglePageState createState() => _QuizSinglePageState(data, qaLength, isListening, keyNum);
}

class _QuizSinglePageState extends State<_QuizSinglePage> {
  //============================================================
  void _initDB() async{
    try {
      Database db = await openDatabase('minanonihongo.db');
      await db.execute("CREATE TABLE IF NOT EXISTS quizResult (id INTEGER PRIMARY KEY, weapon TEXT, type INTEGER, qa TEXT, numQa INTEGER, numC INTEGER, datetime TEXT)");
    } catch (e) {
      print("error : "+e);
    }
  }
  Future<int> _insertQuizResult(String _table, Map<String, dynamic> value) async{
    Database _db = await openDatabase('minanonihongo.db');
    int insertedId = await _db.insert(_table, value);
    return insertedId;
  }
  //============================================================
  var qaList;
  int qCount;
  final bool isListening;
  final keyNum;
  _QuizSinglePageState(this.qaList, this.qCount, this.isListening, this.keyNum){
    _initDB();
    // print(qCount);
    // print(isListening);
  }
  
  List<String> choiceList = [];
  int qIndex = 0;
  // int qCount = 5;
  int gridCol = 2;
  double gridRatio = 2/1;
  Alignment gridAlignment = Alignment.center;
  double qFontSize = 80;

  List questionList = [];
  List answerList =[];
  List answerChoice = [];
  final _random = new Random();
  //===================================================
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  Timer _timer;
  @override
  void dispose() {
    if( _timer!=null ){
      _timer.cancel();
      _timer = null;
    }
    if( _assetsAudioPlayer!=null )
      _assetsAudioPlayer.stop();
    super.dispose();
  }
  void _play(String kana, key) {
    _assetsAudioPlayer.open(
      AssetsAudio(
        asset: kana+".mp3",
        folder: "assets/track/kana"+key+"/",
      ),
    );
  }
  //===================================================
  void skipQA(){
    answer("");
  }
  void answer(String key){
    setState(() {
      questionList[qIndex]["A"] = key;
      answerList.add(questionList[qIndex]);
      if(qIndex<questionList.length-1){
        qIndex++;
      }
      else{
        int type = keyNum;
        int score = 0;
        for (var item in answerList) {
          if(item["C"] == item["A"]){
            score++;
          }
        }
        Future insertedId = _insertQuizResult('quizResult', {"weapon":widget.weapon, "type":type, "qa":jsonEncode(answerList), "numQa":answerList.length, "numC":score, "datetime":dateFormat(DateTime.now())});
        insertedId.then((value)=>{
          print(value)
        });
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=>QuizResultPage(data: answerList, weapon: widget.weapon, type: keyNum,)));
      }
    });
    prepareQA();
  }
  void prepareQA(){
    setState(() {
      answerChoice.clear();
      answerChoice.add(questionList[qIndex]["C"]);
      if(isListening){
        var _playRoman = questionList[qIndex]["Q"];
        _timer = Timer(new Duration(milliseconds: 500), () {
          if(_playRoman.isEmpty == false)
            _play(_playRoman, keyNum.toString());
        });
      }
      var element;
      for(var i=0; i<3; i++){
        if(isListening){
          if(widget.weapon == "word"){
            element = qaList[_random.nextInt(qaList.length)]["khmer"];
            if(element == ""){
              element = qaList[_random.nextInt(qaList.length)]["english"];
            }
          }          
          else{
            if(widget.weapon == "hiragana")
              element = qaList[_random.nextInt(qaList.length)]["hiragana"];
            else
              element = qaList[_random.nextInt(qaList.length)]["katakana"];
          }
        }
        else{
          if(widget.weapon == "word"){
            element = qaList[_random.nextInt(qaList.length)]["khmer"];
            if(element == ""){
              element = qaList[_random.nextInt(qaList.length)]["english"];
            }
          }          
          else{
            element = qaList[_random.nextInt(qaList.length)]["roman"];
          }
        }

        if(answerChoice.contains(element)){
          i--;
          continue;
        }
        answerChoice.add(element);
      }
      choiceList.clear();
      for(var i=0; i<answerChoice.length; i++){
        element = answerChoice[_random.nextInt(answerChoice.length)];
        if(choiceList.contains(element)){
          i--;
          continue;
        }
        choiceList.add(element);
      } 
    });
  }
  void initQA(){
    answerList.clear();
    questionList.clear();
    answerChoice.clear();
    var element;
    var _element;
    List qaQList = [];
    if(widget.weapon == "word"){
      for(var i=0; i<qCount; i++){
        element = qaList[_random.nextInt(qaList.length)];
        var _q = element["kana"];
        var _k = element["kanji"];
        var _c = element["khmer"];
        if(_c == ""){
          _c = element["english"];
        }
        _element = {"Q":_q, "kanji":_k, "C":_c, "A":""};
        if(qaQList.contains(_q)){
          i--;
        }
        else{
          qaQList.add(_q);
          questionList.add(_element);
        }
      }
    }
    else{
      for(var i=0; i<qCount; i++){
        element = qaList[_random.nextInt(qaList.length)];
        var _q = "";
        if(widget.weapon == "katakana")
          _q = element["katakana"];
        else
          _q = element["hiragana"];

        _element = {"Q":_q, "C":element["roman"], "A":""};
        if(isListening)
          _element = {"Q":element["roman"], "C":_q, "A":""};

        if(qaQList.contains(_q)){
          i--;
        }
        else{
          qaQList.add(_q);
          questionList.add(_element);
        }
      }
    }
    // 
    // for (var item in questionList) {
    //   print(item);
    // }
    print(questionList.toString().length);
    print(questionList.toString());
  }
  String _randomQuote;
  @override
  void initState() {
    _randomQuote = _getRandomQuote();
    if(qCount>qaList.length){
      qCount = qaList.length;
    }

    if(widget.weapon=="word"){
      gridCol = 1;
      gridRatio = 8/1;
      gridAlignment = Alignment.centerLeft;
      qFontSize = 40;
    }
    else{
      gridCol = 2;
      gridRatio = 2/1;
      gridAlignment = Alignment.center;
      qFontSize = 80;
    }
    
    initQA();
    prepareQA();
    super.initState();
  }
  // var choiceList = [
  //   {"value":"test", "name":"name"},
  //   {"value":"test", "name":"name"},
  // ];
  Widget choiceListWidget(String value){
    return Container(
      color: Colors.pinkAccent[100],
      margin: EdgeInsets.all(1.0),
      child: MaterialButton(
        onPressed: (){answer(value);},
        child: Text(value,),
        splashColor: Colors.pinkAccent,
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: WillPopScope(
      // appBar: AppBar(title: Text("Single Quiz Page"),backgroundColor: Colors.pinkAccent[100],),
      // body: Center(child: Column(children: <Widget>[
      //   Text("${widget.weapon}"),
      //   Text("${widget.lesson}"),
      // ],)),
        onWillPop: (){
          return exitQuiz();
        },
        child: Container(
          // color: Colors.pink[100],
          child: Column(          
            children: <Widget>[
              Container(
                height: 24,
                color: Colors.pinkAccent[100],
                child: Center(
                  child: Column(
                    
                  ),
                )
              ),
              Container(
                height: 40,
                color: Colors.pinkAccent[100],
                child: Center(
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              width: 40,
                              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                              child: FlatButton(
                                onPressed: (){exitQuiz();},
                                child: Icon( Icons.pause, color: Colors.white,),
                                padding: EdgeInsets.all(0),
                              ),
                            ),
                          ),
                        ],
                      ),
                     Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text("${qIndex+1}/${questionList.length}", style: TextStyle(color: Colors.white),),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              width: 40,
                              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                              child: FlatButton(
                                onPressed: (){skipQA();},
                                child: Icon( Icons.skip_next, color: Colors.white,),
                                padding: EdgeInsets.all(0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                )
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        isListening?Icon(Icons.hearing, size: 50,):Text(questionList[qIndex]["Q"], style: TextStyle(fontSize: qFontSize), textAlign: TextAlign.center,),
                        isListening?Text(""):Text(questionList[qIndex]["kanji"]==null?"":(questionList[qIndex]["kanji"]==questionList[qIndex]["Q"]?"":questionList[qIndex]["kanji"]), style: TextStyle(fontSize: 20),),
                      ],
                    ),
                  )
                ),
              ),
              Container(        
                child: GridView.count(
                  crossAxisCount: gridCol,
                  childAspectRatio: (gridRatio),
                  padding: EdgeInsets.all(0),
                  controller: ScrollController(keepScrollOffset: false),
                  shrinkWrap: true,
                  // scrollDirection: Axis.vertical,
                  children: choiceList.map((String value){
                    return InkWell(
                      onTap: (){answer(value);},
                      splashColor: Colors.blue,
                      child: Container(
                        alignment: gridAlignment,
                        margin: EdgeInsets.all(1),
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                        color: Colors.pinkAccent[100],
                        child: Text(value, style: TextStyle(fontSize: 20,), textAlign: TextAlign.left,),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(
                height: 40,
                alignment: Alignment.center,
                child: Text(_randomQuote, style: TextStyle(fontSize: 10),),
              ),
            ],
          ),
        )
      ),
    );
  }//widget

  // Future _showDialog(String value, title){
  //   return showDialog(
  //     context: context,
  //     builder: (context)=>AlertDialog(
  //       title: Text(title),
  //       content: Text(value),
  //       actions: <Widget>[
  //         FlatButton(
  //           onPressed: (){
  //             Navigator.of(context).pop();
  //           },
  //           child: Text("Close"),
  //         ),
  //       ],
  //     )
  //   );
  // }

  Future exitQuiz(){
    return showDialog(
      context: context,
      builder: (context)=>AlertDialog(
        title: Text("តើអ្នកពិតជាចង់បញ្ចប់មែនឬ?"),
        content: Text(""),
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              Navigator.of(context).pop();
              Navigator.pop(context);
            },
            child: Text("យល់ព្រម"),
          ),
          FlatButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            child: Text("ទេ"),
          )
        ],
      )
    );
  }
  String _getRandomQuote(){
    return quotes[_random.nextInt(quotes.length)];
  }
  final List quotes = [
    "ចេះមកពីរៀន មានមកពីលក់ដី",
    "រៀនដើម្បីរស់",
    "រៀនថ្ងៃមិនគ្រប់ រៀនយប់បន្ថែម",
  ];
}//class