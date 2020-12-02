import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'home_screen.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();



  class Notifications extends StatefulWidget {
    @override
    _NotificationsState createState() => _NotificationsState();
  }
  
  class _NotificationsState extends State<Notifications> {


    void initState() {
      super.initState();
      var initializationSettingsAndroid = AndroidInitializationSettings('flutter_devs');
      var initializationSettingsIOs = IOSInitializationSettings();
      var initSetttings = InitializationSettings(initializationSettingsAndroid, initializationSettingsIOs);
      flutterLocalNotificationsPlugin.initialize(initSetttings,onSelectNotification: onSelectNotification);
    }

    Future onSelectNotification(String payload) {
      return
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen(payload: payload,)));
    }


  showNotification() async {
    var android = AndroidNotificationDetails(
        'id', 'channel ', 'description',
        priority: Priority.High, importance: Importance.Max);
    var iOS = IOSNotificationDetails();
    var platform = new NotificationDetails(android, iOS);
    await flutterLocalNotificationsPlugin.show(0, 'Flutter devs', 'Flutter Local Notification Demo', platform, payload: 'Welcome to the Local Notification demo'); 
  }

  Future<void> scheduleNotification() async {
  var scheduledNotificationDateTime =
      DateTime.now().add(Duration(seconds: 5));
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'channel id',
    'channel name',
    'channel description',
    icon: 'flutter_devs',
    largeIcon: DrawableResourceAndroidBitmap('flutter_devs'),
  );
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.schedule(
      0,
      'scheduled title',
      'scheduled body',
      scheduledNotificationDateTime,
      platformChannelSpecifics);
}


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body:
        Column(children: <Widget>[
          FloatingActionButton(onPressed: showNotification)
        ],)
        
      );
    }
  }