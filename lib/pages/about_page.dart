import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  void openFB() async{
    // if(Platform.isAndroid){
      String fbUrl = "fb://profile/100009582370216";
      await canLaunch(fbUrl).then((value)=>{
        value?launch(fbUrl):launch("https://www.facebook.com/ek96vireak")
      });
    // }
    // else{
    //   launch("https://www.facebook.com/ek96vireak");
    // }
  }
  void openIG() async{
    // if(Platform.isAndroid){
      String igUrl = "instagram://user?username=ek96vireak";
      await canLaunch(igUrl).then((value)=>{
        value?launch(igUrl):launch("https://www.instagram.com/ek96vireak/")
      });
    // }
    // else{
    //   launch("https://www.instagram.com/ek96vireak/");
    // }
  }
  void openIN() async{
    // if(Platform.isAndroid){
      String inUrl = "linkedin://profile/vireak-ek-5aaaa814a";
      await canLaunch(inUrl).then((value)=>{
        value?launch(inUrl):launch("https://www.linkedin.com/in/vireak-ek-5aaaa814a/")
      });
    // }
    // else{
    //   launch("https://www.linkedin.com/in/vireak-ek-5aaaa814a/");
    // }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("អំពីកម្មវិធី"),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent[100],
      ),
      body: Container(
        alignment: Alignment.centerLeft,
        child: ListView(
          children: <Widget>[
            Card(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("អ្នកសរសេរកម្មវិធី", style: TextStyle(fontSize: 20)),
                    Text("ឯក វិរៈ (Ek Vireak) (エック　ヴィリアック)"),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          InkWell(
                            splashColor: Colors.pinkAccent[100],
                            onTap: ()=>{openFB()},
                            child: Image.asset('assets/img/fb.png'),
                          ),
                          Padding(padding: EdgeInsets.all(10)),
                          InkWell(
                            onTap: ()=>{openIG()},
                            child: Image.asset('assets/img/ig.png'),
                          ),
                          Padding(padding: EdgeInsets.all(10)),
                          InkWell(
                            onTap: ()=>{openIN()},
                            child: Image.asset('assets/img/linkedin.png'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Version", style: TextStyle(fontSize: 20)),
                    Text("1.0.0"),
                    Text("Software Development KIT", style: TextStyle(fontSize: 20)),
                    Text("Flutter 1.9"),
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Sound of Text", style: TextStyle(fontSize: 20)),
                    Text("សំលេងរបស់តួអក្សរ គឺត្រូវបានធ្វើការបំលែងពីអក្សរទៅជាសម្លេង តាមរយៈគេហទំព័រ https://soundoftext.com/ ។"),
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("អំពីកម្មវិធី", style: TextStyle(fontSize: 20)),
                    Text("កម្មវិធីនេះ ត្រូវបានបង្កើតឡើងក្នុងគោលបំណងសិក្សា អនុវត្ត និងអភិវឌ្ឍ ទៅលើចំណេះ ជំនាញរបស់ខ្ញុំក្នុងការសរសេរកម្មវិធីទូរស័ព្ទដៃ (Mobile Development)។"),
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(20),
                child: Image.asset('assets/img/mnn-front.jpg'),
              ),
            ),
            Card(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(20),
                child: Image.asset('assets/img/mnn-back.jpg'),
              ),
            ),
          ],
        )
      ),
    );
  }
}