

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:thiago_exchange/intro.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  runApp(const MyApp());

  AwesomeNotifications().initialize("resource://drawable/lawson", [
    NotificationChannel(
      channelShowBadge: true,
      channelKey: "Basics",
      channelName: "Thiago",
      channelDescription: "Notifications",
      playSound: true,
      enableVibration: true,
    )
  ]);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Intro1() ,
    );
  }
}

Future<void> _handler( RemoteMessage message) async{
  print("Notifications ${message.data}");
  AwesomeNotifications().createNotificationFromJsonData(message.data);

}
