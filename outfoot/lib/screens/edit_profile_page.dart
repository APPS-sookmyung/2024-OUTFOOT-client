import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:outfoot/colors/colors.dart';
import 'package:outfoot/services/data/editprofile_data.dart';
import 'package:outfoot/widgets/dashed_line_painter.dart';

class EditProfile extends StatelessWidget {
  EditProfile({super.key});

  TextStyle _textStyle(double fontSize, FontWeight fontWeight, Color color,
      double letterSpacing) {
    return TextStyle(
      fontSize: fontSize.sp, // Use .sp for scaling font size
      fontFamily: 'Pretendard',
      fontStyle: FontStyle.normal,
      fontWeight: fontWeight,
      color: color,
      height: 0.8,
      letterSpacing: letterSpacing.sp, // Scale letter spacing too
    );
  }

  BoxDecoration _boxDecoration(Color color, [List<BoxShadow>? boxShadow]) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10.0.r), // Use .r for radius scaling
      color: color,
      boxShadow: boxShadow,
    );
  }

  final Data = EditprofileData("정지원", "안녕하세요 만나서 반가워요", "outfootfe@sookmyung.ac.kr");

  Widget _svgIcon(String assetName,
      {double? width, double? height, BoxFit fit = BoxFit.none}) {
    return SvgPicture.asset(
      assetName,
      width: width?.w, // Use .w for scaling width
      height: height?.h, // Use .h for scaling height
      fit: fit,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainBrownColor2.withOpacity(0.5),
        elevation: 0,
        leading: IconButton(
          icon: _svgIcon('assets/back_icon.svg',
              width: 17.375.w, height: 18.688.h),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          '프로필 수정',
          style: _textStyle(16, FontWeight.w600, greyColor1, -0.28),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 312.h, // Scale height
                color: mainBrownColor2.withOpacity(0.5),
              ),
            ],
          ),
          Positioned(
            top: 64.h, // Scale position
            left: (MediaQuery.of(context).size.width - 98.w) / 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 98.w, // Scale width
                  height: 98.w, // Scale height
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: mainBrownColor,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        (Data.name)[0],
                        style: _textStyle(
                            24.0, FontWeight.bold, Colors.white, 0.0),
                      ),
                      Positioned(
                        bottom: 0.h,
                        left: (98.w - 69.w) / 2,
                        child: Container(
                          width: 69.w,
                          height: 30.h,
                          decoration: _boxDecoration(yellowColor),
                        ),
                      ),
                      Positioned(
                        top: 78.h,
                        child: Text(
                          '사진 수정',
                          style: _textStyle(
                              12, FontWeight.w400, greyColor1, -0.24),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Positioned(
                      top: 78.h,
                      left: 159.w,
                      child: Text(
                        Data.name,
                        style: _textStyle(
                            16.0, FontWeight.w500, greyColor1, -0.32),
                      ),
                    ),
                    Positioned(
                      top: 78.h,
                      left: 164.17.w,
                      child: Transform.rotate(
                        angle: (3.14159 / 180),
                        child: Container(
                          width: 15.w,
                          height: 15.h,
                          child: SvgPicture.asset(
                            'assets/icon/edit.svg',
                            color: mainBrownColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 219.h,
            left: (MediaQuery.of(context).size.width - 320.w) / 2,
            child: Container(
              width: 320.w,
              height: 72.h,
              decoration: _boxDecoration(lightMainColor),
            ),
          ),
          Positioned(
            top: 230.h,
            right: 135.w,
            child: Text(
              '안녕하세요 만나서 반가워요',
              style: _textStyle(11, FontWeight.w600, mainBrownColor, -0.22),  selectionColor: Colors.black,
            ),
          ),
          Positioned(
            top: 310.5.h,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 2.h),
              painter: DashedLinePainter(color: mainBrownColor2),
            ),
          ),
          Positioned(
            top: 341.h,
            left: 20.5.w,
            right: 20.5.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '이메일 주소',
                  style: _textStyle(12.0, FontWeight.w400, greyColor2, 0.24),
                ),
                SizedBox(height: 8.h),
                Container(
  width: double.infinity,
  height: 46.h,
  decoration: _boxDecoration(lightColor2),
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      decoration: InputDecoration(
        hintText: 'appsoutfoot@sookmyung.ac.kr',
        border: InputBorder.none,
      ),
    ),
  ),
),

                SizedBox(height: 16.h),
                Text(
                  '비밀번호 변경',
                  style: _textStyle(12.0, FontWeight.w400, greyColor2, 0.24),
                ),
                SizedBox(height: 8.h),
                Container(
                  width: double.infinity,
                  height: 46.h,
                  decoration: _boxDecoration(lightColor2),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  '비밀번호 확인',
                  style: _textStyle(12.0, FontWeight.w400, greyColor2, 0.24),
                ),
                SizedBox(height: 8.h),
                Container(
                  width: double.infinity,
                  height: 46.h,
                  decoration: _boxDecoration(lightColor2),
                  child: Padding(
                    padding: EdgeInsets.all(20.0.w),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 38.h),
                Container(
                  width: 320.w,
                  height: 45.994.h,
                  decoration: _boxDecoration(mainBrownColor),
                  child: InkWell(
                    onTap: () {
                      // 페이지 이동 로직: 이전 화면으로 돌아가기
                      Navigator.pop(context);
                    },
                    child: Center(
                      child: Text(
                        '변경하기',
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
        ],
      ),
    );
  }
}
