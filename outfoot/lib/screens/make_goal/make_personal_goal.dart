import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfoot/api/personal_goal_api.dart';
import 'package:outfoot/models/personal_goal_model.dart';
import 'package:outfoot/colors/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 이동 페이지 import
import 'package:outfoot/screens/home_page.dart';
import 'package:outfoot/screens/navigation_bar/bottom_navigation_bar.dart';

class MakePersonalGoalPage extends StatefulWidget {
  @override
  _MakePersonalGoalPageState createState() => _MakePersonalGoalPageState();
}

class _MakePersonalGoalPageState extends State<MakePersonalGoalPage> {
  final TextEditingController _goalNameController = TextEditingController();
  final TextEditingController _goalDescriptionController =
      TextEditingController();
  final PersonalGoalApi _goalApi = PersonalGoalApi();

  int? selectedAnimalId;
  String? token;
  int? checkPageId;

  void _postGoal() async {
    if (selectedAnimalId == null) {
      print('Please select an animal before submitting.');
      return;
    }

    token = dotenv.env['TOKEN'];
    if (token == null) {
      debugPrint("Error: TOKEN is not defined in .env");
      return;
    }

    // 목표 생성 API 호출
    final response = await _goalApi.postGoal(
      token!,
      _goalNameController.text,
      _goalDescriptionController.text,
      selectedAnimalId!,
    );

    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: apricotColor1,
          appBar: AppBar(
            backgroundColor: apricotColor1,
            elevation: 0,
            leading: IconButton(
              icon: SvgPicture.asset(
                'assets/back_icon.svg',
                width: 17.375.w,
                height: 18.688.h,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              '도장 만들기',
              style: TextStyle(
                fontSize: 16.sp,
                color: greyColor1,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                height: 0.8,
                letterSpacing: -0.32,
              ),
            ),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              // 하단 고정 박스
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 600.h,
                  decoration: BoxDecoration(
                    color: lightColor1,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r),
                    ),
                  ),
                ),
              ),
              // 상단 콘텐츠
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),
                    _buildMateSelectionSection(),
                    SizedBox(height: 32.h),
                    _buildTextFieldSection(
                        '목표 명', '목표를 입력해주세요', _goalNameController),
                    SizedBox(height: 24.h),
                    _buildTextFieldSection('한 줄 소개', '목표에 대한 소개를 입력해주세요',
                        _goalDescriptionController),
                    SizedBox(height: 32.h),
                    _buildCompleteButton('설정 완료', _postGoal),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: 1),
        );
      },
    );
  }

  Widget _buildMateSelectionSection() {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 40.r,
            backgroundColor: apricotColor2,
            child: SvgPicture.asset(
              'assets/stamp.svg',
              width: 37.w,
              height: 35.h,
            ),
          ),
          SizedBox(height: 11.h),
          ElevatedButton(
            onPressed: () {
              _showMateSelectionModal(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: yellowColor,
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              elevation: 0,
            ),
            child: Text(
              '도장 메이트 선택',
              style: TextStyle(
                color: greyColor1,
                fontSize: 12.sp,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                height: 0.8,
                letterSpacing: -0.24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldSection(
      String label, String hintText, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
              color: greyColor2,
              fontSize: 12.sp,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400,
              height: 0.8,
              letterSpacing: -0.24),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          style: TextStyle(
              color: greyColor3,
              fontSize: 14.sp,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400,
              height: 0.8,
              letterSpacing: -0.28),
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: lightColor2,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCompleteButton(String text, VoidCallback onPressed) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 50.h,
        child: ElevatedButton(
          onPressed: selectedAnimalId != null
              ? () async {
                  onPressed();
                  // 페이지 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                }
              : null, // selectedAnimalId가 null이면 비활성화
          style: ElevatedButton.styleFrom(
            backgroundColor: selectedAnimalId != null
                ? apricotColor2 // 활성화 색상
                : greyColor6, // 비활성화 색상
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              height: 0.8,
              letterSpacing: -0.28,
            ),
          ),
        ),
      ),
    );
  }

  void _showMateSelectionModal(BuildContext context) {
    int? tempSelectedAnimalId;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // 화면 크기와 관계없이 높이 조정 가능
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        return Stack(
          children: [
            // 뒤의 배경 요소를 투명하게 설정
            Positioned.fill(
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  color: Colors.black.withOpacity(0.5), // 반투명 검은 배경
                ),
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.7, // 초기 높이를 화면의 70%로 설정
              maxChildSize: 0.95, // 최대 높이
              minChildSize: 0.5, // 최소 높이
              expand: false, // 고정된 높이에서 확장 가능 여부
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: greyColor10,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.r)),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController, // 스크롤 컨트롤러 연결
                    child: Column(
                      children: [
                        SizedBox(height: 16.h),
                        Text(
                          '해당 목표의\n도장 메이트를 선택해주세요',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: greyColor1,
                            fontSize: 18.sp,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            height: 1.2,
                            letterSpacing: -0.36,
                          ),
                        ),
                        SizedBox(height: 13.h),
                        SvgPicture.asset(
                          'assets/yellow_smile_icon.svg',
                          width: 124.w,
                          height: 124.h,
                        ),
                        SizedBox(height: 40.h),
                        GridView.builder(
                          shrinkWrap: true, // 그리드 크기를 자식에 맞춤
                          physics: NeverScrollableScrollPhysics(), // 내부 스크롤 방지
                          itemCount: 8,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 13.w,
                            mainAxisSpacing: 13.h,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  tempSelectedAnimalId =
                                      index + 1; // 선택된 animalId
                                });
                              },
                              child: Container(
                                width: 60.w,
                                height: 60.h,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFF9F6F0),
                                  shape: OvalBorder(),
                                ),
                                child: index == 0 // 첫 번째 원에만 이미지 추가
                                    ? SvgPicture.asset(
                                        'assets/animal_illust/polarBear.svg', // 첫 번째 원의 SVG 파일
                                        width: 40.w,
                                        height: 40.h,
                                      )
                                    : null, // 다른 원에는 아무 것도 추가하지 않음
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 54.h), // 원과 선택 완료 버튼 사이의 간격
                        SizedBox(
                          width: double.infinity,
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed: () {
                              if (tempSelectedAnimalId != null) {
                                setState(() {
                                  selectedAnimalId =
                                      tempSelectedAnimalId; // 최종적으로 선택된 animalId
                                });
                                Navigator.pop(context);
                              } else {
                                print(
                                    'Please select an animal before completing.');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: apricotColor2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: Text(
                              '선택 완료',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
