import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfoot/colors/colors.dart';

class StartLoginPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor1,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Positioned(
              left: 20,
              top: 80,
              child: SvgPicture.asset(
                'assets/start_login_logo.svg',
                width: 137,
                height: 45,
              ),
            ),
            SizedBox(height: 30.0),
            Text(
              '시작하기',
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFF4E3227),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            TextField(
              decoration: InputDecoration(
                labelText: '아이디를 입력해주세요',
                labelStyle: TextStyle(color: milkBrownColor2),
                fillColor: lightColor4,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 15.0),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: '비밀번호를 입력해주세요',
                labelStyle: TextStyle(color: milkBrownColor2),
                fillColor: lightColor4,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD1B6A1), // 버튼 색상 설정
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    '로그인',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Center(
              child: Text(
                '아이디 찾기 | 비밀번호 찾기 | 회원가입',
                style: TextStyle(
                  color: milkBrownColor2,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Center(
              child: Column(
                children: [
                  Text(
                    '간편 로그인',
                    style: TextStyle(
                      color: milkBrownColor2,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Positioned(
                    left: 30,
                    right: 30,
                    bottom: 45,
                    child: Column(
                      children: [
                        _loginButton(
                          '카카오 계정으로 로그인',
                          Color(0xFFFAE100),
                          Colors.black,
                        ),
                        SizedBox(height: 8),
                        _loginButton(
                          '네이버 로그인',
                          Color(0xFF03CF5D),
                          Colors.white,
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginButton(String text, Color bgColor, Color textColor) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: ElevatedButton(
        onPressed: () {
          print("$text button pressed");
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          padding: EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: TextStyle(fontSize: 16),
        ),
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
