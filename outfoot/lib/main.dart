import 'package:flutter/material.dart';
import 'package:outfoot/screens/checkpage_foot.dart';
import 'package:outfoot/screens/login/login_page_screen.dart';
import 'package:outfoot/screens/make_goal/make_personal_goal.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: 'assets/config/.env');
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
      home: CheckPageFoot(),
    );
  }
}
