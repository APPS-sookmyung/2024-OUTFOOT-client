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

  final List<Map<String, dynamic>> _carouselItems = [
    {
      "text": "어렵게 생각하던 것들,\n 더 이상 미뤄둘 수는\n없을 때",
      "image": "assets/login_image.svg", // Change the SVG images accordingly
    },
    {
      "text": "조그마한\n동기부여가\n필요한 모두에게",
      "image": "assets/login_image.svg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 60),
            SvgPicture.asset('assets/logo.svg', height: 40), // App logo
            SizedBox(height: 40),
            CarouselSlider.builder(
              carouselController: _carouselController,
              itemCount: _carouselItems.length,
              itemBuilder: (context, index, realIndex) {
                return Column(
                  children: [
                    SvgPicture.asset(
                      _carouselItems[index]["image"],
                      height: 188,
                      width: 263,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        _carouselItems[index]["text"],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              },
              options: CarouselOptions(
                height: 350,
                autoPlay: false,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentPage = index;
                  });
                },
              ),
            ),
            Row(
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
                          ? Colors.brown // Highlight color for the active page
                          : Colors.grey[300], // Inactive color
                    ),
                  ),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                children: [
                  _buildButton(
                      '카카오 계정으로 로그인', Colors.yellow[700]!, Colors.black),
                  SizedBox(height: 8),
                  _buildButton('네이버 로그인', Colors.green, Colors.white),
                  SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      print("TextButton pressed");
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.grey,
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

  Widget _buildButton(String text, Color bgColor, Color textColor) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          primary: bgColor,
          padding: EdgeInsets.symmetric(vertical: 15),
          textStyle: TextStyle(fontSize: 16),
        ),
        child: Text(text, style: TextStyle(color: textColor)),
      ),
    );
  }
}
