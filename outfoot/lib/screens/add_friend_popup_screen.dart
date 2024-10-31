import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfoot/colors/colors.dart';

class AddFriendPopup extends StatelessWidget {
  const AddFriendPopup({super.key});

  TextStyle _textStyle(double fontSize, FontWeight fontWeight, Color color,
      double letterSpacing) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: 'Pretendard',
      fontStyle: FontStyle.normal,
      fontWeight: fontWeight,
      color: color,
      height: 0.8,
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

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.all(16.0),
          title: Column(
            mainAxisSize: MainAxisSize.min, // Column의 크기를 자식 요소에 맞추기
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '친구 추가 성공',
                    textAlign: TextAlign.center,
                    style: _textStyle(16.0, FontWeight.w400, greyColor2, -0.32),
                  ),
                  SizedBox(width: 8.0),
                  _svgIcon('assets/icon/party_popper.svg',
                      width: 24.0, height: 24.0),
                ],
              ),
              SizedBox(height: 25.0),
              Text(
                '친구 추가에 성공했어요',
                textAlign: TextAlign.center,
                style: _textStyle(18.0, FontWeight.w500, greyColor1, -0.36),
              ),
            ],
          ),
          actions: <Widget>[
            SizedBox(height: 33.0),
            TextButton(
              child: Text(
                '닫기',
                style: _textStyle(16.0, FontWeight.w600, mainBrownColor, -0.32),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
          '친구 추가하기',
          style: _textStyle(16.0, FontWeight.w600, greyColor1, -0.32),
        ),
      ),
      body: Container(
        color: lightColor1,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 24.0),
              Container(
                width: 320.0,
                height: 128.775,
                decoration: _boxDecoration(
                  darkBrownColor,
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 27.05,
                      left: 30.38,
                      child: Text(
                        '친구를 초대해보세요',
                        style: _textStyle(
                            11.0, FontWeight.w400, lightMainColor, -0.22),
                      ),
                    ),
                    Positioned(
                      top: 43.84,
                      left: 30.38,
                      child: Text(
                        '내 코드',
                        style: _textStyle(
                            14.0, FontWeight.w500, lightMainColor, -0.28),
                      ),
                    ),
                    Positioned(
                      top: 53.82,
                      right: 16.71,
                      child: _svgIcon('assets/icon/logo_basic.svg'),
                    ),
                    Positioned(
                      top: 79.15,
                      left: 30.38,
                      child: Row(
                        children: <Widget>[
                          Text(
                            'A29NB67',
                            style: _textStyle(
                                20.0, FontWeight.w600, lightMainColor, -0.4),
                          ),
                          SizedBox(width: 8.0),
                          _svgIcon('assets/icon/copy.svg'),
                          SizedBox(width: 8.0),
                          Text(
                            '복사하기',
                            style: _textStyle(
                                11.0, FontWeight.w400, lightMainColor, -0.22),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 19.0),
              _svgIcon('assets/arrow.svg', width: 17.0, height: 16.0),
              SizedBox(height: 29.0),
              Container(
                width: 320.0,
                height: 133.185,
                decoration: _boxDecoration(beigeColor),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '친구에게 받은 코드를 입력해주세요',
                        style: _textStyle(
                            11.0, FontWeight.w400, greyColor2, -0.22),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '친구 코드',
                        style: _textStyle(
                            14.0, FontWeight.w500, greyColor1, -0.28),
                      ),
                      SizedBox(height: 19.03),
                      Container(
                        width: double.infinity,
                        height: 41.108,
                        decoration: _boxDecoration(lightColor2),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.76, vertical: 15.0),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '친구 코드 입력',
                              hintStyle: _textStyle(
                                  14.0, FontWeight.w400, greyColor4, -0.28),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 31.16),
              GestureDetector(
                onTap: () => _showPopup(context),
                child: Container(
                  width: 320.0,
                  height: 45.994,
                  decoration: _boxDecoration(mainBrownColor),
                  child: Center(
                    child: Text(
                      '추가하기',
                      textAlign: TextAlign.center,
                      style: _textStyle(
                          14.0, FontWeight.w600, lightMainColor, -0.28),
                    ),
                  ),
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
