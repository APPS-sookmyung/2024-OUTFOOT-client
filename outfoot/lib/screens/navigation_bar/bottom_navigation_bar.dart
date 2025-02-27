import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv 추가
import 'package:outfoot/colors/colors.dart';

// 이동 페이지 import
import 'package:outfoot/screens/home_page.dart';
import 'package:outfoot/screens/profile_my_page.dart';
import 'package:outfoot/screens/checkpage_foot.dart' as checkPage;

class CustomBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final String? token;

  const CustomBottomNavigationBar({
    Key? key,
    this.selectedIndex = 0, // 기본값은 0
    this.token,
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
    debugPrint('Access Token: ${widget.token}');
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return; // 현재 선택된 페이지를 다시 선택하면 아무 동작 안 함.

    Widget nextPage;
    switch (index) {
      case 0: // 둘러보기 (추후 추가 가능)
        return;
      case 1: // 홈
        nextPage = HomePage();
        break;
      case 2: // 마이페이지
        nextPage = const ProfileMyPage();
        break;
      default:
        return;
    }

    // 네비게이션 실행 (setState() 제거)
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => nextPage),
      (route) => false,
    );

    // 상태 업데이트 (네비게이션 후 실행)
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
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, -4),
            blurRadius: 8,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: BottomNavigationBar(
          backgroundColor: lightMainColor, // 배경색 설정
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
          const SizedBox(height: 6.93),
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
      body: HomePage(), // 기본 시작 화면 설정
      bottomNavigationBar: CustomBottomNavigationBar(),
    ),
  ));
}
