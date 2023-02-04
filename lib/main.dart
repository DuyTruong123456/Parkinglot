import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase.dart';
import 'login.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'camera.dart';
import 'package:flutter/cupertino.dart';
import 'sqlite.dart';
Future<void> main() async {
  // Fetch the available cameras before initializing the app.
  //droptable();
  getdata();

  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    logError(e.code, e.description);
  }
  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: (context, _) => MyMainApp(),
    ));
}
class MyMainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.black,

        // Define the default font family.
        fontFamily: 'Georgia',

        elevatedButtonTheme: ElevatedButtonThemeData(style:ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(Colors.grey),
          foregroundColor:MaterialStateProperty.all<Color>(Colors.black),

        )),
        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: LoginPage(),
    );
  }
}
