import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfoot/colors/colors.dart';

class FriendList extends StatelessWidget {
  const FriendList({super.key});

  TextStyle _textStyle(double fontSize, FontWeight fontWeight, Color color,
      double letterSpacing) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: 'Pretendard',
      fontStyle: FontStyle.normal,
      fontWeight: fontWeight,
      color: color,
      height: 0.8, // 1.1 있음
      letterSpacing: letterSpacing,
    );
  }

  BoxDecoration _boxDecoration(Color color, [List<BoxShadow>? boxShadow]) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: color,
      boxShadow: boxShadow,
    );
  }

  Widget _svgIcon(String assetName,
      {double? width, double? height, BoxFit fit = BoxFit.none}) {
    return SvgPicture.asset(
      assetName,
      width: width,
      height: height,
      fit: fit,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightColor1,
        leading: _svgIcon('assets/icon/before_arrow.svg',
            width: 17.38, height: 8.69),
        centerTitle: true,
        title: Text(
          '친구 목록',
          style: _textStyle(16.0, FontWeight.w600, greycolor0, -0.32),
        ),
      ),
      body: Container(
        color: lightColor1,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20.0),
              Text(
                '총 3명',
                style: _textStyle(14.0, FontWeight.w400, greyColor3, -0.28),
              ),
              SizedBox(height: 8.0),
              for (int i = 0; i < 3; i++)
                Container(
                  width: 320.0,
                  height: 88.0,
                  margin: EdgeInsets.only(bottom: 10.0),
                  padding:
                      EdgeInsets.symmetric(vertical: 13.0, horizontal: 19.0),
                  decoration: _boxDecoration(lightColor2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 61.0,
                        height: 61.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: yellowColor,
                        ),
                        child: Center(
                          child: Text(
                            '샘',
                            style: _textStyle(
                                20.0, FontWeight.w600, greyColor1, -0.4),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '샘스미스',
                                  style: _textStyle(
                                      16.0, FontWeight.w500, greyColor1, -0.32),
                                ),
                                SizedBox(width: 8.0),
                                _svgIcon('assets/icon/next_arrow.svg',
                                    width: 20.0, height: 20.0),
                              ],
                            ),
                            SizedBox(height: 5.0),
                            Text('암 낫 디 온리원~',
                                style: _textStyle(
                                    12.0, FontWeight.w400, greyColor2, -0.22)),
                          ],
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            decoration: _boxDecoration(lightMainColor),
                            width: 49.0,
                            height: 26.0,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: redColor,
                              ),
                              onPressed: () {
                                // 삭제 버튼 클릭 시 처리할 내용
                              },
                              child: Text(
                                '삭제',
                                style: _textStyle(
                                    14.0, FontWeight.w400, redColor, -0.28),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 84.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: lightMainColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              spreadRadius: 4,
              blurRadius: 30,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          unselectedLabelStyle:
              _textStyle(11.0, FontWeight.w500, greyColor6, -0.22),
          selectedLabelStyle:
              _textStyle(11.0, FontWeight.w500, mainBrownColor, -0.22),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: _svgIcon('assets/search.svg', width: 25.57, height: 25.34),
              label: '둘러보기',
            ),
            BottomNavigationBarItem(
              icon: _svgIcon('assets/home.svg', width: 23.25, height: 27.04),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: _svgIcon('assets/profile.svg', width: 27.59, height: 25.8),
              label: '마이페이지',
            ),
          ],
        ),
      ),
    );
  }
}
