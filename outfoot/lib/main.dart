import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outfoot/utils/goal_provider.dart';
import 'package:provider/provider.dart';

// 시작 페이지 import
import 'package:outfoot/screens/login/start_login_page_screen.dart';
import 'package:outfoot/screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 초기화
  await dotenv.load(fileName: 'assets/config/.env');

  print(dotenv.env['ACCESS_TOKEN']); // 값을 출력해 확인

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GoalProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false; // 로그인 상태 저장
  bool _isLoading = true; // 로딩 상태 표시

  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); // 로그인 상태 확인
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    // 로그인 여부 확인 (key: 'isLoggedIn')
    bool? loggedIn = prefs.getBool('isLoggedIn') ?? false;

    setState(() {
      _isLoggedIn = true; // loggedIn; 실제 로그인 상태 반영
      _isLoading = false; // 로딩 완료
    });
  }

  @override
  Widget build(BuildContext context) {
    // ScreenUtil 초기화
    return ScreenUtilInit(
      designSize: Size(375, 812), // 디자인 화면 크기
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'OUTFOOT',
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: _isLoading
              ? Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : (_isLoggedIn ? HomePage() : StartLoginPageScreen()),
        );
      },
    );
  }
}
