import 'package:flutter/material.dart';

class QuizResultPage extends StatefulWidget {
  final data;
  final String weapon;
  final int type;
  final int duration;
  QuizResultPage({Key key, this.data, this.weapon, this.type, this.duration}) : super(key:key);
  @override
  _QuizResultPageState createState() => _QuizResultPageState(data, weapon, type, duration);
}

class _QuizResultPageState extends State<QuizResultPage> {
  
  final List jsonData;
  final String weapon;
  final int type;
  final int duration;
  int score = 0;
  double theScore = 0;
  List<Widget> widgetRowResult = [];
  _QuizResultPageState(this.jsonData, this.weapon, this.type, this.duration){
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
        color: (theScore>=50)?Colors.green:Colors.red,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom:15),
                    child: (theScore>=50)?Image.asset('assets/img/mnn-icon.png', width: 80, height: 80,):Image.asset('assets/img/mnn-icon-upset.png', width: 80, height: 80,),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("សំនួរអំពី", style: TextStyle(color: Colors.white),),
                        Text("$weapon", style: TextStyle(color: Colors.white),),
                      ],
                    )
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("ឆ្លើយត្រូវ", style: TextStyle(color: Colors.white),),
                        Text("$score/${jsonData.length}", style: TextStyle(color: Colors.white),),
                      ],
                    )
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("រយៈពេល", style: TextStyle(color: Colors.white),),
                        Text("$duration វិនាទី", style: TextStyle(color: Colors.white),),
                      ],
                    )
                  ),
                ],
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
          title: Text("សំនួរ: ${item['Q']}"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("ចម្លើយត្រូវ: ${item['C']}"),
              Text("ចម្លើយអ្នក: ${item['A']}", style: TextStyle(color: color,),),
            ],
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
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
          padding: EdgeInsets.symmetric(vertical: 5),
          children: widgetRowResult
        )
      )
    );
  }
  
}
