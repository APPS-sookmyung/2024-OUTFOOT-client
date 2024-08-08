import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_drawing/path_drawing.dart'; // path_drawing 패키지 임포트
import 'package:flutter_svg/flutter_svg.dart';

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

    // path_drawing 패키지를 사용하여 점선 스타일 추가
    final Path dashedPath = dashPath(
      path,
      dashArray: CircularIntervalList<double>(<double>[dashLength, spaceLength]),
    );

    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CheckPageFoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDFAFF),
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
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '24.03.31', // 날짜
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF13A9EA),
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
                      '하루에 물 2리터 마시기',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF13A9EA),
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
                          color: Color(0xFFC8EF2F),
                          shape: BoxShape.circle, // 동그라미 모양
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.63),
                Text(
                  '건강한 이너뷰티',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF8B8B8B),
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
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: 30, // 총 30개의 도장
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 10.63,
                      crossAxisSpacing: 10.75,
                    ),
                    itemBuilder: (context, index) {
                      if (index < 11) { // 임의로 11개 채워진 도장
                        return Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF79D7FF),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(7.18),
                            child: SvgPicture.asset(
                              'assets/paw.svg', // 발바닥 이미지 
                            ),
                          ),
                        );
                      } else {
                        return DashedCircle(
                          size: 24.57, 
                          color: Color(0xFF79D7FF), 
                        );
                      }
                    },
                  ),
                ),
                Spacer(),
              ],
            ),
            Positioned(
              top: 163, 
              left: 315, 
              right: 27.2, 
              bottom: 300, // 아래쪽 간격 오류
              child: FloatingActionButton(
                onPressed: () {
                  // 셔플 버튼 동작
                },
                backgroundColor: Colors.transparent, // 배경색 투명
                elevation: 0, // 그림자 제거
                child: SvgPicture.asset(
                  'assets/shuffle_icon.svg',
                  width: 24,
                  height: 24,
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              right: 20, // 재배치 필요
              child: FloatingActionButton(
                onPressed: () {
                  // 플로팅 액션 버튼 동작
                },
                backgroundColor: Colors.transparent, // 배경색 투명
                elevation: 0, // 그림자 제거
                child: SvgPicture.asset(
                  'assets/floating_action.svg',
                  width:  65.035,
                  height:  65.035,
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
    home: CheckPageFoot(),
  ));
}
