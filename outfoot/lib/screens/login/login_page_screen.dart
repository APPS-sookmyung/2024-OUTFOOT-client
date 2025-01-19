import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:outfoot/colors/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPageScreen extends StatefulWidget {
  @override
  _LoginPageScreenState createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  int _currentPage = 0;
  final CarouselController _carouselController = CarouselController();

  final List<Map<String, dynamic>> _carouselItems = [
    {
      "image": "assets/login_image1.svg",
      "width": 315.0.w,
      "height": 288.0.h,
    },
    {
      "image": "assets/login_image2.svg",
      "width": 335.0.w,
      "height": 369.0.h,
    },
  ];

  final List<String> _carouselTexts = [
    "어렵게 생각하던 것들,\n더 이상 미뤄둘 수는\n없을 때",
    "조그마한\n동기부여가\n필요한 모두에게",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor2,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 20.w,
              top: 80.h,
              child: SvgPicture.asset(
                'assets/logo.svg',
                width: 137.w,
                height: 45.h,
              ),
            ),
            Positioned(
              left: 27.w,
              right: 0.w,
              top: 166.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _carouselTexts[_currentPage],
                    style: TextStyle(
                      fontSize: 23.sp,
                      fontWeight: FontWeight.bold,
                      color: blackBrownColor,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 25.h),
                  CarouselSlider.builder(
                    carouselController: _carouselController,
                    itemCount: _carouselItems.length,
                    itemBuilder: (context, index, realIndex) {
                      return SizedBox(
                        height: _carouselItems[index]["height"],
                        width: _carouselItems[index]["width"],
                        child: SvgPicture.asset(
                          _carouselItems[index]["image"],
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 400.h,
                      enableInfiniteScroll: true,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 124.h + 34.h + 45.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _carouselItems.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _carouselController.animateToPage(entry.key),
                    child: Container(
                      width: 8.0.w,
                      height: 8.0.h,
                      margin: EdgeInsets.symmetric(
                          vertical: 8.0.h, horizontal: 4.0.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == entry.key
                            ? mainBrownColor
                            : Color(0x4DC8AA9B),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
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
                  TextButton(
                    onPressed: () {
                      print("다른 방법으로 로그인 pressed");
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: greyColor2,
                      textStyle: TextStyle(fontSize: 12.sp),
                    ),
                    child: Text('다른 방법으로 로그인'),
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
