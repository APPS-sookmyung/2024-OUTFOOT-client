import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfoot/colors/colors.dart';

// 이동 페이지
import 'package:outfoot/screens/home_page.dart';
import 'package:outfoot/screens/profile_my_page.dart';
import 'package:outfoot/screens/checkpage_foot.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;

  const CustomBottomNavigationBar({
    Key? key,
    this.selectedIndex = 0, // 기본값은 0
  }) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex; // 초기값 설정
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0: // 둘러보기
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => CheckPageFoot(
                    token:
                        'eyJhbGciOiJIUzM4NCJ9.eyJ1c2VybmFtZSI6ImZmOTdmYTc1LTE1ODMtNGMxNi04ZjZmLWJjZTQyM2RlMDYxMCIsIm5pY2tuYW1lIjoi7KCV7ISc7JewIiwiaWF0IjoxNzM1MDkzMDA0LCJleHAiOjE3MzUxMDAyMDR9.6XdQxmfXW8Gn2a9L9u1iqTuaV47eoASnrYxz8Cj5x24OqZJ6mgSvOgBDgct6jxV0',
                    checkPageId: '1',
                    goalImagePath: 'default_image_path',
                  )), // 둘러보기 페이지
        );
        break;
      case 1: // 홈
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 2: // 마이페이지
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfileMyPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 84.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, -4),
            blurRadius: 8,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: BottomNavigationBar(
          backgroundColor: lightMainColor, // 여기에 배경색을 설정
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: _buildCustomItem(
                'assets/search.svg',
                '둘러보기',
                index: 0,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _buildCustomItem(
                'assets/home.svg',
                '홈',
                index: 1,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _buildCustomItem(
                'assets/profile.svg',
                '마이페이지',
                index: 2,
              ),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: mainBrownColor,
          unselectedItemColor: greyColor6,
          onTap: _onItemTapped,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
      ),
    );
  }

  Widget _buildCustomItem(String iconPath, String label, {required int index}) {
    return Container(
      width: 80.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 24.0,
            height: 24.0,
            color: _selectedIndex == index ? mainBrownColor : greyColor6,
          ),
          SizedBox(height: 6.93),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'Pretendard',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              height: 1.1,
              letterSpacing: -0.22,
              color: _selectedIndex == index ? mainBrownColor : greyColor6,
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(child: Text("Main Content")),
      bottomNavigationBar: CustomBottomNavigationBar(),
    ),
  ));
}
