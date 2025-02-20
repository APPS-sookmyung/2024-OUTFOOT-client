import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfoot/colors/colors.dart';
import 'package:outfoot/widgets/dashed_line_painter.dart';
import 'package:outfoot/widgets/switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingUI extends StatefulWidget {
  const SettingUI({super.key});

  @override
  State<SettingUI> createState() => _SettingUIState();
}

class _SettingUIState extends State<SettingUI> {
  static double horizontalPadding = 20.0.w;
  static double verticalPadding = 18.0.h;
  bool isNotificationEnabled = false;

  TextStyle _textStyle(double fontSize, FontWeight fontWeight, Color color,
      double letterSpacing, double height) {
    return TextStyle(
      fontSize: fontSize.sp,
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
      borderRadius: BorderRadius.circular(10.0.r),
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
        SizedBox(height: 19.h),
        CustomPaint(
          size: Size(MediaQuery.of(context).size.width, 1),
          painter: DashedLinePainter(color: greyColor8),
        ),
        SizedBox(height: 18.h),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor1, // Scaffold 전체 배경색을 설정
      appBar: AppBar(
        backgroundColor: lightMainColor,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/back_icon.svg',
            width: 17.375,
            height: 18.688,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          '설정',
          style: _textStyle(16, FontWeight.w600, greyColor1, 0.8, -0.28),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        // SingleChildScrollView로 감싸서 스크롤 가능하게
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Container(
              width: 320.w,
              height: 92.h,
              decoration: _boxDecoration(mainBrownColor2),
              child: Row(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 27.w),
                      Container(
                        width: 25.w,
                        height: 30.h,
                        child: _svgIcon(
                          'assets/bell.svg',
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '마케팅, 홍보 등 알림 수신 허용',
                            style: _textStyle(11, FontWeight.w400,
                                lightMainColor, -0.22, 0.8),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            '알림 수신 동의',
                            style: _textStyle(14, FontWeight.w600,
                                lightMainColor, -0.28, 0.8),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 50.w),
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
            SizedBox(height: 9.h),
            Container(
              width: 320.w,
              height: 60.h,
              decoration: _boxDecoration(yellowColor),
              child: Row(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 25.w),
                      Container(
                        width: 22.w,
                        height: 20.h,
                        child: _svgIcon(
                          'assets/crown.svg',
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(width: 21.w),
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
                      SizedBox(width: 34.w),
                      Container(
                        width: 52.w,
                        height: 13.5.h,
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
            SizedBox(height: 21.h),
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 2),
              painter: DashedLinePainter(color: greyColor8),
            ),
            SizedBox(height: 17.h),
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
                  SizedBox(height: 19.h),
                  CustomPaint(
                    size: Size(MediaQuery.of(context).size.width, 1),
                    painter: DashedLinePainter(color: greyColor8),
                  ),
                  SizedBox(height: 18.h),
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
