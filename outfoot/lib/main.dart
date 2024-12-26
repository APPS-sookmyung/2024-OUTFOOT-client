import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_template.dart';
import 'package:outfoot/screens/checkpage_foot.dart';
import 'package:outfoot/screens/home_page.dart';
import 'package:outfoot/screens/login/kakao_login_api.dart';
import 'package:outfoot/screens/login/login_page_screen.dart';
import 'package:outfoot/screens/login/user_controller.dart';
import 'package:outfoot/screens/make_goal/make_personal_goal.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 초기화
  await dotenv.load(fileName: 'assets/config/.env');
  KakaoSdk.init(nativeAppKey: dotenv.env['YOUR_NATIVE_APP_KEY']!);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserController(
        kakaoLoginApi: KakaoLoginApi(),
      ),
      child: MaterialApp(
        title: 'Login Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: CheckPageFoot(
          token:
              'eyJhbGciOiJIUzM4NCJ9.eyJ1c2VybmFtZSI6IjI4YzU1OGM4LTdlODktNGFiOC04MDE5LWI0MGFmOTI3MTdlZiIsIm5pY2tuYW1lIjoi7J207ZW066a8IiwiaWF0IjoxNzMxNDg1NDcxLCJleHAiOjE3MzE0OTI2NzF9.YS6MuCXZ-dcHhAszSgKVVen3Y0OWLBDxymMSqjS9LIvzHzjRc2wNsCXMD3BcFBhu', // 임시 값
          checkPageId: '1', // 임시 값
        ),
      ),
    );
  }
}
