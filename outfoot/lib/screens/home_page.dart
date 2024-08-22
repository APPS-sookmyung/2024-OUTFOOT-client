import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Color(0xFFDFDFDF)
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
  bool _isGroupGoalSelected = true;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFFFFEFD),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
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
                              fontSize: 16,
                              color: _isGroupGoalSelected
                                  ? Color(0xFFC09A87)
                                  : Color(0xFFA4A4A4),
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 1.1,
                              letterSpacing: -0.32,
                            ),
                          ),
                          SizedBox(height: 17),
                          _isGroupGoalSelected
                              ? Container(
                                  width: 165,
                                  height: 4,
                                  color: Color(0xFFC09A87),
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
                              fontSize: 16,
                              color: !_isGroupGoalSelected
                                  ? Color(0xFFC09A87)
                                  : Color(0xFFA4A4A4),
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 1.1,
                              letterSpacing: -0.32,
                            ),
                          ),
                          SizedBox(height: 17),
                          !_isGroupGoalSelected
                              ? Container(
                                  width: 165,
                                  height: 4,
                                  color: Color(0xFFC09A87),
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
              SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Container(
                  width: 330,
                  height: 113,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '시작일 2024-01-01',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFFA4A4A4),
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              height: 1.1,
                              letterSpacing: -0.24,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'OUTFOOT 백엔드 모각코',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF4A4A4A),
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 1.1,
                              letterSpacing: -0.32,
                            ),
                          ),
                          SizedBox(height: 12),

                          // 진행상황 바
                          Stack(
                            children: [
                              Container(
                                width: 275,
                                height: 6.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFDFDFDF),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              Container(
                                width: 203, // 78%
                                height: 6.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFC8AA9B),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '완성도 78% 완성 중',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFA4A4A4),
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400,
                                height: 1.1,
                                letterSpacing: -0.24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/lock_icon.svg',
                              width: 15,
                              height: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Container(
                  width: 330,
                  height: 113,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFFAF7F0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '시작일 2024-01-01',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFFA4A4A4),
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              height: 1.1,
                              letterSpacing: -0.24,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'OUTFOOT 백엔드 모각코',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF4A4A4A),
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 1.1,
                              letterSpacing: -0.32,
                            ),
                          ),
                          SizedBox(height: 12),

                          // 진행상황 바
                          Stack(
                            children: [
                              Container(
                                width: 275,
                                height: 6.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFDFDFDF),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              Container(
                                width: 203, // 78%
                                height: 6.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFC8AA9B),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '완성도 78% 완성 중',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFA4A4A4),
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400,
                                height: 1.1,
                                letterSpacing: -0.24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Container(
                  width: 330,
                  height: 113,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFFAF7F0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '시작일 2024-01-01',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFFA4A4A4),
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              height: 1.1,
                              letterSpacing: -0.24,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'OUTFOOT 백엔드 모각코',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF4A4A4A),
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 1.1,
                              letterSpacing: -0.32,
                            ),
                          ),
                          SizedBox(height: 12),

                          // 진행상황 바
                          Stack(
                            children: [
                              Container(
                                width: 275,
                                height: 6.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFDFDFDF),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              Container(
                                width: 203, // 78%
                                height: 6.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFC8AA9B),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '완성도 78% 완성 중',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFA4A4A4),
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400,
                                height: 1.1,
                                letterSpacing: -0.24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding (padding: EdgeInsets.only(right:20, left:275, top:100),
                             
              child: FloatingActionButton(
                onPressed: () {
                  // 플로팅 액션 버튼 동작
                },
                backgroundColor: Colors.transparent, 
                elevation: 0, 
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
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
