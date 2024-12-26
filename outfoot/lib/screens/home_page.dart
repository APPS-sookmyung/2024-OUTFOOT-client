import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:outfoot/services/data/homepage_data.dart';
import '/widgets/custom_floating_action_button.dart';
import '/widgets/target_view.dart';
import 'package:outfoot/colors/colors.dart';
import 'package:outfoot/screens/navigation_bar/bottom_navigation_bar.dart';
import 'package:outfoot/screens/navigation_bar/top_navigation_bar.dart';
// import 'package:outfoot/services/data/homepage_data.dart';

// 이동 페이지 import
import 'package:outfoot/screens/make_goal/make_personal_goal.dart';
import 'package:outfoot/screens/checkpage_foot.dart';

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = greyColor9
      ..strokeWidth = 0.7
      ..style = PaintingStyle.stroke;

    var dashWidth = 5.0;
    var dashSpace = 3.0;
    var startX = 0.0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isGroupGoalSelected = false;

  @override
  Widget build(BuildContext context) {
    // ScreenUtil 초기화 후 화면 크기 비례를 위한 변수 설정
    double screenWidth = MediaQuery.of(context).size.width;

    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) {
        return Scaffold(
          appBar: TopNavigationBar(checkPageId: 1), // 예시로 ID 1 전달
          backgroundColor: lightColor1,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isGroupGoalSelected = true;
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '그룹 목표',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: _isGroupGoalSelected
                                      ? milkBrownColor1
                                      : greyColor4,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                  height: 1.1,
                                  letterSpacing: -0.32,
                                ),
                              ),
                              SizedBox(height: 17.h),
                              _isGroupGoalSelected
                                  ? Container(
                                      width: 165.w,
                                      height: 4.h,
                                      color: milkBrownColor1,
                                    )
                                  : CustomPaint(
                                      painter: DashedLinePainter(),
                                      size: Size(screenWidth * 0.4, 0),
                                    ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isGroupGoalSelected = false;
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '내 목표',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: !_isGroupGoalSelected
                                      ? milkBrownColor1
                                      : greyColor4,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                  height: 1.1,
                                  letterSpacing: -0.32,
                                ),
                              ),
                              SizedBox(height: 17.h),
                              !_isGroupGoalSelected
                                  ? Container(
                                      width: 165.w,
                                      height: 4.h,
                                      color: milkBrownColor1,
                                    )
                                  : CustomPaint(
                                      painter: DashedLinePainter(),
                                      size: Size(screenWidth * 0.4, 0),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // 첫 번째 카드 (완성도 99%)
                  Padding(
                    padding: EdgeInsets.only(left: 20.w),
                    child: Container(
                      width: 330.w,
                      height: 113.h,
                      padding: EdgeInsets.all(16.0.w),
                      decoration: BoxDecoration(
                        color: lightColor,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: ProgressCard(
                        startDate: '2024-03-01',
                        title: 'OUTFOOT 모각코',
                        progressPercentage: 99, // 완성도 99% 수정
                        assetPath: 'assets/lock_icon.svg',
                      ),
                    ),
                  ),
                   SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.only(left: 20.sp),
                    child: GestureDetector( // 클릭 이벤트 추가
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckPageFoot(), // 이동할 페이지
                          ),
                        );
                      },
                      child: Container(
                        width: 330.w,
                        height: 113.h,
                        padding: EdgeInsets.all(16.0.sp),
                        decoration: BoxDecoration(
                          color: lightColor2,
                          borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: ProgressCard(
                            startDate: '2024-12-01',
                            title: '하루에 물 2리터 마시기기 ',
                            progressPercentage: 78,
                            assetPath: '',
                            ),
                          ),
                        ),
                      ),
                       SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.only(left: 20.sp),
                    child: GestureDetector( // 클릭 이벤트 추가
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckPageFoot(), // 이동할 페이지
                          ),
                        );
                      },
                      child: Container(
                        width: 330.w,
                        height: 113.h,
                        padding: EdgeInsets.all(16.0.sp),
                        decoration: BoxDecoration(
                          color: lightColor2,
                          borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: ProgressCard(
                            startDate: '2024-12-27',
                            title: '아침 9시 기상하기',
                            progressPercentage: 78,
                            assetPath: '',
                            ),
                          ),
                        ),
                      ),
                      


                  // 플로팅 액션 버튼
                  Padding(
                    padding:
                        EdgeInsets.only(right: 20.w, left: 275.w, top: 250.h),
                    child: customFloatingActionButton(
                      'assets/floating_action.svg',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MakePersonalGoalPage(), // 이동할 페이지
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: 1),
        );
      },
    );
  }
}
