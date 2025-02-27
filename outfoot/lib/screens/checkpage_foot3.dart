import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/widgets/custom_floating_action_button.dart';
import 'package:outfoot/colors/colors.dart';
import 'package:outfoot/screens/navigation_bar/bottom_navigation_bar.dart';
import 'package:outfoot/screens/navigation_bar/material_top_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:outfoot/utils/goal_provider.dart'; // ✅ GoalProvider 가져오기

// 이동 페이지
import 'package:outfoot/screens/upload.dart';
import 'package:outfoot/screens/checkpage_image3.dart';

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

// ✅ **새로운 목표 정보를 동적으로 반영할 수 있도록 수정**
class CheckPageFoot3 extends StatefulWidget {
  final String goalId;
  final String goalTitle; // 목표 제목
  final String createdAt; // 목표 생성일
  final String imageUrl;

  const CheckPageFoot3({
    super.key,
    required this.goalId,
    required this.goalTitle,
    required this.createdAt,
    required this.imageUrl,
  });

  @override
  _CheckPageFoot3State createState() => _CheckPageFoot3State();
}

class _CheckPageFoot3State extends State<CheckPageFoot3> {
  @override
  void initState() {
    super.initState();

    // ✅ `goalId`별로 이미지 저장
    Future.microtask(() {
      final goalProvider = Provider.of<GoalProvider>(context, listen: false);
      goalProvider.addGoal({
        "goalId": widget.goalId,
        "title": widget.goalTitle,
        "startDate": widget.createdAt,
        "progress": 0.0, // ✅ 기본값 설정
        "imageUrl": "", // ✅ 기본값 추가
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final goalProvider = Provider.of<GoalProvider>(context);
    List<String> goalImages = goalProvider.getGoalImages(widget.goalId);

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

                // ✅ **날짜 표시 (입력받은 날짜 그대로 반영)**
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.83.w, vertical: 5.7.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    widget.createdAt, // 입력받은 날짜 반영
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

                // ✅ **목표 제목 (입력받은 제목 그대로 반영)**
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.goalTitle, // 입력받은 제목 반영
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

                // // ✅ **목표 소개**
                // Text(
                //   widget.goalIntro,
                //   style: TextStyle(
                //     fontSize: 12.sp,
                //     color: greyColor3,
                //     fontFamily: 'Pretendard',
                //     fontWeight: FontWeight.w400,
                //     height: 1.1,
                //     letterSpacing: -0.24,
                //   ),
                // ),
                SizedBox(height: 22.42.h),

                // ✅ 도장판 (Paw 아이콘 추가)

                // ✅ **도장판 (Paw 아이콘 추가)**
                Container(
                  padding: EdgeInsets.all(10.0.w),
                  decoration: BoxDecoration(
                    color: Colors.white, // ✅ 배경색 추가
                    borderRadius: BorderRadius.circular(10.r), // ✅ 둥근 모서리
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Consumer<GoalProvider>(
                    builder: (context, goalProvider, child) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 30, // 최대 30개의 도장을 표시
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          mainAxisSpacing: 10.63.h,
                          crossAxisSpacing: 10.75.w,
                        ),
                        itemBuilder: (context, index) {
                          return goalImages.length > index
                              ? Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: mainBrownColor2, // ✅ Paw 배경 추가
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(6.0.w), // ✅ 패딩 조정
                                    child: SvgPicture.asset(
                                      'assets/paw.svg', // ✅ 업로드된 개수만큼 paw.svg 추가
                                      fit: BoxFit.contain,
                                      width: 24.w,
                                      height: 24.w,
                                    ),
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: mainBrownColor),
                                  ),
                                  width: 24.57.w,
                                  height: 24.57.w,
                                );
                        },
                      );
                    },
                  ),
                ),
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
                      builder: (context) => Upload(goalId: widget.goalId),
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckPageImage3(
                          goalId: widget.goalId,
                          goalTitle: widget.goalTitle,
                          createdAt: widget.createdAt,
                          imageUrl: widget.imageUrl // ✅ imageUrl 전달
                          ),
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
