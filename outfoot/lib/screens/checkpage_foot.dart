import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/widgets/custom_floating_action_button.dart';
import 'package:outfoot/colors/colors.dart';
import 'package:outfoot/api/view_single_api.dart';
import 'package:outfoot/models/view_single_model.dart';
import 'package:outfoot/screens/navigation_bar/bottom_navigation_bar.dart';
import 'package:outfoot/screens/navigation_bar/material_top_navigation_bar.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// 이동 페이지
import 'package:outfoot/screens/upload.dart';
import 'package:outfoot/screens/checkpage_image.dart';

class DashedCircle extends StatelessWidget {
  final double size;
  final Color color;
  final double dashLength;
  final double spaceLength;

  DashedCircle({
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

    final Path dashedPath = dashPath(
      path,
      dashArray:
          CircularIntervalList<double>(<double>[dashLength, spaceLength]),
    );

    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CheckPageFoot extends StatefulWidget {
  final String token; // API 인증 토큰
  final String checkPageId; // 조회할 체크 페이지 ID
  final String goalImagePath;

  CheckPageFoot({
    required this.token,
    required this.checkPageId,
    this.goalImagePath = 'default_image_path',
  });

  @override
  _CheckPageFootState createState() => _CheckPageFootState();
}

class _CheckPageFootState extends State<CheckPageFoot> {
  ViewGoal? goal; // API에서 불러온 데이터를 저장할 변수
  String? token;

  @override
  void initState() {
    super.initState();
    _fetchGoal(); // 초기화 시 API 호출
  }

  Future<void> _fetchGoal() async {
    final api = ViewSingleApi(dio: Dio());
    final fetchedGoal = await api.getGoal(widget.token, widget.checkPageId);

    token = dotenv.env['TOKEN'];
    if (token == null) {
      debugPrint("Error: TOKEN is not defined in .env");
      return;
    }

    setState(() {
      goal = fetchedGoal; // 불러온 데이터를 상태에 저장
    });
  }

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
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.83.w, vertical: 5.7.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    goal?.createdAt ?? '날짜 정보 없음',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      goal?.title ?? '제목 없음', // 불러온 데이터의 제목 표시
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
                Text(
                  goal?.intro ?? '설명 없음', // 불러온 데이터의 설명 표시
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
                Container(
                  padding: EdgeInsets.only(
                      left: 16.95.w,
                      right: 16.95.w,
                      top: 17.35.h,
                      bottom: 35.23.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: 30,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 10.63.h,
                      crossAxisSpacing: 10.75.w,
                    ),
                    itemBuilder: (context, index) {
                      if (goal != null &&
                          index < goal!.confirmResponses.length) {
                        // 이미지 URL을 불러온 데이터의 confirmResponses에서 가져오기
                        return Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: mainBrownColor2,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(7.18.w),
                            child: Image.network(
                              goal!.confirmResponses[index]
                                  .imageUrl, // 동적으로 이미지 URL 표시                              fit: BoxFit.contain,
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
            Positioned(
              bottom: 12.h,
              right: 20.w,
              child: customFloatingActionButton(
                'assets/floating_action.svg',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Upload(), // 이동할 페이지
                    ),
                  );
                },
              ),
            ),
            Positioned(
              top: 60.h,
              left: 300.w,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckPageImage(
                        token: token!,
                        checkPageId: '1',
                      ), // 이동할 페이지
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
