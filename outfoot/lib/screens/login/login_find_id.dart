import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfoot/colors/colors.dart';

class LoginFindIdPage extends StatefulWidget {
  @override
  _LoginFindIdPageState createState() => _LoginFindIdPageState();
}

class _LoginFindIdPageState extends State<LoginFindIdPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _verificationController1 =
      TextEditingController();
  final TextEditingController _verificationController2 =
      TextEditingController();
  final TextEditingController _verificationController3 =
      TextEditingController();
  final TextEditingController _verificationController4 =
      TextEditingController();

  bool _isVerified = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor1,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80),
              // Logo
              Center(
                child: SvgPicture.asset(
                  'assets/logo.svg',
                  width: 120,
                  height: 45,
                ),
              ),
              SizedBox(height: 40),
              // Title
              Text(
                '아이디 찾기',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: blackBrownColor,
                ),
              ),
              SizedBox(height: 8),
              // Email label
              Text(
                '이메일',
                style: TextStyle(
                  fontSize: 14,
                  color: blackBrownColor,
                ),
              ),
              SizedBox(height: 8),
              // Email input field
              Column(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: '사용하신 이메일 주소를 입력해주세요',
                        filled: true,
                        fillColor: lightColor3,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  // 인증 버튼
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isVerified = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: apricotColor2,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      _isVerified ? '인증 완료되었어요' : '인증',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              // 인증번호 입력창
              Text(
                '인증번호',
                style: TextStyle(
                  fontSize: 14,
                  color: blackBrownColor,
                ),
              ),
              SizedBox(height: 8),
              // 4개의 인증번호 입력칸
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _verificationNumberBox(_verificationController1),
                  _verificationNumberBox(_verificationController2),
                  _verificationNumberBox(_verificationController3),
                  _verificationNumberBox(_verificationController4),
                ],
              ),
              Spacer(),
              // 아이디 찾기 버튼
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // 아이디 찾기 로직
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: apricotColor2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      '아이디 찾기',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // 인증번호 입력 칸
  Widget _verificationNumberBox(TextEditingController controller) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: lightColor3,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            border: InputBorder.none,
            counterText: '',
          ),
        ),
      ),
    );
  }
}
