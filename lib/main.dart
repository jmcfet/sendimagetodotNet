import 'package:flutter/material.dart';
import 'picker.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Login',

      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new ImagePickerUI(),
    );
  }
}
