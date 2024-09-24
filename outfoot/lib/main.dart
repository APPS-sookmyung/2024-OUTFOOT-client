import 'package:flutter/material.dart';
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
      home: LoginPageScreen(), // Set the LoginPageScreen as the home widget
    );
  }
}
