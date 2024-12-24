import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:outfoot/utils/goal_provider.dart';
import 'package:outfoot/services/data/checkpage_data.dart';

class CheckPageFoot extends StatefulWidget {
  final String token; // 토큰 전달
  final String checkPageId; // 개별 도장판 ID 전달

  CheckPageFoot({required this.token, required this.checkPageId});

  @override
  _CheckPageFootState createState() => _CheckPageFootState();
}

final Data = CheckpageData("24.12.26", "하루에 물 2리터 마시기", "건강한 이너뷰티");

class _CheckPageFootState extends State<CheckPageFoot> {
  String? goalTitle;
  String? goalIntro;
  String? goalImagePath;

  @override
  void initState() {
    super.initState();
    // 예제 데이터를 로드합니다. 실제 데이터는 API 호출로 대체 가능
    goalTitle = "하루에 물 2리터 마시기";
    goalIntro = "건강한 이너뷰티를 위한 도전입니다.";
    goalImagePath = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Check Page"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: goalTitle == null
            ? Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // 날짜 표시
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      Data.date,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),

                  // 목표 제목 표시
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Data.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.check_circle, color: Colors.green, size: 24),
                    ],
                  ),
                  SizedBox(height: 10),

                  // 목표 설명 표시
                  Text(
                    Data.intro,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),

                  // 이미지 표시 (예제)
                  goalImagePath == null
                      ? Text(
                          "이미지가 없습니다.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        )
                      : Image.network(
                          goalImagePath!,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                  SizedBox(height: 40),

                  // 완료 버튼
                  ElevatedButton(
                    onPressed: () {
                      if (goalTitle != null && goalIntro != null) {
                        // Provider를 통해 제목 업데이트
                        Provider.of<GoalProvider>(context, listen: false)
                            .updateGoal(goalTitle!, goalIntro!, goalImagePath);

                        // 이전 화면으로 이동
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "목표 저장하고 돌아가기",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
