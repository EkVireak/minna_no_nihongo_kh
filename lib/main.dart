import 'dart:async';

import 'package:flutter/material.dart';
import 'package:minna_no_nihongo_kh/pages/about_page.dart';
import 'package:minna_no_nihongo_kh/pages/home_page.dart';
import 'package:minna_no_nihongo_kh/pages/lessons_page.dart';
import 'package:minna_no_nihongo_kh/pages/result_page.dart';
import 'package:sqflite/sqflite.dart';

void main(){
  initDB();
  runApp(MyApp());
}

Database db ;
String path;
void initDB() async{
  try {
    db = await openDatabase(
      'minanonihongo.db',
      version: 1,
      onCreate: (db, version) async{
        var batch = db.batch();
        _createTables(batch);
        await batch.commit();
      }
    );    
  } catch (e) {
    print("error db : "+e.toString());
  }
}
void _createTables(Batch batch) {
  try {
    batch.execute('DROP TABLE IF EXISTS quizResult');
    batch.execute('''CREATE TABLE quizResult (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      weapon TEXT, 
      type INTEGER, 
      qa TEXT, 
      numQa INTEGER, 
      numC INTEGER, 
      duration INTEGER, 
      datetime TEXT
    )''');
  } catch (e) {
    print("error init db"+e.toString());
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'រៀនជប៉ុន',
      theme: ThemeData(
        // primaryColor: Colors.pinkAccent[100],
        // primarySwatch: Colors.pinkAccent[100],
        // colorScheme: ColorScheme.dark()
      ),
      // home: HomePage(),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/home': (context) => HomePage(),
        '/lessons': (context) => LessonsPage(),
        '/about': (context) => AboutPage(),
        '/result': (context) => ResultPage(),
      },
  
    );
  }
}