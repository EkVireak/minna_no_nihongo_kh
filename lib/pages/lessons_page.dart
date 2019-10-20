import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:minna_no_nihongo_quiz/ui_elements/gridbox_element.dart';
import 'package:minna_no_nihongo_quiz/pages/lesson_word_page.dart';

class LessonsPage extends StatefulWidget {
  // final String weapon;
  // LessonsPage({Key key, this.weapon}) : super(key:key);
  @override
  _LessonsPageState createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
  final childGrid = <Widget>[];
  final int numLesson = 25;
  @override
  void initState() {    
    initFuncs();
    super.initState();
  }
  void initFuncs() async{
    for(var i = 1; i <=numLesson; i++) {
      childGrid.add(GridboxElement(()=>{wordCallback(i)}, "មេរៀនទី $i", "だい $i か", "dai $i ka", Icons.library_books, Colors.pinkAccent[100]));
    }
  }
  void wordCallback(int key) async{
    var assetFile = "assets/data/word_lesson_$key.json";
    String data = await DefaultAssetBundle.of(context).loadString(assetFile);
    List jsonResult = json.decode(data.toString());
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>LessonWordPage(lesson: key, data: jsonResult,)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("មេរៀន ($numLesson)"),
        backgroundColor: Colors.pinkAccent[100],
      ),
      backgroundColor: Colors.pink[100],
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(10.0),
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        crossAxisCount: 2,
        children: childGrid
      ),
    );
  }
}