import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart'; 
import 'package:flutter_svg/flutter_svg.dart';
import '/widgets/custom_floating_action_button.dart';
import 'package:outfoot/colors/colors.dart';
import 'package:outfoot/api/personal_goal_api.dart';
import 'package:outfoot/models/personal_goal_model.dart';
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

class CheckPageFoot extends StatefulWidget {
  final String token; // 토큰 전달
  final String checkPageId; // 개별 도장판 ID 전달

  CheckPageFoot({required this.token, required this.checkPageId});

  @override
  _CheckPageFootState createState() => _CheckPageFootState();
}

class _CheckPageFootState extends State<CheckPageFoot> {
  final ViewSingleApi _viewSingleApi = ViewSingleApi(dio: Dio());
  final PersonalGoalApi _personalGoalApi = PersonalGoalApi(); // PersonalGoalApi 객체 생성
  ViewGoal? goal; // 다일 도장 데이터 저장할 변수
  int? selectedAnimalId;
  int? tempSelectedAnimalId;
  bool _isSubmitting = false; 

  @override
  void initState() {
    super.initState();
    _fetchGoal();
  }

  Future<void> _fetchGoal() async {
    try {
      final fetchedGoal = await _viewSingleApi.getGoal(widget.token, widget.checkPageId);
      setState(() {
        goal = fetchedGoal; // 데이터를 저장하여 화면에서 접근 가능하게 
      });
    } catch (e) {
      print('오류: $e'); //오류처리
    }
  }
    void _showConfirmDetails(ConfirmResponse confirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('인증 ID: ${confirm.id}'),
          content: Image.network(confirm.imageUrl),
          actions: <Widget>[
            TextButton(
              child: Text('닫기'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

    // API 호출 함수 추가
  Future<void> _createPersonalGoal() async {
    if (tempSelectedAnimalId != null) {
      print('Please select an animal before completing.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an animal before completing.')),
      );
      return;
    }
    if (_isSubmitting) return; 

    setState(() {
      _isSubmitting = true;
    });

      try {
        final result = await _personalGoalApi.postGoal(
          widget.token,
          goal?.title ?? 'Default Title', // title 전달
          goal?.intro ?? 'Default Intro', // intro 전달 
          tempSelectedAnimalId!, // animalId 전달
        );
        print(result);

        setState(() {
          selectedAnimalId = tempSelectedAnimalId; // 선택한 animalId 저장
        });
        Navigator.pop(context);
      } catch (e) {
        print('Goal 생성 중 오류 발생: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create goal. Please try again.')),
        );
      } finally {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor2,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:goal == null
          ? Center(child: CircularProgressIndicator()) //데이터 로딩 
          : Stack(
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
                    goal!.createdAt,
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
                      goal!.title,     
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
                  goal!.intro,
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
                    itemCount: goal!.confirmResponses.length, // API에서 가져온 도장 개수 사용
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 10.63,
                      crossAxisSpacing: 10.75,
                    ),
                    itemBuilder: (context, index) {
                      final confirm = goal!.confirmResponses[index];
                      return GestureDetector(
                        onTap: () => _showConfirmDetails(confirm), // 도장을 클릭했을 때 상세 정보 표시
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: mainBrownColor2,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(7.18),
                            child: SvgPicture.asset(
                              'assets/paw.svg', 
                            ),
                          ),
                        ),
                      );
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
                  _createPersonalGoal(); // personal goal API 호출
                  if (tempSelectedAnimalId != null) {
                    setState(() {
                      selectedAnimalId = tempSelectedAnimalId; // 최종적으로 선택된 animalId
                    });
                    Navigator.pop(context);
                  } else {
                    print('Please select an animal before completing.');
                  }
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
                backgroundColor: Colors.transparent, // 투명 배경
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
    home: CheckPageFoot(
      token: '', // 임시 값
      checkPageId: '', // 임시 값
    ),
  ));
}
