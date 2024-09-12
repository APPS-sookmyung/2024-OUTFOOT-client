import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommentBottomNavigationBar extends StatefulWidget {
  @override
  _CommentBottomNavigationBarState createState() => _CommentBottomNavigationBarState();
}

class _CommentBottomNavigationBarState extends State<CommentBottomNavigationBar> {
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
        width: double.infinity,
        height: 84.0,
        decoration: BoxDecoration(
          color: Colors.white,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                width: 335.0, 
                height: 38.0,
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(bottom:13, left:13), 
                    border: InputBorder.none,
                    hintText: '댓글을 입력해주세요',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF8B8B8B),
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      height: 1.1,
                      letterSpacing: -0.28,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: SvgPicture.asset(
                'assets/paw_another.svg',
                width: 27.0,
                height: 32.0, 
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CommentBottomNavigationBar(),
  ));
}

