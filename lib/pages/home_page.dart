import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:minna_no_nihongo_kh/pages/kana_page.dart';
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
        title: Text("Minna No Nihongo"),
        backgroundColor: Colors.pinkAccent[100],
        elevation: 0.0,
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
          ],
        ),
      ),
    );
  }

}//class