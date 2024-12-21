import 'package:flutter/material.dart';
import 'package:outfoot/screens/checkpage_foot.dart';
import 'package:outfoot/screens/home_page.dart';
import 'package:outfoot/screens/login/login_page_screen.dart';
import 'package:outfoot/screens/make_goal/make_personal_goal.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:outfoot/screens/add_friend_popup_screen.dart';
import 'package:outfoot/screens/friend_list_screen.dart';
import 'package:outfoot/screens/upload.dart';
import 'package:outfoot/utils/goal_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 초기화
  await dotenv.load(fileName: 'assets/config/.env');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GoalProvider()),
      ],
      child: MyApp(),
    ),
  );
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
      home: Upload(),
    );
  }
}
