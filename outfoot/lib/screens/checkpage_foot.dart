import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/widgets/custom_floating_action_button.dart';
import 'package:outfoot/colors/colors.dart';
import 'package:outfoot/screens/navigation_bar/bottom_navigation_bar.dart';
import 'package:outfoot/screens/navigation_bar/material_top_navigation_bar.dart';

// 이동 페이지
import 'package:outfoot/screens/upload.dart';
import 'package:outfoot/screens/checkpage_image.dart';

class DashedCircle extends StatelessWidget {
  final double size;
  final Color color;
  final double dashLength;
  final double spaceLength;

  const DashedCircle({
    required this.size,
    required this.color,
    this.dashLength = 6.0,
    this.spaceLength = 6.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: DashedCirclePainter(color, dashLength, spaceLength),
    );
  }
}

class DashedCirclePainter extends CustomPainter {
  final Color color;
  final double dashLength;
  final double spaceLength;

  DashedCirclePainter(this.color, this.dashLength, this.spaceLength);

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final Path path = Path()
      ..addOval(
          Rect.fromCircle(center: Offset(radius, radius), radius: radius));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CheckPageFoot extends StatefulWidget {
  const CheckPageFoot({super.key});

  @override
  _CheckPageFootState createState() => _CheckPageFootState();
}

class _CheckPageFootState extends State<CheckPageFoot> {
  final String createdAt = "2024-12-27";
  final String goalTitle = "아침 9시 기상하기";
  final String goalIntro = "";
  final List<String> goalImages = [
    "assets/paw.svg",
    "assets/paw.svg",
    "assets/paw.svg",
    "assets/paw.svg",
    "assets/paw.svg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MeterialTopNavigationBar(
        checkPageId: 1,
        backgroundColor: lightColor2,
      ),
      backgroundColor: lightColor2,
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10.h),

                // ✅ **날짜 표시**
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.83.w, vertical: 5.7.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    createdAt,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: blackBrownColor,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      height: 1.1,
                      letterSpacing: -0.22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 18.76.h),

                // ✅ **목표 제목**
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      goalTitle,
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: blackBrownColor,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        height: 1.1,
                        letterSpacing: -0.36,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 3.69.w),
                    Transform.translate(
                      offset: Offset(0, -9.0.h),
                      child: Container(
                        width: 7.991.w,
                        height: 7.991.h,
                        decoration: BoxDecoration(
                          color: yellowColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.63.h),

                // ✅ **목표 소개**
                Text(
                  goalIntro,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: greyColor3,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                    height: 1.1,
                    letterSpacing: -0.24,
                  ),
                ),
                SizedBox(height: 22.42.h),

                // ✅ **목표 이미지 표시**
                Container(
                  padding: EdgeInsets.all(16.0.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 30,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 10.63.h,
                      crossAxisSpacing: 10.75.w,
                    ),
                    itemBuilder: (context, index) {
                      if (index < goalImages.length) {
                        return Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: mainBrownColor2,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(6.0.w), // ✅ **패딩 조정**
                            child: SvgPicture.asset(
                              goalImages[index],
                              fit: BoxFit.contain,
                              width: 24.w,
                              height: 24.w,
                            ),
                          ),
                        );
                      } else {
                        return DashedCircle(
                          size: 24.57.w,
                          color: mainBrownColor,
                        );
                      }
                    },
                  ),
                ),
                Spacer(),
              ],
            ),

            // ✅ **업로드 버튼**
            Positioned(
              bottom: 12.h,
              right: 20.w,
              child: customFloatingActionButton(
                'assets/floating_action.svg',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Upload(goalId: "default_goal"),
                    ),
                  );
                },
              ),
            ),

            // ✅ **체크 페이지 이미지 버튼**
            Positioned(
              top: 60.h,
              left: 300.w,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckPageImage(),
                    ),
                  );
                },
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: SvgPicture.asset(
                  'assets/shuffle_icon.svg',
                  width: 24.w,
                  height: 24.h,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: 1),
    );
  }
}
