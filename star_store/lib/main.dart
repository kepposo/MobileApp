import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
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
import 'package:path/path.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'notification.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class User {
  String name;
  String email;
  String password;
  User({this.name, this.email, this.password});
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'user{name: $name}';
  }
}

Future<Database> dbconn() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'users.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE user(id INTEGER PRIMARY KEY, name TEXT, email TEXT, password TEXT)",
      );
    },
    version: 1,
  );
  return database;
}

Future<void> insertUsers(User user) async {
  final Database db = await dbconn();

  await db.insert(
    'user',
    user.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

bool cred = false;
User current = User(email: 'Guest', name: 'Guest');
dynamic getAll(
  String email,
  pass,
) async {
  final Database db = await dbconn();

  final res = await db.rawQuery("SELECT * FROM User WHERE email =='$email'");
  var u = res[0]['password'];

  if (u == pass) {
    cred = true;
    current = User(name: res[0]['name'], email: res[0]['email']);
    print(current.name);
    print('true');
  } else {
    print('failed');
  }
  return current;
}

void delTable() async {
  final Database db = await dbconn();
  final all = await db.rawQuery("SELECT * FROM User ");

  for (var i in all) {
    var id = i['id'];
    print(id);
    await db.rawQuery("DELETE FROM User WHERE id == '$id';");
  }
}






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
      home: new HomeScreen(payload: payload,),
      routes: <String, WidgetBuilder>{
        '/homepage': (BuildContext context) => new HomeScreen(payload: payload,),
        '/register': (BuildContext context) => new SignUp(),
        '/login': (BuildContext context) => new Login(),
        '/item-list': (BuildContext context) => new ItemList("", ""),
        '/about-us': (BuildContext context) => new AboutUs(),
        '/contact-us': (BuildContext context) => new ContactUs(),
        '/cam': (BuildContext context) => new TakePictureScreen(camera: firstCamera,),
        '/sellers': (BuildContext context) => new Sellers(),
        '/noti': (BuildContext context) => new Notifications(),
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

String payload = null;
