import 'package:flutter/material.dart';
import 'package:outfoot/screens/make_goal/make_personal_goal.dart';
import 'package:outfoot/screens/login_find_id.dart';
import 'package:outfoot/screens/login_page_screen.dart';
import 'package:outfoot/screens/start_login_page_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPageScreen(), 
    );
  }
}
