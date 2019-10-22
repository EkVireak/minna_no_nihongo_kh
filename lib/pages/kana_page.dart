import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class KanaPage extends StatefulWidget {
  final jsonData;
  final jsonData2;
  final jsonData3;
  KanaPage(this.jsonData, this.jsonData2, this.jsonData3);
  @override
  _KanaPageState createState() => _KanaPageState(jsonData, jsonData2, jsonData3);
}

class _KanaPageState extends State<KanaPage> with SingleTickerProviderStateMixin{
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  @override
  void dispose() {
    if( _timer!=null ){
      _timer.cancel();
      _timer = null;
    }
    if( _timerPlay!=null ){
      _timerPlay.cancel();
      _timerPlay = null;
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
  
  //==================================================
  String  _playKana = "", _playRoman = "";
  Timer _timer, _timerPlay;
  bool _isPlaying = false;
  int _index = 0;
  int _tabIndex = 1;
  var _playbackData;
  void _playReadKana(int key, int selectedIndex){    
    if(_isPlaying){
      setState(() {
        _isPlaying = false;
      });
    }
    else{
      setState(() {
        _isPlaying = true;
        _recusivePlayback(key, selectedIndex);
      });
    }
  }
  void _recusivePlayback(int key, int selectedIndex){
    setState(() {
      _playRoman = _playbackData[_index]['roman'];
      if(selectedIndex==0)
        _playKana = _playbackData[_index]['hiragana'];
      else
        _playKana = _playbackData[_index]['katakana'];
      _initKanaPage();
      _timerPlay = Timer(new Duration(milliseconds: 200), () {
        if(_playRoman.isEmpty == false)
          _play(_playRoman, key.toString());
      });
      
      _index ++;
      _timer = Timer(new Duration(milliseconds: 800), () {
        if( _index < _playbackData.length && _isPlaying ){
          _recusivePlayback(key, selectedIndex);
        }
        else{
          if( _index <= 0 || _index >= _playbackData.length ){
            setState(() {
              _index = 0;
              _isPlaying = false;
              _playKana = "";
              _initKanaPage(); 
            });
          }
        }
      });
    });
  }
  void _resetPlayback(){
    setState(() {
      if( _timer!=null ){
        _timer.cancel();
        _timer = null;
      }
      if( _timerPlay!=null ){
        _timerPlay.cancel();
        _timerPlay = null;
      }
      if( _assetsAudioPlayer!=null )
        _assetsAudioPlayer.stop();
      _index = 0;
      _isPlaying = false;
      _playKana = "";
      _initKanaPage();
    });
  }
  
  void _onTapTabBar(int index){
    _tabIndex = index+1;
    if( _tabIndex == 1 ){
      _playbackData = jsonData;
    }
    else if( _tabIndex == 2 ){
      _playbackData = jsonData2;
    }
    else if( _tabIndex == 3 ){
      _playbackData = jsonData3;
    }
    else{
      _playbackData = jsonData;
    }
    _resetPlayback();
  }
  //==================================================
  List _hiraganaBlockWidgets = <Widget>[];
  List _kataganaBlockWidgets = <Widget>[];
  List _hiraganaBlockWidgets2 = <Widget>[];
  List _kataganaBlockWidgets2 = <Widget>[];
  List _hiraganaBlockWidgets3 = <Widget>[];
  List _kataganaBlockWidgets3 = <Widget>[];
  List<Widget> _widgetOptions = <Widget>[];
  final jsonData;
  final jsonData2;
  final jsonData3;
  _KanaPageState(this.jsonData, this.jsonData2, this.jsonData3){
    _playbackData = jsonData;
    _initKanaPage();
  }
  void _initKanaPage(){
    _widgetOptions = <Widget>[];
    _hiraganaBlockWidgets = <Widget>[];
    _kataganaBlockWidgets = <Widget>[];
    _hiraganaBlockWidgets2 = <Widget>[];
    _kataganaBlockWidgets2 = <Widget>[];
    _hiraganaBlockWidgets3 = <Widget>[];
    _kataganaBlockWidgets3 = <Widget>[];
    for(var item in jsonData){
      var _hiragana = item['hiragana'];
      var _katakana = item['katakana'];
      var _roman = item['roman'];
      if(_roman=="yu" || _roman=="yo" || _roman=="wo"){
        int n = 1;
        if(_roman=="wo")
          n=3;
        for(var i=0;i<n;i++){
          _hiraganaBlockWidgets.add(Container());
          _kataganaBlockWidgets.add(Container());
        }
      }
      _hiraganaBlockWidgets.add(cardKana(_hiragana, _roman, "1")); 
      _kataganaBlockWidgets.add(cardKana(_katakana, _roman, "1"));
    }
    for(var item in jsonData2){
      var _hiragana = item['hiragana'];
      var _katakana = item['katakana'];
      var _roman = item['roman'];
      _hiraganaBlockWidgets2.add(cardKana(_hiragana, _roman, "2")); 
      _kataganaBlockWidgets2.add(cardKana(_katakana, _roman, "2"));
    }
    int i = 0;
    for(var item in jsonData3){
      if(i==0){
        _hiraganaBlockWidgets3.add(Container());
        _kataganaBlockWidgets3.add(Container());
      }
      if(i%3 == 0 && i!=0){
        _hiraganaBlockWidgets3.add(Container());
        _hiraganaBlockWidgets3.add(Container());
        _kataganaBlockWidgets3.add(Container());
        _kataganaBlockWidgets3.add(Container());
      }
      var _hiragana = item['hiragana'];
      var _katakana = item['katakana'];
      var _roman = item['roman'];
      _hiraganaBlockWidgets3.add(cardKana(_hiragana, _roman, "3")); 
      _kataganaBlockWidgets3.add(cardKana(_katakana, _roman, "3"));
      i++;
    }
    
    _widgetOptions = <Widget>[
      kanaTabBuilder(
        grid5(_hiraganaBlockWidgets),
        grid5(_hiraganaBlockWidgets2),
        grid5(_hiraganaBlockWidgets3)
      ),
      kanaTabBuilder(
        grid5(_kataganaBlockWidgets),
        grid5(_kataganaBlockWidgets2),
        grid5(_kataganaBlockWidgets3)
      ),
    ];
  }
  grid5(List<Widget> childBlock){
    return Container(        
      child: GridView.count(
        crossAxisCount: 5,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        padding: EdgeInsets.all(0),
        controller: ScrollController(keepScrollOffset: false),
        shrinkWrap: true,
        children: childBlock
      ),
    );
  }
  cardKana(String kana, roman, key){
    return Card(
      color: _playKana==kana?Colors.pinkAccent[100]:Colors.white,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(0),
        child: MaterialButton(
          splashColor: Colors.pinkAccent[100],
          padding: EdgeInsets.all(0),
          onPressed: ()=>{_play(roman, key)},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("$kana", style: TextStyle(fontSize: 16),),
              Text("$roman", style: TextStyle(fontSize: 12),),
            ],
          ),
        )
      ),
    );
  }
    
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.pinkAccent[100],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            title: Text('Hiragana'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            title: Text('Katakana'),
          ),
        ],
        currentIndex: _selectedIndex ,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _resetPlayback();
          });
        },
      ),
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),
        centerTitle: true,
        title: Text("តួអក្សរ"),
        backgroundColor: Colors.pinkAccent[100],
        actions: <Widget>[
          MaterialButton(
            minWidth: 60,
            onPressed: ()=>{_resetPlayback()},
            child: Icon(Icons.stop, color: Colors.white,),
          ),
          MaterialButton(
            minWidth: 60,
            onPressed: ()=>{_playReadKana(_tabIndex, _selectedIndex)},
            child: _isPlaying?Icon(Icons.pause, color: Colors.white,):Icon(Icons.play_arrow, color: Colors.white,),
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex)
      ),
    );
  }
  Widget kanaTabBuilder(Widget tab1, tab2, tab3){
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.pink[100],
          appBar: TabBar(
            indicatorColor: Colors.pinkAccent,
            indicatorPadding: EdgeInsets.all(0),
            labelPadding: EdgeInsets.all(0),
            onTap: (value)=>{_onTapTabBar(value)},
            tabs: [
              Container(
                height: 46,
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(0),
                alignment: Alignment.center,
                color: Colors.pinkAccent[100],
                child: Tab(text: "មូលដ្ឋាន"),
              ),
              Container(
                height: 46,
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(0),
                alignment: Alignment.center,
                color: Colors.pinkAccent[100],
                child: Tab(text: "សម្លេងធ្ងន់"),
              ),
              Container(
                height: 46,
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(0),
                alignment: Alignment.center,
                color: Colors.pinkAccent[100],
                child: Tab(text: "អក្សរផ្សំ"),
              ),
            ],
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              tab1,
              tab2,
              tab3,
            ],
          )
        ),
      ),
    );
  }




}