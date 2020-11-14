import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'register.dart';
import 'login.dart';
import 'item_list.dart';


void main() {
  runApp(StarStoreApp());
}

class StarStoreApp extends StatelessWidget {
@override
  Widget build(BuildContext context) 
  {
    
    return 
    new MaterialApp(
      home: new HomeScreen(),
      routes: <String, WidgetBuilder>{
        '/register': (BuildContext context) => new SignUp(),
        '/login': (BuildContext context) => new Login(),
        '/item-list': (BuildContext context) => new ItemList("", ""),
       // '/cartpage': (BuildContext context) => new Cartpage(),
       // '/profile': (BuildContext context) => new Profile(),
      }
    );
  }// Widget

}
