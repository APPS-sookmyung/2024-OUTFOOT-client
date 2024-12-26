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
import 'package:outfoot/services/data/checkpage_data.dart';

// 이동 페이지
import 'package:outfoot/screens/upload.dart';
import 'package:outfoot/screens/checkpage_foot.dart';

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

final Data = CheckpageData("24.12.27", "하루에 물 2리터 마시기", "건강한 이너뷰티");

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

class CheckPageImage extends StatefulWidget {
  const CheckPageImage({Key? key}) : super(key: key);

  @override
  _CheckPageImageState createState() => _CheckPageImageState();
}

class _CheckPageImageState extends State<CheckPageImage> {
  ViewGoal? goal; // API에서 불러온 데이터를 저장할 변수

  @override
  void initState() {
    super.initState();
    _fetchGoal(); // 초기화 시 API 호출
  }

  Future<void> _fetchGoal() async {
    const String defaultToken = 'default_token';
    const String defaultCheckPageId = '1';

    final api = ViewSingleApi(dio: Dio());
    try {
      final fetchedGoal = await api.getGoal(defaultToken, defaultCheckPageId);
      setState(() {
        goal = fetchedGoal; // 불러온 데이터를 상태에 저장
      });
    } catch (e) {
      debugPrint("Error fetching goal data: $e");
    }
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
                SizedBox(height: 18.76.h),
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
                SizedBox(height: 10.63.h),
                Text(
                  Data.intro,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: greyColor3,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                    height: 1.1,
                    letterSpacing: -0.24,
                  ),
                ),
                SizedBox(height: 40), // 이미지 그리드 상단 여백
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
                    itemCount: 30, // 총 30개로 변경
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 10.63.h,
                      crossAxisSpacing: 10.75.w,
                    ),
                    itemBuilder: (context, index) {
                      if (index < 26) {
                        // 이미지가 있는 경우
                        return Container(
                          child: ClipOval(
                            // 자식 위젯(SvgPicture)을 원형으로 클리핑합니다.
                            child: Padding(
                              padding: EdgeInsets.all(0.w),
                              child: SvgPicture.asset(
                                'assets/data/${index + 1}.svg', // 이미지 경로
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      } else {
                        // 나머지 빈칸은 점선 원으로 표시
                        return DashedCircle(
                          size: 24.57.w,
                          color: mainBrownColor,
                        );
                      }
                    
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
          builder: (context) => CheckPageFoot(),
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
          ],
        ),
      ),
      
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: 1),
    );
  }
}
