import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfoot/colors/colors.dart';
import '../widgets/target_view.dart';
import 'package:outfoot/widgets/dashed_path_painter.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 319.0,
                decoration: BoxDecoration(
                  color: lightColor2,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: CustomPaint(
                  size: Size(MediaQuery.of(context).size.width, 28),
                  painter: DashedPathPainter(),
                ),
              ),
              Positioned(
                top: 65.0,
                right: 20.0,
                child: Row(
                  children: [
                    _svgIcon('assets/icon/edit.svg', width: 8.0, height: 26.0),
                    SizedBox(width: 17.0),
                    _svgIcon('assets/icon/setting.svg',
                        width: 22.0, height: 23.0),
                    SizedBox(width: 20.0),
                  ],
                ),
              ),
              Positioned(
                top: 103.0,
                left: 30.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 84.0,
                          height: 84.0,
                          decoration: BoxDecoration(
                            color: mainBrownColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Positioned(
                          left: 60.0,
                          top: 60.0,
                          child: Container(
                            width: 36.0,
                            height: 36.0,
                            decoration: BoxDecoration(
                              color: yellowColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: _svgIcon('assets/icon/edit.svg',
                                  width: 20.0, height: 26.0),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0.0,
                          child: Container(
                            width: 84.0,
                            height: 84.0,
                            alignment: Alignment.center,
                            child: Text(
                              '문',
                              style: _textStyle(26.0, FontWeight.w600,
                                  lightMainColor, 0.52, 0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 25.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '좋은 아침이에요,',
                          style: _textStyle(
                              20.0, FontWeight.w500, blackBrownColor, 0.4, 0.8),
                        ),
                        SizedBox(height: 9.0),
                        Row(
                          children: [
                            Text(
                              '문서영',
                              style: _textStyle(20.0, FontWeight.w700,
                                  blackBrownColor, 0.4, 0.8),
                            ),
                            Text(
                              ' 님!',
                              style: _textStyle(20.0, FontWeight.w500,
                                  blackBrownColor, 0.4, 0.8),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.0),
                        Text(
                          '안녕하세요 반가워요 최대 20자',
                          style: _textStyle(
                              14.0, FontWeight.w400, greyColor1, 1.2, 0.28),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 216.0,
                left: MediaQuery.of(context).size.width / 2 - 160,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 93.0,
                      height: 65.0,
                      decoration: _boxDecoration(mainBrownColor2),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '친구 수',
                              style: _textStyle(
                                  12.0, FontWeight.w400, greyColor1, 0.24, 0.8),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              '28',
                              style: _textStyle(
                                  16.0, FontWeight.w500, greyColor1, 0.32, 0.8),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 14.0),
                    Container(
                      width: 211.0,
                      height: 65.0,
                      decoration: _boxDecoration(milkBrownColor1),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 20.0),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '코드를 통해',
                                  style: _textStyle(12.0, FontWeight.w400,
                                      lightMainColor, 0.24, 0.8),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  '친구 추가하기',
                                  style: _textStyle(14.0, FontWeight.w500,
                                      lightMainColor, 0.28, 0.8),
                                ),
                              ],
                            ),
                            Spacer(),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 23.0),
                                child: _svgIcon('assets/people_icon.svg',
                                    width: 56.0, height: 48.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 13.0,
                left: MediaQuery.of(context).size.width / 2 - 24.5,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 49.0,
                    height: 5.0,
                    decoration: _boxDecoration(mainBrownColor2),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            color: lightColor1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30, top: 20.0),
                  child: Text(
                    '목록',
                    style: _textStyle(
                        14.0, FontWeight.w400, greyColor1, 1.2, 0.28),
                  ),
                ),
                Center(
// ProgressCard를 가로 센터로 정렬
                  child: Padding(
                    padding: EdgeInsets.only(left: 0, top: 8.0),
                    child: Container(
                      width: 330,
                      height: 113,
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: lightColor2,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ProgressCard(
                        startDate: '2024-01-01',
                        title: 'OUTFOOT 백엔드 모각코',
                        progressPercentage: 78,
                        assetPath: '',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
