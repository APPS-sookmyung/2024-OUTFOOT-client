import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFFAF7F0),
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
        '내 목표',
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
          onPressed: () {
            // 삭제 버튼을 누른 뒤 다음 동작
          },
        ),
      ],
    );
  }

  Widget _buildCustomItem(String iconPath, {required double width, required double height}) {
    return SvgPicture.asset(
      iconPath,
      width: width,
      height: height,
    );
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
      appBar: TopNavigationBar(),
      body: Center(child: Text('body')),
    );
  }
}
