import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LoginPageScreen extends StatefulWidget {
  @override
  _LoginPageScreenState createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  int _currentPage = 0;
  final CarouselController _carouselController = CarouselController();

  // Carousel items with corresponding images (text is separate now)
  final List<Map<String, dynamic>> _carouselItems = [
    {
      "image": "assets/login_image1.svg", // SVG 파일 경로
      "width": 315.0,
      "height": 288.0,
    },
    {
      "image": "assets/login_image2.svg", // SVG 파일 경로
      "width": 335.0,
      "height": 369.0,
    },
  ];

  // Separate text list for the carousel
  final List<String> _carouselTexts = [
    "어렵게 생각하던 것들,\n더 이상 미뤄둘 수는\n없을 때",
    "조그마한\n동기부여가\n필요한 모두에게",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF7F0),
      body: SafeArea(
        child: Stack(
          children: [
            // Positioned to place the logo 20px from the left and 80px from the top
            Positioned(
              left: 20,
              top: 80,
              child: SvgPicture.asset(
                'assets/logo.svg',
                width: 137,
                height: 45,
              ),
            ),
            // Stack for text and image only with dynamic height
            Positioned(
              left: 27,
              right: 0,
              top: 166, // Logo height + padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display the text according to the current page
                  Text(
                    _carouselTexts[_currentPage],
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5B411C),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 25), // 이미지와 인디케이터 사이의 거리
                  // Carousel Slider for images
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
                      height: 400,
                      enableInfiniteScroll: true,
                      viewportFraction: 1.0, // Show one item per page
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentPage = index; // Update the current page
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Page indicators, positioned below the image by 25px
            Positioned(
              left: 0,
              right: 0,
              bottom: 124 + 34 + 45, // PageIndicator와 버튼 사이 34px 간격 유지
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _carouselItems.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _carouselController.animateToPage(entry.key),
                    child: Container(
                      width: 8.0,
                      height: 8.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == entry.key
                            ? Color(0xFFC8AA9B) // Active indicator color
                            : Color(
                                0x4DC8AA9B), // Inactive indicator color with 30% opacity
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            // Login buttons
            Positioned(
              left: 30,
              right: 30,
              bottom: 45, // 45px from bottom for "다른 방법으로 로그인"
              child: Column(
                children: [
                  // Kakao login button
                  _loginButton(
                    '카카오 계정으로 로그인',
                    Color(0xFFFAE100), // Yellow color for Kakao button
                    Colors.black,
                  ),
                  SizedBox(height: 8),
                  // Naver login button
                  _loginButton(
                    '네이버 로그인',
                    Color(0xFF03CF5D), // Green color for Naver button
                    Colors.white,
                  ),
                  SizedBox(height: 15),
                  // Other login methods button
                  TextButton(
                    onPressed: () {
                      print("다른 방법으로 로그인 pressed");
                    },
                    style: TextButton.styleFrom(
                      primary: Color(0xFF656565),
                      textStyle: TextStyle(fontSize: 12),
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

  // Helper function to create the login buttons with height 46 and corner radius 10
  Widget _loginButton(String text, Color bgColor, Color textColor) {
    return SizedBox(
      width: double.infinity,
      height: 46, // Set height to 46
      child: ElevatedButton(
        onPressed: () {
          print("$text button pressed");
        },
        style: ElevatedButton.styleFrom(
          primary: bgColor,
          padding:
              EdgeInsets.symmetric(vertical: 10), // Adjust padding if necessary
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Set corner radius to 10
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
