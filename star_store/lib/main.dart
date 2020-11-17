import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'register.dart';
import 'login.dart';
import 'item_list.dart';
import 'about_us.dart';
import 'contact.dart';

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
        '/about-us': (BuildContext context) => new AboutUs(),
        '/contact-us': (BuildContext context) => new ContactUs(),
      }
    );
  }// Widget

}
