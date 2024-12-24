import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfoot/colors/colors.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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

