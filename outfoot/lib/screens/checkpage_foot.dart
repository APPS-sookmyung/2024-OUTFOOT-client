import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfoot/widgets/custom_floating_action_button.dart';
import 'package:outfoot/colors/colors.dart';
import 'package:outfoot/api/view_single_api.dart';
import 'package:outfoot/models/view_single_model.dart';
import 'package:outfoot/screens/navigation_bar/bottom_navigation_bar.dart';
import 'package:outfoot/screens/navigation_bar/material_top_navigation_bar.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:outfoot/utils/goal_provider.dart';
import 'package:outfoot/services/data/checkpage_data.dart';

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
  const CheckPageFoot({Key? key}) : super(key: key);

  @override
  _CheckPageFootState createState() => _CheckPageFootState();
}

final Data = CheckpageData("24.12.27", "하루에 물 2리터 마시기", "건강한 이너뷰티");

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

    token = dotenv.env['TOKEN'];
    if (token == null) {
      debugPrint("Error: TOKEN is not defined in .env");
      return;
    }

    final fetchedGoal = await api.getGoal(token!, '1');

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
                    horizontal: 16.83.w,
                    vertical: 5.7.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    Data.date,
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
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Data.title,
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
                SizedBox(height: 10),
                Text(
                  Data.intro,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                Container(
                  padding: EdgeInsets.only(
                    left: 16.95.w,
                    right: 16.95.w,
                    top: 17.35.h,
                    bottom: 35.23.h,
                  ),
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
                      if (index < 26) {
                        // 26개는 배경과 아이콘
                        return Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFDFC4B6),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(7.18.w),
                            child: SvgPicture.asset(
                              'assets/paw.svg',
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      } else {
                        // 나머지는 점선 동그라미
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
            // 플로팅 액션 버튼
            Padding(
              padding: EdgeInsets.only(right: 20.w, left: 275.w, top: 578.h),
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
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckPageImage(),
                    ),
                  );
                },
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
