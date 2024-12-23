import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfoot/colors/colors.dart';
import 'package:outfoot/widgets/dashed_line_painter.dart';
import 'package:outfoot/widgets/switch.dart';

class SettingUI extends StatefulWidget {
  const SettingUI({super.key});

  @override
  State<SettingUI> createState() => _SettingUIState();
}

class _SettingUIState extends State<SettingUI> {
  static const double horizontalPadding = 20.0;
  static const double verticalPadding = 18.0;
  bool isNotificationEnabled = false;

  TextStyle _textStyle(double fontSize, FontWeight fontWeight, Color color,
      double letterSpacing, double height) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: 'Pretendard',
      fontStyle: FontStyle.normal,
      fontWeight: fontWeight,
      color: color,
      height: height,
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

  Widget buildRowWithDivider(String title, String subtitle) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: _textStyle(14, FontWeight.w400, greyColor1, -0.28, 1.2),
            ),
            SizedBox(width: 7.0),
            Text(
              subtitle,
              style: _textStyle(12, FontWeight.w400, greyColor4, -0.24, 1.2),
            ),
          ],
        ),
        SizedBox(height: 19),
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width, 1),
          painter: DashedLinePainter(color: greyColor8),
        ),
        SizedBox(height: 18),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor1, // Scaffold 전체 배경색을 설정
      appBar: AppBar(
        backgroundColor: lightColor1, // AppBar 배경색을 설정
        leading: _svgIcon('assets/icon/before_arrow.svg',
            width: 17.38, height: 8.69),
        centerTitle: true,
        title: Text(
          '설정',
          style: _textStyle(16.0, FontWeight.w600, greycolor0, -0.32, 0.8),
        ),
      ),
      body: SingleChildScrollView(
        // SingleChildScrollView로 감싸서 스크롤 가능하게
        child: Column(
          children: [
            SizedBox(height: 16),
            Container(
              width: 320,
              height: 92,
              decoration: _boxDecoration(mainBrownColor2),
              child: Row(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 27),
                      Container(
                        width: 25,
                        height: 30,
                        child: _svgIcon(
                          'assets/bell.svg',
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '마케팅, 홍보 등 알림 수신 허용',
                            style: _textStyle(11, FontWeight.w400,
                                lightMainColor, -0.22, 0.8),
                          ),
                          SizedBox(height: 6),
                          Text(
                            '알림 수신 동의',
                            style: _textStyle(14, FontWeight.w600,
                                lightMainColor, -0.28, 0.8),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 50),
                  CustomSwitch(
                    onCheckChange: (isShow) {
                      setState(() {
                        isNotificationEnabled = isShow;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 9),
            Container(
              width: 320,
              height: 60,
              decoration: _boxDecoration(yellowColor),
              child: Row(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 25),
                      Container(
                        width: 22,
                        height: 20,
                        child: _svgIcon(
                          'assets/crown.svg',
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(width: 21),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '달에 9,900원으로 구독하고\nPRO를 경험해보세요! ',
                            style: _textStyle(14, FontWeight.w400,
                                blackBrownColor, -0.28, 1.2),
                          ),
                        ],
                      ),
                      SizedBox(width: 34),
                      Container(
                        width: 52,
                        height: 13.5,
                        child: _svgIcon(
                          'assets/logo_white.svg',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 21),
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 2),
              painter: DashedLinePainter(color: greyColor8),
            ),
            SizedBox(height: 17),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: verticalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildRowWithDivider('공지사항', '최근 업데이트 공지사항을 확인해보세요'),
                  buildRowWithDivider('앱 버전', '1.4.4'),
                  buildRowWithDivider('문의하기', '궁금한 사항을 문의해주세요'),
                  Text(
                    '만든 사람들',
                    style:
                        _textStyle(14, FontWeight.w400, greyColor1, -0.28, 1.2),
                  ),
                  SizedBox(height: 19),
                  CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, 1),
                    painter: DashedLinePainter(color: greyColor8),
                  ),
                  SizedBox(height: 18),
                  buildRowWithDivider('개인정보 처리방침', '개인정보 처리방침을 확인해보세요'),
                  Text(
                    '이용약관',
                    style:
                        _textStyle(14, FontWeight.w400, greyColor1, -0.28, 1.2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
