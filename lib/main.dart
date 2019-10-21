import 'package:flutter/material.dart';
import 'package:minna_no_nihongo_kh/pages/about_page.dart';
import 'package:minna_no_nihongo_kh/pages/home_page.dart';
import 'package:minna_no_nihongo_kh/pages/lessons_page.dart';
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
    // //table kana
    // batch.execute('DROP TABLE IF EXISTS kana');
    // batch.execute('''CREATE TABLE kana (
    //   id INTEGER PRIMARY KEY AUTOINCREMENT, 
    //   hiragana TEXT, 
    //   katakana TEXT, 
    //   roman TEXT, 
    //   type INTEGER
    // )''');
    // //kana1
    // batch.execute('''
    //   INSERT INTO kana(hiragana, katakana, roman, type) 
    //   VALUES
    //   ('あ', 'ア', 'a' , 1)
    //   ,('い', 'イ', 'i', 1 )
    //   ,('う', 'ウ', 'u', 1 )
    //   ,('え', 'エ', 'e', 1 )
    //   ,('お', 'オ', 'o', 1 )
    //   ,('か', 'カ', 'ka', 1 )
    //   ,('き', 'キ', 'ki', 1 )
    //   ,('く', 'ク', 'ku', 1 )
    //   ,('け', 'ケ', 'ke', 1 )
    //   ,('こ', 'コ', 'ko', 1 )
    //   ,('さ', 'サ', 'sa', 1 )
    //   ,('し', 'シ', 'shi', 1 )
    //   ,('す', 'ス', 'su', 1 )
    //   ,('せ', 'セ', 'se', 1 )
    //   ,('そ', 'ソ', 'so', 1 )
    //   ,('た', 'タ', 'ta', 1 )
    //   ,('ち', 'チ', 'chi', 1 )
    //   ,('つ', 'ツ', 'tsu', 1 )
    //   ,('て', 'テ', 'te', 1 )
    //   ,('と', 'ト', 'to', 1 )
    //   ,('な', 'ナ', 'na', 1 )
    //   ,('に', 'ニ', 'ni', 1 )
    //   ,('ぬ', 'ヌ', 'nu', 1 )
    //   ,('ね', 'ネ', 'ne', 1 )
    //   ,('の', 'ノ', 'no', 1 )
    //   ,('は', 'ハ', 'ha', 1 )
    //   ,('ひ', 'ヒ', 'hi', 1 )
    //   ,('ふ', 'フ', 'fu', 1 )
    //   ,('へ', 'ヘ', 'he', 1 )
    //   ,('ほ', 'ホ', 'ho', 1 )
    //   ,('ま', 'マ', 'ma', 1 )
    //   ,('み', 'ミ', 'mi', 1 )
    //   ,('む', 'ム', 'mu', 1 )
    //   ,('め', 'メ', 'me', 1 )
    //   ,('も', 'モ', 'mo', 1 )
    //   ,('や', 'ヤ', 'ya', 1 )
    //   ,('ゆ', 'ユ', 'yu', 1 )
    //   ,('よ', 'ヨ', 'yo', 1 )
    //   ,('ら', 'ラ', 'ra', 1 )
    //   ,('り', 'リ', 'ri', 1 )
    //   ,('る', 'ル', 'ru', 1 )
    //   ,('れ', 'レ', 're', 1 )
    //   ,('ろ', 'ロ', 'ro', 1 )
    //   ,('わ', 'ワ', 'wa', 1 )
    //   ,('を', 'ヲ', 'wo', 1 )
    //   ,('ん', 'ン', 'n', 1 )
    // ''');
    // //kana2
    // batch.execute('''
    //   INSERT INTO kana(roman, hiragana, katakana, type) 
    //   VALUES
    //   ('ga', 'が', 'ガ', 2)
    //   ,('gi', 'ぎ', 'ギ', 2)
    //   ,('gu', 'ぐ', 'グ', 2)
    //   ,('ge', 'げ', 'ゲ', 2)
    //   ,('go', 'ご', 'ゴ', 2)
    //   ,('za', 'ざ', 'ザ', 2)
    //   ,('ji', 'じ', 'ジ', 2)
    //   ,('zu', 'ず', 'ズ', 2)
    //   ,('ze', 'ぜ', 'ゼ', 2)
    //   ,('zo', 'ぞ', 'ゾ', 2)
    //   ,('da', 'だ', 'ダ', 2)
    //   ,('ji', 'ぢ', 'ヂ', 2)
    //   ,('zu', 'づ', 'ヅ', 2)
    //   ,('de', 'で', 'デ', 2)
    //   ,('do', 'ど', 'ド', 2)
    //   ,('ba', 'ば', 'バ', 2)
    //   ,('bi', 'び', 'ビ', 2)
    //   ,('bu', 'ぶ', 'ブ', 2)
    //   ,('be', 'べ', 'ベ', 2)
    //   ,('bo', 'ぼ', 'ボ', 2)
    //   ,('pa', 'ぱ', 'パ', 2)
    //   ,('pi', 'ぴ', 'ピ', 2)
    //   ,('pu', 'ぷ', 'プ', 2)
    //   ,('pe', 'ぺ', 'ペ', 2)
    //   ,('po', 'ぽ', 'ポ', 2)
    // ''');
    // //kana3
    // batch.execute('''
    //   INSERT INTO kana(roman, hiragana, katakana, type) 
    //   VALUES
    //   ('kya', 'きゃ', 'キャ', 3)
    //   ,('kyu', 'きゅ', 'キュ', 3)
    //   ,('kyo', 'きょ', 'キョ', 3)
    //   ,('sha', 'しゃ', 'シャ', 3)
    //   ,('shu', 'しゅ', 'シュ', 3)
    //   ,('sho', 'しょ', 'ショ', 3)
    //   ,('cha', 'ちゃ', 'チャ', 3)
    //   ,('chu', 'ちゅ', 'チュ', 3)
    //   ,('cho', 'ちょ', 'チョ', 3)
    //   ,('nya', 'にゃ', 'ニャ', 3)
    //   ,('nyu', 'にゅ', 'ニュ', 3)
    //   ,('nyo', 'にょ', 'ニョ', 3)
    //   ,('hya', 'ひゃ', 'ヒャ', 3)
    //   ,('hyu', 'ひゅ', 'ヒュ', 3)
    //   ,('hyo', 'ひょ', 'ヒョ', 3)
    //   ,('mya', 'みゃ', 'ミャ', 3)
    //   ,('myu', 'みゅ', 'ミュ', 3)
    //   ,('myo', 'みょ', 'ミョ', 3)
    //   ,('rya', 'りゃ', 'リャ', 3)
    //   ,('ryu', 'りゅ', 'リュ', 3)
    //   ,('ryo', 'りょ', 'リョ', 3)
      
    //   ,('gya', 'ぎゃ', 'ギャ', 3)
    //   ,('gyu', 'ぎゅ', 'ギュ', 3)
    //   ,('gyo', 'ぎょ', 'ギョ', 3)
    //   ,('ja', 'じゃ', 'ジャ', 3)
    //   ,('ju', 'じゅ', 'ジュ', 3)
    //   ,('jo', 'じょ', 'ジョ', 3)
    //   ,('bya', 'びゃ', 'ビャ', 3)
    //   ,('byu', 'びゅ', 'ビュ', 3)
    //   ,('byo', 'びょ', 'ビョ', 3)
    //   ,('pya', 'ぴゃ', 'ピャ', 3)
    //   ,('pyu', 'ぴゅ', 'ピュ', 3)
    //   ,('pyo', 'ぴょ', 'ピョ', 3)
    // ''');
    // //table quizResult
    batch.execute('DROP TABLE IF EXISTS quizResult');
    batch.execute('''CREATE TABLE quizResult (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      weapon TEXT, 
      type INTEGER, 
      qa TEXT, 
      numQa INTEGER, 
      numC INTEGER, 
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
        // '/kana': (context) => KanaPage(),
        '/lessons': (context) => LessonsPage(),
        '/about': (context) => AboutPage(),
      },
  
    );
  }
}


// class StartPage extends StatefulWidget {
//   @override
//   _StartPageState createState() => _StartPageState();
// }

// class _StartPageState extends State<StartPage> {

//   @override
//   void initState(){
//     initDB();
//     super.initState();
//   }
//   Database db ;
//   void initDB() async{
//     try {
//       db = await openDatabase('minanonihongo.db');
//       await db.execute("CREATE TABLE IF NOT EXISTS kana (id INTEGER PRIMARY KEY, hiragana TEXT, katakana TEXT, roman TEXT, type INTEGER)");
//     } catch (e) {
//       print("CREATE TABLE error : "+e);
//     }
//   }

//   void _initDataKana() async{
//     try {
//     //=== kana 1 ===
//     //   await db.insert('kana', { "hiragana":"あ", "katakana":"ア", "roman":"a" , 'type':1 }); 
//     //   await db.insert('kana', { "hiragana":"い", "katakana":"イ", "roman":"i" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"う", "katakana":"ウ", "roman":"u" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"え", "katakana":"エ", "roman":"e" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"お", "katakana":"オ", "roman":"o" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"か", "katakana":"カ", "roman":"ka" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"き", "katakana":"キ", "roman":"ki" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"く", "katakana":"ク", "roman":"ku" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"け", "katakana":"ケ", "roman":"ke" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"こ", "katakana":"コ", "roman":"ko" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"さ", "katakana":"サ", "roman":"sa" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"し", "katakana":"シ", "roman":"shi" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"す", "katakana":"ス", "roman":"su" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"せ", "katakana":"セ", "roman":"se" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"そ", "katakana":"ソ", "roman":"so" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"た", "katakana":"タ", "roman":"ta" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"ち", "katakana":"チ", "roman":"chi" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"つ", "katakana":"ツ", "roman":"tsu" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"て", "katakana":"テ", "roman":"te" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"と", "katakana":"ト", "roman":"to" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"な", "katakana":"ナ", "roman":"na" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"に", "katakana":"ニ", "roman":"ni" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"ぬ", "katakana":"ヌ", "roman":"nu" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"ね", "katakana":"ネ", "roman":"ne" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"の", "katakana":"ノ", "roman":"no" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"は", "katakana":"ハ", "roman":"ha" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"ひ", "katakana":"ヒ", "roman":"hi" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"ふ", "katakana":"フ", "roman":"fu" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"へ", "katakana":"ヘ", "roman":"he" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"ほ", "katakana":"ホ", "roman":"ho" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"ま", "katakana":"マ", "roman":"ma" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"み", "katakana":"ミ", "roman":"mi" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"む", "katakana":"ム", "roman":"mu" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"め", "katakana":"メ", "roman":"me" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"も", "katakana":"モ", "roman":"mo" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"や", "katakana":"ヤ", "roman":"ya" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"ゆ", "katakana":"ユ", "roman":"yu" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"よ", "katakana":"ヨ", "roman":"yo" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"ら", "katakana":"ラ", "roman":"ra" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"り", "katakana":"リ", "roman":"ri" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"る", "katakana":"ル", "roman":"ru" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"れ", "katakana":"レ", "roman":"re" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"ろ", "katakana":"ロ", "roman":"ro" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"わ", "katakana":"ワ", "roman":"wa" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"を", "katakana":"ヲ", "roman":"wo" , 'type':1 });
//     //   await db.insert('kana', { "hiragana":"ん", "katakana":"ン", "roman":"n" , 'type':1 });
//     //=== kana 2 ===
//     // await db.insert('kana', { "roman":"ga", "hiragana":"が", "katakana":"ガ", 'type':2 });
//     // await db.insert('kana', { "roman":"gi", "hiragana":"ぎ", "katakana":"ギ", 'type':2 });
//     // await db.insert('kana', { "roman":"gu", "hiragana":"ぐ", "katakana":"グ", 'type':2 });
//     // await db.insert('kana', { "roman":"ge", "hiragana":"げ", "katakana":"ゲ", 'type':2 });
//     // await db.insert('kana', { "roman":"go", "hiragana":"ご", "katakana":"ゴ", 'type':2 });
//     // await db.insert('kana', { "roman":"za", "hiragana":"ざ", "katakana":"ザ", 'type':2 });
//     // await db.insert('kana', { "roman":"ji", "hiragana":"じ", "katakana":"ジ", 'type':2 });
//     // await db.insert('kana', { "roman":"zu", "hiragana":"ず", "katakana":"ズ", 'type':2 });
//     // await db.insert('kana', { "roman":"ze", "hiragana":"ぜ", "katakana":"ゼ", 'type':2 });
//     // await db.insert('kana', { "roman":"zo", "hiragana":"ぞ", "katakana":"ゾ", 'type':2 });
//     // await db.insert('kana', { "roman":"da", "hiragana":"だ", "katakana":"ダ", 'type':2 });
//     // await db.insert('kana', { "roman":"ji", "hiragana":"ぢ", "katakana":"ヂ", 'type':2 });
//     // await db.insert('kana', { "roman":"zu", "hiragana":"づ", "katakana":"ヅ", 'type':2 });
//     // await db.insert('kana', { "roman":"de", "hiragana":"で", "katakana":"デ", 'type':2 });
//     // await db.insert('kana', { "roman":"do", "hiragana":"ど", "katakana":"ド", 'type':2 });
//     // await db.insert('kana', { "roman":"ba", "hiragana":"ば", "katakana":"バ", 'type':2 });
//     // await db.insert('kana', { "roman":"bi", "hiragana":"び", "katakana":"ビ", 'type':2 });
//     // await db.insert('kana', { "roman":"bu", "hiragana":"ぶ", "katakana":"ブ", 'type':2 });
//     // await db.insert('kana', { "roman":"be", "hiragana":"べ", "katakana":"ベ", 'type':2 });
//     // await db.insert('kana', { "roman":"bo", "hiragana":"ぼ", "katakana":"ボ", 'type':2 });
//     // await db.insert('kana', { "roman":"pa", "hiragana":"ぱ", "katakana":"パ", 'type':2 });
//     // await db.insert('kana', { "roman":"pi", "hiragana":"ぴ", "katakana":"ピ", 'type':2 });
//     // await db.insert('kana', { "roman":"pu", "hiragana":"ぷ", "katakana":"プ", 'type':2 });
//     // await db.insert('kana', { "roman":"pe", "hiragana":"ぺ", "katakana":"ペ", 'type':2 });
//     // await db.insert('kana', { "roman":"po", "hiragana":"ぽ", "katakana":"ポ", 'type':2 });
//     //=== kana 3 ===
//     // await db.insert('kana', { "roman":"kya", "hiragana":"きゃ", "katakana":"キャ", 'type':3 });
//     // await db.insert('kana', { "roman":"kyu", "hiragana":"きゅ", "katakana":"キュ", 'type':3 });
//     // await db.insert('kana', { "roman":"kyo", "hiragana":"きょ", "katakana":"キョ", 'type':3 });
//     // await db.insert('kana', { "roman":"sha", "hiragana":"しゃ", "katakana":"シャ", 'type':3 });
//     // await db.insert('kana', { "roman":"shu", "hiragana":"しゅ", "katakana":"シュ", 'type':3 });
//     // await db.insert('kana', { "roman":"sho", "hiragana":"しょ", "katakana":"ショ", 'type':3 });
//     // await db.insert('kana', { "roman":"cha", "hiragana":"ちゃ", "katakana":"チャ", 'type':3 });
//     // await db.insert('kana', { "roman":"chu", "hiragana":"ちゅ", "katakana":"チュ", 'type':3 });
//     // await db.insert('kana', { "roman":"cho", "hiragana":"ちょ", "katakana":"チョ", 'type':3 });
//     // await db.insert('kana', { "roman":"nya", "hiragana":"にゃ", "katakana":"ニャ", 'type':3 });
//     // await db.insert('kana', { "roman":"nyu", "hiragana":"にゅ", "katakana":"ニュ", 'type':3 });
//     // await db.insert('kana', { "roman":"nyo", "hiragana":"にょ", "katakana":"ニョ", 'type':3 });
//     // await db.insert('kana', { "roman":"hya", "hiragana":"ひゃ", "katakana":"ヒャ", 'type':3 });
//     // await db.insert('kana', { "roman":"hyu", "hiragana":"ひゅ", "katakana":"ヒュ", 'type':3 });
//     // await db.insert('kana', { "roman":"hyo", "hiragana":"ひょ", "katakana":"ヒョ", 'type':3 });
//     // await db.insert('kana', { "roman":"mya", "hiragana":"みゃ", "katakana":"ミャ", 'type':3 });
//     // await db.insert('kana', { "roman":"myu", "hiragana":"みゅ", "katakana":"ミュ", 'type':3 });
//     // await db.insert('kana', { "roman":"myo", "hiragana":"みょ", "katakana":"ミョ", 'type':3 });
//     // await db.insert('kana', { "roman":"rya", "hiragana":"りゃ", "katakana":"リャ", 'type':3 });
//     // await db.insert('kana', { "roman":"ryu", "hiragana":"りゅ", "katakana":"リュ", 'type':3 });
//     // await db.insert('kana', { "roman":"ryo", "hiragana":"りょ", "katakana":"リョ", 'type':3 });
    
//     // await db.insert('kana', { "roman":"gya", "hiragana":"ぎゃ", "katakana":"ギャ", 'type':3 });
//     // await db.insert('kana', { "roman":"gyu", "hiragana":"ぎゅ", "katakana":"ギュ", 'type':3 });
//     // await db.insert('kana', { "roman":"gyo", "hiragana":"ぎょ", "katakana":"ギョ", 'type':3 });
//     // await db.insert('kana', { "roman":"ja", "hiragana":"じゃ", "katakana":"ジャ", 'type':3 });
//     // await db.insert('kana', { "roman":"ju", "hiragana":"じゅ", "katakana":"ジュ", 'type':3 });
//     // await db.insert('kana', { "roman":"jo", "hiragana":"じょ", "katakana":"ジョ", 'type':3 });
//     // await db.insert('kana', { "roman":"bya", "hiragana":"びゃ", "katakana":"ビャ", 'type':3 });
//     // await db.insert('kana', { "roman":"byu", "hiragana":"びゅ", "katakana":"ビュ", 'type':3 });
//     // await db.insert('kana', { "roman":"byo", "hiragana":"びょ", "katakana":"ビョ", 'type':3 });
//     // await db.insert('kana', { "roman":"pya", "hiragana":"ぴゃ", "katakana":"ピャ", 'type':3 });
//     // await db.insert('kana', { "roman":"pyu", "hiragana":"ぴゅ", "katakana":"ピュ", 'type':3 });
//     // await db.insert('kana', { "roman":"pyo", "hiragana":"ぴょ", "katakana":"ピョ", 'type':3 });
//     } catch (e) {
//       print(e);
//     }
//   }
  
//   String dateFormat(DateTime dt, {String format = "Y-m-d h:m:s"}){
//     if( dt != null ){
//       String month, day, hour, minute, second;
//       if(dt.month<10)
//         month = "0${dt.month}";
//       else
//         month = "${dt.month}";
//       if(dt.day<10)
//         day = "0${dt.day}";
//       else
//         day = "${dt.day}";
//       if(dt.hour<10)
//         hour = "0${dt.hour}";
//       else
//         hour = "${dt.hour}";
//       if(dt.minute<10)
//         minute = "0${dt.minute}";
//       else
//         minute = "${dt.minute}";
//       if(dt.second<10)
//         second = "0${dt.second}";
//       else
//         second = "${dt.second}";      
//       return dt.year.toString()+"-"+month+"-"+day+" "+hour+":"+minute+":"+second;
//     }
//     else
//       return "";
//   }
//   void _selectTest() async{
//     DateTime dt = DateTime.now();
//     String dd =  dateFormat(dt);
//     print(dd);
//     DateTime dt2 = DateTime.tryParse("2019/-03-01 12:30:00");
//     print(dateFormat(dt2));
//     print("helo");
//     // try {
//     //   var data = await db.query("kana");
//     //   print(data.length);
//     //   print(data);
//     // } catch (e) {
//     //   print(e);
//     // }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: Container(
//         child: ButtonBar(
//           alignment: MainAxisAlignment.center,
//           children: <Widget>[
//             MaterialButton(
//               onPressed: ()=>{_selectTest()},
//               child: Text("Click"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }