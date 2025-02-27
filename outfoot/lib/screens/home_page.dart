import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/widgets/custom_floating_action_button.dart';
import 'package:outfoot/colors/colors.dart';
import 'package:outfoot/screens/navigation_bar/bottom_navigation_bar.dart';
import 'package:outfoot/screens/navigation_bar/top_navigation_bar.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
import 'package:outfoot/utils/goal_provider.dart';

// 이동 페이지
import 'package:outfoot/screens/make_goal/make_personal_goal.dart';
import 'package:outfoot/screens/checkpage_foot.dart';
import 'package:outfoot/screens/checkpage_foot2.dart';
import 'package:outfoot/screens/checkpage_foot3.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isDeleteMode = false;

  bool _isGroupGoalSelected = false;
  List<Map<String, dynamic>> goalList = [];

  void _toggleDeleteMode() {
    setState(() {
      _isDeleteMode = !_isDeleteMode;
    });
  }

  void _deleteGoal(String goalId) {
    final goalProvider = Provider.of<GoalProvider>(context, listen: false);

    goalProvider.deleteGoal(goalId); // ✅ 목표 삭제
    setState(() {
      goalList.removeWhere((goal) => goal["goalId"] == goalId);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('목표가 삭제되었습니다.')),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initializeGoals(); // ✅ 마이페이지 다녀와도 목표 유지
  }

  @override
  void initState() {
    super.initState();
    _initializeGoals();
  }

  void _initializeGoals() {
    final goalProvider = Provider.of<GoalProvider>(context, listen: false);
    setState(() {
      goalList = [
        {
          "goalId": const Uuid().v4(),
          "title": "OUTFOOT 모각코",
          "startDate": "2024-03-01",
          "progress": 99.0,
          "imageUrl": "assets/lock_icon.svg",
          "destination": null, // OUTFOOT 모각코는 클릭 비활성화
        },
        {
          "goalId": const Uuid().v4(),
          "title": "하루에 물 2리터 마시기",
          "startDate": "2024-12-01",
          "progress": 78.0,
          "imageUrl": "",
          "destination": CheckPageFoot2(),
        },
        {
          "goalId": const Uuid().v4(),
          "title": "아침 9시 기상하기",
          "startDate": "2024-12-27",
          "progress": 78.0,
          "imageUrl": "",
          "destination": CheckPageFoot(),
        },
      ];
      goalList.addAll(goalProvider.goalList.map((goal) {
        return {
          ...goal,
          "destination": CheckPageFoot3(
            goalId: goal["goalId"],
            goalTitle: goal["title"],
            createdAt: goal["startDate"],
            imageUrl: goal["imageUrl"] ?? "",
          ),
        };
      }).toList());
    });
  }

  void _addNewGoal(Map<String, dynamic> newGoal) {
    final goalProvider = Provider.of<GoalProvider>(context, listen: false);
    String goalId =
        newGoal["goalId"] ?? const Uuid().v4(); // ✅ goalId 없으면 자동 생성

    // ✅ GoalProvider에 목표 추가 (중복 방지)
    if (!goalProvider.goalExists(goalId)) {
      goalProvider.addGoal({
        "goalId": goalId,
        "title": newGoal["title"],
        "startDate": newGoal["startDate"],
        "progress": 0.0,
        "imageUrl": newGoal["imageUrl"] ?? "",
      });
    }

    setState(() {
      goalList.add({
        "goalId": goalId,
        "title": newGoal["title"],
        "startDate": newGoal["startDate"],
        "progress": 0.0,
        "imageUrl": newGoal["imageUrl"] ?? "",
        "destination": CheckPageFoot3(
          goalId: goalId,
          goalTitle: newGoal["title"],
          createdAt: newGoal["startDate"],
          imageUrl: newGoal["imageUrl"] ?? "",
        ),
      });
    });

    // ✅ `setState()` 실행 후 `Navigator.push()` 호출하여 UI 충돌 방지

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckPageFoot3(
          goalId: goalId,
          goalTitle: newGoal["title"],
          createdAt: newGoal["startDate"],
          imageUrl: newGoal["imageUrl"] ?? "",
        ),
      ),
    ).then((_) {
      // ✅ 뒤로 가기 눌렀을 때 다시 목표를 불러옴
      _initializeGoals();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) {
        return Scaffold(
          appBar: TopNavigationBar(
            checkPageId: 1,
            onDeleteModeToggle: _toggleDeleteMode, // 🔴 상단바 삭제 버튼과 연결
          ),
          backgroundColor: lightColor1,
          body: Consumer<GoalProvider>(
            // ✅ 목표가 자동으로 업데이트되도록 Consumer 사용
            builder: (context, goalProvider, child) {
              return SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // ✅ **탭 UI (비율 유지, 선택 시 색 변경)**
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isGroupGoalSelected = true;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  '그룹 목표',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: _isGroupGoalSelected
                                        ? blackBrownColor
                                        : greyColor4,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  width: 165.w,
                                  height: 4.h,
                                  color: _isGroupGoalSelected
                                      ? mainBrownColor
                                      : greyColor6,
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
                              children: [
                                Text(
                                  '내 목표',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: !_isGroupGoalSelected
                                        ? blackBrownColor
                                        : greyColor4,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  width: 165.w,
                                  height: 4.h,
                                  color: !_isGroupGoalSelected
                                      ? mainBrownColor
                                      : greyColor6,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),

                      // ✅ **목표 리스트 동적 생성**
                      for (var goal in goalList)
                        _buildGoalCard(
                          context,
                          goal["goalId"],
                          goal["title"],
                          goal["startDate"],
                          goal["progress"],
                          goal["destination"], // 클릭하면 이동할 페이지
                        ),

                      // ✅ **플로팅 액션 버튼 (새 목표 추가)**
                      Padding(
                        padding: EdgeInsets.only(
                            right: 20.w, left: 275.w, top: 250.h),
                        child: customFloatingActionButton(
                          'assets/floating_action.svg',
                          onPressed: () async {
                            final newGoal = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MakePersonalGoalPage(),
                              ),
                            );

                            if (newGoal != null) {
                              _addNewGoal(newGoal);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: 1),
        );
      },
    );
  }

  // ✅ **목표 카드 위젯 (목표 리스트 동적 생성)**
  Widget _buildGoalCard(BuildContext context, String goalId, String title,
      String startDate, double progressPercentage, Widget? destinationPage) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Stack(
        children: [
          GestureDetector(
            onTap: !_isDeleteMode && destinationPage != null
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => destinationPage),
                    );
                  }
                : null,
            child: Container(
              width: 330.w,
              height: 113.h,
              padding: EdgeInsets.all(16.0.sp),
              decoration: BoxDecoration(
                color: lightColor2,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "시작일 $startDate",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: greyColor4,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: blackBrownColor,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  LinearProgressIndicator(
                    value: ((progressPercentage ?? 0.0) / 100).clamp(0.0, 1.0),
                    backgroundColor: greyColor3,
                    valueColor: AlwaysStoppedAnimation(mainBrownColor),
                    minHeight: 6.h,
                  ),
                  SizedBox(height: 4.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "완성도 $progressPercentage% 완성 중",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: greyColor4,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isDeleteMode)
            Positioned(
              top: 4,
              right: 4,
              child: IconButton(
                icon: Icon(Icons.remove_circle, color: Colors.red, size: 24),
                onPressed: () => _deleteGoal(goalId),
              ),
            ),
        ],
      ),
    );
  }
}
