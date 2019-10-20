import 'package:flutter/material.dart';
class LessonWordPage extends StatefulWidget {
  final int lesson;
  final data;
  LessonWordPage({Key key, this.data, this.lesson}) : super(key:key);
  @override
  _LessonWordPageState createState() => _LessonWordPageState(data);
}

class _LessonWordPageState extends State<LessonWordPage> {
  final List jsonData;
  List<Widget> widgetRowResult = [];
  _LessonWordPageState(this.jsonData){
    int i=0;
    for (var item in jsonData) {
      i++;
      widgetRowResult.add(_dataRow(item, i));
    }
  }
  Widget _dataRow(item, int no){
    return Card(
      child: Container(
        child: ListTile(
          leading: Text("$no"),
          title: Text("${item['kana']}"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              item['kanji']!=""?Text("${item['kanji']}\n${item['khmer']==''?item['english']:item['khmer']+item['extra']}"):Text("${item['khmer']==''?item['english']:item['khmer']+item['extra']}"),
            ],
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed:() => Navigator.pop(context, false),
            ),
            centerTitle: true,
            title: Text("មេរៀនទី ${widget.lesson}"),
            backgroundColor: Colors.pinkAccent[100],
            bottom: TabBar(
              indicatorColor: Colors.pinkAccent,
              tabs: [
                Tab(text: "ពាក្យ"),
                Tab(text: "វេយ្យាករណ៍"),
              ],
            ),
          ),
          backgroundColor: Colors.pink[100],
          body: TabBarView(
            children: [
              ListView(
                children: widgetRowResult
              ),
              Center(
                child: Text("Not available!"),
              )
            ],
          
          ),
        ),
      ),
    );
  }
}