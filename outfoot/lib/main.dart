import 'package:flutter/material.dart';
import 'package:outfoot/screens/add_friend_screen.dart';
import 'package:outfoot/screens/add_friend_popup_screen.dart';
import 'package:outfoot/screens/friend_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AddFriendPopup(),
    );
  }
}
