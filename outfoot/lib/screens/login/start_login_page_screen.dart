import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfoot/colors/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartLoginPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor1,
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Positioned(
              left: 20.w,
              top: 80.h,
              child: SvgPicture.asset(
                'assets/start_login_logo.svg',
                width: 137.w,
                height: 45.h,
              ),
            ),
            SizedBox(height: 30.0.h),
            Text(
              '시작하기',
              style: TextStyle(
                fontSize: 24.sp,
                color: Color(0xFF4E3227),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0.h),
            TextField(
              decoration: InputDecoration(
                labelText: '아이디를 입력해주세요',
                labelStyle: TextStyle(color: milkBrownColor2),
                fillColor: lightColor4,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 15.0.h),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: '비밀번호를 입력해주세요',
                labelStyle: TextStyle(color: milkBrownColor2),
                fillColor: lightColor4,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20.0.h),
            Center(
              child: SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD1B6A1), // 버튼 색상 설정
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0.r),
                    ),
                  ),
                  child: Text(
                    '로그인',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0.h),
            Center(
              child: Text(
                '아이디 찾기 | 비밀번호 찾기 | 회원가입',
                style: TextStyle(
                  color: milkBrownColor2,
                  fontSize: 14.sp,
                ),
              ),
            ),
            SizedBox(height: 30.0.h),
            Center(
              child: Column(
                children: [
                  Text(
                    '간편 로그인',
                    style: TextStyle(
                      color: milkBrownColor2,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 24.0.h),
                  Positioned(
                    left: 30.w,
                    right: 30.w,
                    bottom: 45.h,
                    child: Column(
                      children: [
                        _loginButton(
                          '카카오 계정으로 로그인',
                          Color(0xFFFAE100),
                          Colors.black,
                        ),
                        SizedBox(height: 8.h),
                        _loginButton(
                          '네이버 로그인',
                          Color(0xFF03CF5D),
                          Colors.white,
                        ),
                        SizedBox(height: 15.h),
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
      height: 46.h,
      child: ElevatedButton(
        onPressed: () {
          print("$text button pressed");
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          padding: EdgeInsets.symmetric(vertical: 10.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          textStyle: TextStyle(fontSize: 16.sp),
        ),
        child: Text(
          text,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
