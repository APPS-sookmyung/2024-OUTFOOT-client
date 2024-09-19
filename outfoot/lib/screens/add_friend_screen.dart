import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddFriend extends StatelessWidget {
  const AddFriend({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFEFD),
        leading:
            _svgIcon('assets/icon/Vector 265.svg', width: 17.38, height: 8.69),
        centerTitle: true,
        title: Text(
          '친구 추가하기',
          style: _textStyle(16.0, FontWeight.w600, Color(0xFF3E3E3E), -0.32),
        ),
      ),
      body: Container(
        color: Color(0xFFFFFEFD),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0),
                    child: Text(
                      '내 코드 공유하기',
                      style: _textStyle(
                          14.0, FontWeight.w500, Color(0xFF3E3E3E), -0.28),
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    '내 코드를 공유해 친구를 초대하세요',
                    style: _textStyle(
                        11.0, FontWeight.w400, Color(0xFF656565), -0.22),
                  ),
                ],
              ),
              SizedBox(height: 9.0),
              Container(
                width: 320.0,
                height: 128.775,
                decoration: _boxDecoration(
                  Color(0xFF6D4C3A),
                  [
                    BoxShadow(
                      color: Color(0xFF45C7FF).withOpacity(0.22),
                      offset: Offset(4, 4),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 27.05,
                      left: 30.38,
                      child: Text(
                        '친구를 초대해보세요',
                        style: _textStyle(
                            11.0, FontWeight.w400, Colors.white, -0.22),
                      ),
                    ),
                    Positioned(
                      top: 43.84,
                      left: 30.38,
                      child: Text(
                        '내 코드',
                        style: _textStyle(
                            14.0, FontWeight.w500, Colors.white, -0.28),
                      ),
                    ),
                    Positioned(
                      top: 53.82,
                      right: 16.71,
                      child: _svgIcon('assets/icon/Group 2130.svg'),
                    ),
                    Positioned(
                      top: 79.15,
                      left: 30.38,
                      child: Row(
                        children: <Widget>[
                          Text(
                            'A29NB67',
                            style: _textStyle(
                                20.0, FontWeight.w600, Colors.white, -0.4),
                          ),
                          SizedBox(width: 8.0),
                          _svgIcon('assets/icon/Group 2155.svg'),
                          SizedBox(width: 8.0),
                          Text(
                            '복사하기',
                            style: _textStyle(
                                11.0, FontWeight.w400, Colors.white, -0.22),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18.75),
              _svgIcon('assets/icon/Group 2206.svg',
                  width: 25.57, height: 25.34),
              SizedBox(height: 23.69),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0),
                    child: Text(
                      '친구 추가하기',
                      style: _textStyle(
                          14.0, FontWeight.w500, Color(0xFF3E3E3E), -0.28),
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    '추가할 친구 코드를 입력하세요',
                    style: _textStyle(
                        11.0, FontWeight.w400, Color(0xFF656565), -0.22),
                  ),
                ],
              ),
              SizedBox(
                height: 9.0,
              ),
              Container(
                width: 320.0,
                height: 133.185,
                decoration: _boxDecoration(Color(0xFFFDFBF7)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '친구에게 받은 코드를 입력해주세요',
                        style: _textStyle(
                            11.0, FontWeight.w400, Color(0xFF656565), -0.22),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '친구 코드',
                        style: _textStyle(
                            14.0, FontWeight.w500, Color(0xFF3E3E3E), -0.28),
                      ),
                      SizedBox(height: 19.03),
                      Container(
                        width: double.infinity,
                        height: 41.108,
                        decoration: _boxDecoration(Color(0xFFFAF7F0)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.76, vertical: 15.0),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '친구 코드 입력',
                              hintStyle: _textStyle(14.0, FontWeight.w400,
                                  Color(0xFFA4A4A4), -0.28),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 31.16),
              Container(
                width: 320.0,
                height: 45.994,
                decoration: _boxDecoration(Color(0xFFC8AA9B)),
                child: Center(
                  child: Text(
                    '추가하기',
                    textAlign: TextAlign.center,
                    style:
                        _textStyle(14.0, FontWeight.w600, Colors.white, -0.28),
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
          color: Colors.white,
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
              _textStyle(11.0, FontWeight.w500, Color(0xFFCFCFCF), -0.22),
          selectedLabelStyle:
              _textStyle(11.0, FontWeight.w500, Color(0xFF79D7FF), -0.22),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: _svgIcon('assets/icon/Group 2150.svg',
                  width: 25.57, height: 25.34),
              label: '둘러보기',
            ),
            BottomNavigationBarItem(
              icon: _svgIcon('assets/icon/Group 2149.svg',
                  width: 23.25, height: 27.04),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: _svgIcon('assets/icon/Group 2147.svg',
                  width: 27.59, height: 25.8),
              label: '마이페이지',
            ),
          ],
        ),
      ),
    );
  }
}
