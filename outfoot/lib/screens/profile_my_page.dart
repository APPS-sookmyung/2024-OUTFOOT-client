import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outfoot/colors/colors.dart';
import 'package:outfoot/screens/navigation_bar/bottom_navigation_bar.dart';
import 'package:outfoot/screens/add_friend_popup_screen.dart';
import 'package:outfoot/screens/edit_profile_page.dart';
import 'package:outfoot/screens/friend_list_screen.dart';
import 'package:outfoot/screens/setting.dart';
import 'package:outfoot/screens/checkpage_foot3.dart';
import 'package:outfoot/screens/checkpage_foot2.dart';
import 'package:outfoot/screens/checkpage_foot.dart';
import 'package:provider/provider.dart';
import 'package:outfoot/utils/goal_provider.dart';

class ProfileMyPage extends StatelessWidget {
  const ProfileMyPage({super.key});

  TextStyle _textStyle(double fontSize, FontWeight fontWeight, Color color) {
    return TextStyle(
      fontSize: fontSize.sp,
      fontFamily: 'Pretendard',
      fontWeight: fontWeight,
      color: color,
    );
  }

  List<Map<String, dynamic>> _getDummyGoals() {
    return [
      {
        "goalId": "1",
        "title": "OUTFOOT 모각코",
        "startDate": "2024-03-01",
        "progress": 99.0,
        "imageUrl": "",
        "destination": null, // 클릭 비활성화
      },
      {
        "goalId": "2",
        "title": "하루에 물 2리터 마시기",
        "startDate": "2024-12-01",
        "progress": 78.0,
        "imageUrl": "",
        "destination": CheckPageFoot2(),
      },
      {
        "goalId": "3",
        "title": "아침 9시 기상하기",
        "startDate": "2024-12-27",
        "progress": 78.0,
        "imageUrl": "",
        "destination": CheckPageFoot(),
      },
    ];
  }

  BoxDecoration _boxDecoration(Color color) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10.0.r),
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightMainColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // **프로필 및 친구 요소를 담고 있는 점선 박스 (크기 조정)**
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 35.h),
                decoration: _boxDecoration(lightColor2),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // **프로필 사진 (첫 글자)**
                        Container(
                          width: 70.w,
                          height: 70.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: mainBrownColor,
                          ),
                          child: Center(
                            child: Text(
                              "이",
                              style: _textStyle(
                                  26, FontWeight.w600, lightMainColor),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        // **이름 및 소개**
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "좋은 아침이에요,",
                              style: _textStyle(
                                  14, FontWeight.w400, blackBrownColor),
                            ),
                            Text(
                              "이해림 님!",
                              style: _textStyle(
                                  18, FontWeight.w700, blackBrownColor),
                            ),
                            Text(
                              "안녕하세요",
                              style:
                                  _textStyle(12, FontWeight.w400, greyColor4),
                            ),
                          ],
                        ),
                        Spacer(),
                        // **설정 및 편집 아이콘 (위치 조정)**
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfile()),
                                );
                              },
                              icon: SvgPicture.asset(
                                'assets/icon/edit.svg',
                                width: 22.w,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SettingUI()),
                                );
                              },
                              icon: SvgPicture.asset(
                                'assets/icon/setting.svg',
                                width: 22.w,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h), // 🔥 점선 박스를 확장하면서 공간 추가

                    // **친구 추가 및 친구 수 버튼 (점선 내부 포함, 높이 조정)**
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildFriendCountCard(), // 친구 수 박스
                        _buildAddFriendButton(context), // 친구 추가 버튼
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.h), // 🔥 점선과 아래 목록 사이 공간 추가

              // **목표 리스트 (Consumer를 사용하여 실시간 반영)**
              Consumer<GoalProvider>(
                builder: (context, goalProvider, child) {
                  List<Map<String, dynamic>> combinedGoals =
                      _getDummyGoals() + goalProvider.goalList;

                  return Column(
                    children: combinedGoals.map((goal) {
                      return GestureDetector(
                        onTap: () {
                          if (goal["destination"] != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => goal["destination"]),
                            );
                          }
                        },
                        child: _buildGoalCard(
                          goal["title"],
                          goal["startDate"],
                          goal["progress"] ?? 0.0,
                          goal["imageUrl"] ?? "",
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: 2),
    );
  }

  // **친구 수 카드 (크기 조정)**
  Widget _buildFriendCountCard() {
    return Container(
      width: 120.w, // 🔥 가로 길이 줄임
      height: 70.h, // 🔥 세로 길이 맞춤
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: _boxDecoration(mainBrownColor2),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "친구 수",
            style: _textStyle(12, FontWeight.w400, greyColor1),
          ),
          SizedBox(height: 4.h),
          Text(
            "0",
            style: _textStyle(16, FontWeight.w600, greyColor1),
          ),
        ],
      ),
    );
  }

  // **친구 추가 버튼 (크기 조정)**
  Widget _buildAddFriendButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddFriendPopup()),
        );
      },
      child: Container(
        width: 160.w, // 🔥 가로 길이 줄임
        height: 70.h, // 🔥 세로 길이 맞춤
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: _boxDecoration(milkBrownColor1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "친구 추가하기",
              style: _textStyle(12, FontWeight.w600, lightMainColor),
            ),
            SizedBox(width: 8.w),
            SvgPicture.asset('assets/people_icon.svg', width: 22.w),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalCard(
      String title, String startDate, double progress, String assetPath) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: lightColor2,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "시작일 $startDate",
              style: _textStyle(12, FontWeight.w400, greyColor4),
            ),
            SizedBox(height: 4.h),
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: _textStyle(14, FontWeight.w500, blackBrownColor),
                  ),
                ),
                if (assetPath.isNotEmpty)
                  SvgPicture.asset(assetPath, width: 20.w),
              ],
            ),
            SizedBox(height: 8.h),
            Stack(
              children: [
                Container(
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: greyColor3,
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: progress / 100,
                  child: Container(
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: mainBrownColor,
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "완성도 $progress% 완성 중",
                style: _textStyle(12, FontWeight.w400, greyColor4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
