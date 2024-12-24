import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfoot/services/data/homepage_data.dart';
import '/widgets/custom_floating_action_button.dart';
import '/widgets/target_view.dart';
import 'package:outfoot/colors/colors.dart';
import 'package:outfoot/services/data/homepage_data.dart';

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

final List<HomepageData> dataList = [
  HomepageData("2024-01-01", "OUTFOOT FE 모각코"),
  HomepageData("2024-01-01", "OUTFOOT BE 모각코"),
  HomepageData("2024-01-01", "OUTFOOT 배포"),
];


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
      backgroundColor: lightColor1,
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
                                  ? milkBrownColor1
                                  : greyColor4,
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
                              fontSize: 16,
                              color: !_isGroupGoalSelected
                                  ? milkBrownColor1
                                  : greyColor4,
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
              SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Container(
                  width: 330,
                  height: 113,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: lightColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ProgressCard(
                    startDate: dataList[0].date,
                    title: dataList[0].title,
                    progressPercentage: 78,
                    assetPath: 'assets/lock_icon.svg',
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
                    color: lightColor2,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ProgressCard(
                    startDate: dataList[1].date,
                    title: dataList[1].title,
                    progressPercentage: 78,
                    assetPath: '',
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
                    color: lightColor2,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ProgressCard(
                    startDate: dataList[2].title,
                    title: dataList[2].title,
                    progressPercentage: 78,
                    assetPath: '',
                  ),
                ),
              ),
              Padding (padding: EdgeInsets.only(right:20, left:275, top:100),
                             
              child: customFloatingActionButton(
              'assets/floating_action.svg',  
              onPressed: () {
                  // 플로팅 액션 버튼 동작
                },
            ),
            ),
            ],
          ),
        ),
      ),
    );
  }
}

