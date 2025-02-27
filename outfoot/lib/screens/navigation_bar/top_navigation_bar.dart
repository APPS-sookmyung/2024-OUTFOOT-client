import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfoot/colors/colors.dart';
import 'package:outfoot/api/checkpage_delete_api.dart';

class TopNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  final int checkPageId; // 삭제할 도장판 ID
  final VoidCallback onDeleteModeToggle;

  TopNavigationBar(
      {required this.checkPageId, required this.onDeleteModeToggle});

  final CheckPageApi _checkPageApi = CheckPageApi(); // CheckPageApi 객체 생성

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: lightColor1,
      elevation: 0,
      title: SvgPicture.asset(
        'assets/start_login_logo.svg',
        width: 118,
        height: 33,
      ),
      centerTitle: false,
      leading: null,
      actions: <Widget>[
        IconButton(
          icon: _buildCustomItem(
            'assets/alarm_icon.svg',
            width: 19,
            height: 22,
          ),
          onPressed: () {
            // 알림 버튼을 누른 뒤 다음 동작
          },
        ),
        IconButton(
          icon: _buildCustomItem(
            'assets/delete_icon.svg',
            width: 17.363,
            height: 21.565,
          ),
          onPressed: onDeleteModeToggle,
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
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
            ),
            TextButton(
              child: Text('삭제'),
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
                _deleteCheckPage(context); // 삭제 API 호출
              },
            ),
          ],
        );
      },
    );
  }

  // 삭제 API 호출 함수
  Future<void> _deleteCheckPage(BuildContext context) async {
    try {
      await _checkPageApi.deleteCheckPage(checkPageId); // 반환값 사용하지 않음
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

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isDeleteMode = false; // 삭제 모드 상태

  void _toggleDeleteMode() {
    setState(() {
      _isDeleteMode = !_isDeleteMode; // 삭제 모드 토글
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavigationBar(
        checkPageId: 1,
        onDeleteModeToggle: _toggleDeleteMode,
      ), // 예시로 ID 1 전달
      body: Center(child: Text('body')),
    );
  }
}
