import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfoot/screens/login/login_page_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    // 3초 대기 후 애니메이션 시작 및 페이지 이동
    Future.delayed(Duration(seconds: 1), () {
      _animationController.forward().whenComplete(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPageScreen()),
        );
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC8AA9B), // 배경색
      body: Center(
        child: FadeTransition(
          opacity: _animationController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/logo.svg',
                width: 215,
                height: 86,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
