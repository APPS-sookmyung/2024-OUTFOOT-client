import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopNavigationBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFFFFEFD),
      elevation: 0,
      title : SvgPicture.asset(
        'assets/logo.svg',
        width: 118,
        height: 33,
        
      ),
    centerTitle: false,
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