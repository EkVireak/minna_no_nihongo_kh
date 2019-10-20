import 'package:flutter/material.dart';

class QuizResultPage extends StatefulWidget {
  final data;
  final String weapon;
  final int type;
  QuizResultPage({Key key, this.data, this.weapon, this.type}) : super(key:key);
  @override
  _QuizResultPageState createState() => _QuizResultPageState(data, weapon, type);
}

class _QuizResultPageState extends State<QuizResultPage> {
  
  final List jsonData;
  final String weapon;
  final int type;
  int score = 0;
  double theScore = 0;
  List<Widget> widgetRowResult = [];
  _QuizResultPageState(this.jsonData, this.weapon, this.type){
    Color color;
    IconData icon;
    for (var item in jsonData) {
      if(item["C"] == item["A"]){
        score++;
      }
    }
    theScore = 100*score/jsonData.length;
    widgetRowResult.add(
      Card(
        color: Colors.blueGrey[100],
        child: Container(
          padding: EdgeInsets.all(20),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Text("សំនួរអំពី: $weapon"),
                )
              ),
              Expanded(
                child: Container(
                  child: Text("ឆ្លើយត្រូវ: $score/${jsonData.length}"),
                )
              ),
            ],
          ),
        ),
      )
    );
    for (var item in jsonData) {
      if(item["C"] == item["A"]){
        // score++;
        color = Colors.green;
        icon = Icons.check;
      }
      else{
        color = Colors.red;
        icon = Icons.close;
      }
      widgetRowResult.add(_dataRow(item, icon, color));
    }
    
  }
  Widget _dataRow(item, IconData icon, Color color){
    return Card(
      child: Container(
        child: ListTile(
          trailing: Icon(icon, color: color,),
          title: Text("Q: ${item['Q']}"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("C: ${item['C']}"),
              Text("A: ${item['A']}", style: TextStyle(color: color,),),
            ],
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text.rich(
          TextSpan(
            children: <TextSpan>[
              TextSpan(text:"លទ្ធផល "),
              TextSpan(text:"${theScore.toStringAsFixed(2)}"),
            ]
          )
        ),
        backgroundColor: Colors.pinkAccent[100],
      ),
      body: Center(
        child: ListView(
          children: widgetRowResult
        )
      )
    );
  }
  
}
