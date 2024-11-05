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
  @override
  _CheckPageFootState createState() => _CheckPageFootState();
}

class _CheckPageFootState extends State<CheckPageFoot> {
  final PersonalGoalApi _goalApi = PersonalGoalApi();
  late TextEditingController _goalNameController = TextEditingController();
  late TextEditingController _goalDescriptionController = TextEditingController();

  int? selectedAnimalId;
  int? tempSelectedAnimalId;
  List<Goal> goals = []; // 도장 정보를 저장

    @override
    void initState() {
    super.initState();
    // 컨트롤러 초기화
    _goalNameController = TextEditingController();
    _goalDescriptionController = TextEditingController();
    _fetchGoals(); // 도장 정보를 가져오는 함수 호출
  }

Future<void> _fetchGoals() async {
    try {
      final fetchedGoals = await _viewSingleApi.getGoal();
      setState(() {
        goals = fetchedGoals; // 가져온 도장 정보를 goals 리스트에 저장
      });
    } catch (e) {
      print('Failed to fetch goals: $e'); // 오류 처리
    }
  }

  @override
  void dispose() {
    // 컨트롤러 해제
    _goalNameController.dispose();
    _goalDescriptionController.dispose();
    super.dispose();
  } 

  void _postGoal() async {
    if (selectedAnimalId == null) {
      print('Please select an animal before submitting.');
      return;
    }

    final token = ''; // 토큰 발급받아 넣는 곳

    final response = await _goalApi.postGoal(
      token,
      _goalNameController.text,
      _goalDescriptionController.text,
      selectedAnimalId!,
    );
    print(response);
  }

  // 도장 클릭 시 자세한 정보 조회
  void _showGoalDetails(Goal goal) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(goal.title),
          content: Text('내용: ${goal.intro}'), 
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
                    '24.03.31', 
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
                      '하루에 물 2리터 마시기',
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
                  '건강한 이너뷰티',
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
                    itemCount: goals.length, // API에서 가져온 도장 개수 사용
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 10.63,
                      crossAxisSpacing: 10.75,
                    ),
                    itemBuilder: (context, index) {
                      final goal = goals[index];
                      return GestureDetector(
                        onTap: () => _showGoalDetails(goal), // 도장을 클릭했을 때 상세 정보 표시
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
    home: CheckPageFoot(),
  ));
}
