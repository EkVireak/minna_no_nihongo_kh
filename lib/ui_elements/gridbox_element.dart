import 'package:flutter/material.dart';
class GridboxElement extends StatelessWidget{
  final VoidCallback _onTap;
  final String _title, _subtitle1, _subtitle2;
  final IconData _icon;
  final Color _iconColor;
  GridboxElement(this._onTap, this._title, this._subtitle1, this._subtitle2, this._icon, this._iconColor);

  @override
  Widget build(BuildContext context){
    return Card(
      // color: Colors.grey[100],
      
      child: Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     // Where the linear gradient begins and ends
        //     begin: Alignment.topRight,
        //     end: Alignment.bottomLeft,
        //     // Add one stop for each color. Stops should increase from 0 to 1
        //     stops: [0, 0.5, 0.7, 1],
        //     colors: [
        //       // Colors are easy thanks to Flutter's Colors class.
        //       Colors.pinkAccent[100],
        //       Colors.pinkAccent[100],
        //       Colors.pinkAccent[100],
        //       Colors.pinkAccent,
        //     ],
        //   ),
        // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              // decoration: BoxDecoration(
              //   border: Border.all(width: 1, color: Colors.black),
              //   borderRadius: const BorderRadius.all(const Radius.circular(8)),
              // ),
              child: InkWell(
                // borderRadius: const BorderRadius.all(const Radius.circular(8)),
                splashColor: Colors.pinkAccent[100],
                onTap: _onTap,
                child: Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(_icon, color: _iconColor),                  
                        Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(_title, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(_subtitle1, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                        ),                  
                        Text(_subtitle2),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
        ],
      ),
    ),
    );
  }
}