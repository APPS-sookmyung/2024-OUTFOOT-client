import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart'; 
import 'package:flutter_svg/flutter_svg.dart';
import '/widgets/custom_floating_action_button.dart';
import 'package:outfoot/colors/colors.dart';
import 'package:outfoot/api/view_single_api.dart';
import 'package:outfoot/models/view_single_model.dart';

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
      ..addOval(Rect.fromCircle(center: Offset(radius, radius), radius: radius));

    final Path dashedPath = dashPath(
      path,
      dashArray: CircularIntervalList<double>(<double>[dashLength, spaceLength]),
    );

    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
class CheckPageImage extends StatefulWidget {
  final String token; // API 인증 토큰
  final String checkPageId; // 조회할 체크 페이지 ID

  CheckPageImage({required this.token, required this.checkPageId});

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
    final api = ViewSingleApi(dio: Dio());
    final fetchedGoal = await api.getGoal(widget.token, widget.checkPageId);

    setState(() {
      goal = fetchedGoal; // 불러온 데이터를 상태에 저장
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor2,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.83, vertical: 5.7),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    goal?.createdAt ?? '날짜 정보 없음',  
                    style: TextStyle(
                      fontSize: 11,
                      color: blackBrownColor,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      height: 1.1,
                      letterSpacing: -0.22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 18.76),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      goal?.title ?? '제목 없음', // 불러온 데이터의 제목 표시
                      style: TextStyle(
                        fontSize: 18,
                        color: blackBrownColor,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        height: 1.1,
                        letterSpacing: -0.36,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(width: 3.69),
                    Transform.translate(
                      offset: Offset(0, -9.0),
                      child: Container(
                        width: 7.991,
                        height: 7.991,
                        decoration: BoxDecoration(
                          color: yellowColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.63),
                Text(
                  goal?.intro ?? '설명 없음', // 불러온 데이터의 설명 표시
                  style: TextStyle(
                    fontSize: 12,
                    color: greyColor3,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                    height: 1.1,
                    letterSpacing: -0.24,
                  ),
                ),
                SizedBox(height: 22.42),
                Container(
                  padding: EdgeInsets.only(left: 16.95, right: 16.95, top: 17.35, bottom: 35.23),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: 30, 
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 10.63,
                      crossAxisSpacing: 10.75,
                    ),
                    itemBuilder: (context, index) {
                      if (goal != null && index < goal!.confirmResponses.length) {
                        // 이미지 URL을 불러온 데이터의 confirmResponses에서 가져오기
                        return Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: mainBrownColor2,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(7.18),
                            child: Image.network(
                              goal!.confirmResponses[index].imageUrl, // 동적으로 이미지 URL 표시                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      } else {
                        return DashedCircle(
                          size: 24.57, 
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
              bottom: 12,
              right: 20, 
              child: customFloatingActionButton(
              'assets/floating_action.svg',  
              onPressed: () {
                  // 플로팅 액션 버튼 동작
                },
            ),
            ),
            Positioned(
              top: 60, 
              left: 330, 
              child: FloatingActionButton(
                onPressed: () {
                  // 셔플 버튼 동작
                },
                backgroundColor: Colors.transparent, 
                elevation: 0,
                child: SvgPicture.asset(
                  'assets/shuffle_icon.svg',
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CheckPageImage(
      token: '', checkPageId: ''
    ),
  ));
}
