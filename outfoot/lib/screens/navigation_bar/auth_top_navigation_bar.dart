import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfoot/colors/colors.dart';
import 'package:outfoot/api/checkpage_delete_api.dart';

class AuthTopNavigationBar extends StatefulWidget
    implements PreferredSizeWidget {
  final int checkPageId; // 삭제할 도장판 ID

  AuthTopNavigationBar({required this.checkPageId});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  _MeterialTopNavigationBarState createState() =>
      _MeterialTopNavigationBarState();
}

class _MeterialTopNavigationBarState extends State<AuthTopNavigationBar> {
  final CheckPageApi _checkPageApi = CheckPageApi(); // CheckPageApi 객체 생성

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: lightColor1,
      elevation: 0,
      leading: IconButton(
        icon: _buildCustomItem(
          'assets/back_icon.svg',
          width: 17.375,
          height: 18.688,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(
        '인증 보기',
        style: TextStyle(
          color: Color(0xFF3F3F3F),
          fontSize: 16,
          fontFamily: 'Pretendard',
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w600,
          height: 1.1,
          letterSpacing: -0.32,
        ),
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: _buildCustomItem(
            'assets/icon/edit.svg',
            width: 18.945,
            height: 22.219,
          ),
          onPressed: () {
            // 수정 버튼을 누른 뒤 다음 동작
          },
        ),
        IconButton(
          icon: _buildCustomItem(
            'assets/share_icon.svg',
            width: 18.945,
            height: 22.219,
          ),
          onPressed: () {
            // 공유 버튼을 누른 뒤 다음 동작
          },
        ),
        IconButton(
          icon: _buildCustomItem(
            'assets/delete_icon.svg',
            width: 17.363,
            height: 21.565,
          ),
          onPressed: () =>
              _showDeleteConfirmationDialog(context), // 삭제 확인 다이얼로그 표시
        ),
      ],
    );
  }

  // 커스텀 아이콘 빌더
  Widget _buildCustomItem(String iconPath,
      {required double width, required double height}) {
    return SvgPicture.asset(
      iconPath,
      width: width,
      height: height,
    );
  }

  // 삭제 확인 다이얼로그 표시
  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('삭제 확인'),
          content: Text('이 도장판을 삭제하시겠습니까?'),
          actions: <Widget>[
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('삭제'),
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
                _deleteCheckPage(context); // 삭제 요청 수행
              },
            ),
          ],
        );
      },
    );
  }

  // 삭제 요청 수행 함수
  Future<void> _deleteCheckPage(BuildContext context) async {
    try {
      await _checkPageApi.deleteCheckPage(widget.checkPageId); // 반환값 사용하지 않음
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('도장판이 성공적으로 삭제되었습니다.')),
      );
      Navigator.of(context).pop(); // 삭제 후 이전 화면으로 이동
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('도장판 삭제에 실패했습니다. 다시 시도해주세요.')),
      );
      print('Error deleting CheckPage: $e');
    }
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthTopNavigationBar(checkPageId: 1), // 예시로 ID 1 전달
      body: Center(child: Text('body')),
    );
  }
}
