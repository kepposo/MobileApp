import 'package:flutter/material.dart';
import 'home_screen.dart';

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
      
    ); 
  } // Widget

}
