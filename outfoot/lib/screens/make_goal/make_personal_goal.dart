import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfoot/api/personal_goal_api.dart';
import 'package:outfoot/models/personal_goal_model.dart';
import 'package:outfoot/colors/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

// 이동 페이지 import
import 'package:outfoot/screens/home_page.dart';
import 'package:outfoot/screens/checkpage_foot3.dart';
import 'package:outfoot/utils/goal_provider.dart';
import 'package:provider/provider.dart';
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

  String generateGoalId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

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

    // ✅ 새로운 goalId 생성 (API가 아니라 앱 내부에서 생성)
    String goalId = generateGoalId();

    // ✅ GoalProvider에 목표 추가
    final goalProvider = Provider.of<GoalProvider>(context, listen: false);
    goalProvider.updateGoal(
      goalId,
      _goalNameController.text,
      _goalDescriptionController.text,
      DateTime.now().toString(),
    );

    // ✅ API 호출 (하지만 goalId는 API에서 받지 않음)
    await _goalApi.postGoal(
      token!,
      _goalNameController.text,
      _goalDescriptionController.text,
      selectedAnimalId!,
    );

    // ✅ 목표 생성 후 HomePage로 데이터 전달
    Navigator.pop(context, {
      "goalId": goalId, // ✅ 생성한 goalId 전달
      "title": _goalNameController.text,
      "startDate": DateTime.now().toString().split(" ")[0],
      "imageUrl": "", // ✅ 기본값으로 빈 값 설정
    });
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

                  if (_goalNameController.text.isNotEmpty) {
                    // 📌 현재 날짜 가져오기
                    String currentDate =
                        DateFormat('yyyy-MM-dd').format(DateTime.now());

                    // 📌 새로운 목표 데이터 생성
                    Map<String, dynamic> newGoal = {
                      "title": _goalNameController.text,
                      "startDate": currentDate,
                      "progress": 0.0, // 기본값 0%
                    };

                    // 📌 HomePage로 목표 데이터 전달
                    Navigator.pop(context, newGoal);
                  }
                }
              : null, // 📌 여기에서 `null` 닫힘을 올바르게 수정
          style: ElevatedButton.styleFrom(
            backgroundColor:
                selectedAnimalId != null ? apricotColor2 : greyColor6,
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
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Stack(
              children: [
                // 반투명 배경
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
                DraggableScrollableSheet(
                  initialChildSize: 0.7,
                  maxChildSize: 0.95,
                  minChildSize: 0.5,
                  expand: false,
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24.w, vertical: 16.h),
                      decoration: BoxDecoration(
                        color: greyColor10,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20.r)),
                      ),
                      child: SingleChildScrollView(
                        controller: scrollController,
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

                            // 첫번째 원 누르면 polarBear.svg 표시
                            SvgPicture.asset(
                              selectedAnimalId == 1
                                  ? 'assets/animal_illust/polarBear.svg'
                                  : 'assets/yellow_smile_icon.svg',
                              width: 124.w,
                              height: 124.h,
                            ),

                            SizedBox(height: 40.h),

                            // GridView 동물 선택
                            GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
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
                                    setModalState(() {
                                      tempSelectedAnimalId = index + 1;
                                    });
                                  },
                                  child: Container(
                                    width: 60.w,
                                    height: 60.h,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFFF9F6F0),
                                      shape: OvalBorder(),
                                    ),
                                    child: index == 0
                                        ? SvgPicture.asset(
                                            'assets/animal_illust/polarBear.svg',
                                            width: 40.w,
                                            height: 40.h,
                                          )
                                        : null,
                                  ),
                                );
                              },
                            ),

                            SizedBox(height: 54.h),

                            // 선택 완료 버튼
                            SizedBox(
                              width: double.infinity,
                              height: 50.h,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (tempSelectedAnimalId != null) {
                                    setState(() {
                                      selectedAnimalId = tempSelectedAnimalId;
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
      },
    );
  }
}
