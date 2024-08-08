import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigationBarExample extends StatefulWidget {
  @override
  _BottomNavigationBarExampleState createState() => _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Navigation Bar'),
      ),
      body: Center(child: Text('Body')),
      bottomNavigationBar: Container(
        width: 360.0,
        height: 84.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // 그림자 색상과 투명도
              offset: Offset(0, -4), // 그림자의 위치
              blurRadius: 8, // 그림자 흐림 정도
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: _buildCustomItem(
                  'assets/search.svg',
                  '둘러보기',
                  index: 0,
                ),
                label: '', // 레이블을 빈 문자열로 설정
              ),
              BottomNavigationBarItem(
                icon: _buildCustomItem(
                  'assets/home.svg',
                  '홈',
                  index: 1,
                ),
                label: '', // 레이블을 빈 문자열로 설정
              ),
              BottomNavigationBarItem(
                icon: _buildCustomItem(
                  'assets/profile.svg',
                  '마이페이지',
                  index: 2,
                ),
                label: '', // 레이블을 빈 문자열로 설정
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Color(0xFF79D7FF), // 선택된 항목 색상
            unselectedItemColor: Color(0xFFCFCFCF), // 선택되지 않은 항목 색상
            onTap: _onItemTapped,
              selectedLabelStyle: TextStyle(
              fontSize: 11,
              fontFamily: 'Pretendard',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              height: 1.1,
              letterSpacing: -0.22,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: 11,
              fontFamily: 'Pretendard',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              height: 1.1,
              letterSpacing: -0.22,
            ),
            showSelectedLabels: false, // 선택된 레이블 숨기기
            showUnselectedLabels: false, // 선택되지 않은 레이블 숨기기
          ),
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
            color: _selectedIndex == index ? Color(0xFF79D7FF) : Color(0xFFCFCFCF),
          ),
          SizedBox(height: 6.93), // 아이콘과 레이블 사이의 간격
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'Pretendard',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              height: 1.1,
              letterSpacing: -0.22,
              color: _selectedIndex == index ? Color(0xFF79D7FF) : Color(0xFFCFCFCF),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: BottomNavigationBarExample(),
  ));
}
