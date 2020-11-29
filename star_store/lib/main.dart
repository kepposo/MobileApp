import 'package:flutter/material.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'home_screen.dart';
import 'register.dart';
import 'login.dart';
import 'item_list.dart';
import 'about_us.dart';
import 'contact.dart';
import 'cam.dart';
import 'sellers.dart';
Future<void> main() async {

  camera();

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
        '/cam': (BuildContext context) => new TakePictureScreen(camera: firstCamera,),
        '/sellers': (BuildContext context) => new Sellers(),
      }
    );
  }// Widget

}
dynamic firstCamera = null;
Future<void> camera() async {

  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
   firstCamera = cameras.first;

return firstCamera;

}
