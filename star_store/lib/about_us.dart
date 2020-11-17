import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          title: 
          Text("About Us"),
          centerTitle: true,
        ),
        body:
        SingleChildScrollView(
          child:
        Center(
          child:
          Column(
          children:
          <Widget>[
          Padding(padding: EdgeInsets.only(top: 50, left: 5, right: 5),),
          Text("About US:", style: TextStyle(fontSize: 50),),
          Text("We started as a group in college in 2020 in a mobile application class and decided to creat an online store as our group project",style: TextStyle(fontSize: 20),),
          ],
          )
        ),
        ),
      
    );
  }
}