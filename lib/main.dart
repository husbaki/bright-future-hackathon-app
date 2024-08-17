import 'package:flutter/material.dart';
import 'CheckAuth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Quick Starter',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: CheckAuth(),
    );
  }
}
