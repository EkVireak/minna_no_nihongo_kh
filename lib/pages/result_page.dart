import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:minna_no_nihongo_quiz/pages/quiz_result_page.dart';
import 'package:sqflite/sqflite.dart';

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List<Widget> widgetRowResult = <Widget>[];
  Database _db;
  Future _getQuizResult() async{
    _db = await openDatabase('minanonihongo.db');
    return await _db.query('quizResult');
  }

  Widget _dataRow(item){
    double score = 100*item['numC']/item['numQa'];
    print(score);
    return Card(
      child: Container(
        child: InkWell(
          onTap: ()=>{
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>QuizResultPage(data: jsonDecode(item['qa']), weapon: item['weapon'],)))
          },
          child: ListTile(
            // trailing: Icon(icon, color: color,),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  // alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  // color: Colors.blue,
                  child: Text(
                    "${(item['weapon']=='word'?'ពាក្យ មេរៀនទី':item['weapon'])} ${(item['weapon']=='word'?item['type']:(item['type']==1?'មូលដ្ឋាន':(item['type']==2?'សម្លេងធ្ងន់':(item['type']==3?'អក្សរផ្សំ':'ចម្រុះ'))))}",
                    style: TextStyle(color: Colors.pinkAccent[100]),
                  ),
                ),
                Text("ចំនួនសំនួរ: ${item['numQa']}"),
                Text("ឆ្លើយត្រូវ: ${item['numC']}"),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("${item['datetime']}"),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("${score.toStringAsFixed(2)}", style: TextStyle(fontSize: 20, color: (score>=50)?Colors.green:Colors.red,),),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _clearData(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('តើអ្នកប្រាកដជាចង់លុបទិន្នន័យទាំងអស់មែនឬ?'),
          content: const Text('ទិន្នន័យរបស់អ្នក នឹងត្រូវបានលុបជារៀងរហូត បន្ទាប់ពីអ្នកចុចលើ ប៊ូតុង យល់ព្រម។'),
          actions: <Widget>[
            FlatButton(
              child: Text('យល់ព្រម'),
              onPressed: () {
                setState(() {
                  try {
                    var d = _db.rawDelete("DELETE FROM quizResult");
                    d.then((value)=>{
                      widgetRowResult = []
                    });
                  } catch (e) {
                    print(e);
                  }
                });
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('ទេ'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100],
      appBar: AppBar(
        centerTitle: true,
        title: Text("លទ្ធផលនៃសំនួរ"),
        backgroundColor: Colors.pinkAccent[100],
        actions: <Widget>[
          MaterialButton(
            minWidth: 60,
            onPressed: ()=>{_clearData()},
            child: Icon(Icons.delete_forever, color: Colors.white,),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: _getQuizResult(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            var data = snapshot.data;
            if( data==null ){
              return Text("កំពុងទាញទិន្នន័យ...");
            }
            else{
              if(data.length<=0){
                return Text("មិនមានទិន្នន័យ!");
              }
              else{
                for(var i=0; i<data.length; i++){
                  var item = data[i];
                  widgetRowResult.add(_dataRow(item));
                }
                return ListView(
                  children: widgetRowResult
                );
              }          
            }
          },
        ),
      ),
    );
  }
  
}