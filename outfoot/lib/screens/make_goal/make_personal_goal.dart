import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfoot/api/personal_goal_api.dart';
import 'package:outfoot/models/personal_goal_model.dart';
import 'package:outfoot/colors/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 이동 페이지 import
import 'package:outfoot/screens/home_page.dart';

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
              icon: Icon(Icons.arrow_back, color: blackBrownColor),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              '도장 만들기',
              style: TextStyle(color: blackBrownColor),
            ),
            centerTitle: true,
          ),
          body: Padding(
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
                _buildTextFieldSection(
                    '한 줄 소개', '목표에 대한 소개를 입력해주세요', _goalDescriptionController),
                Spacer(),
                _buildCompleteButton('설정 완료', _postGoal),
                SizedBox(height: 24.h),
              ],
            ),
          ),
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
            child: Icon(Icons.person, size: 40.sp, color: Colors.white),
          ),
          SizedBox(height: 16.h),
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
            ),
            child: Text(
              '도장 메이트 선택',
              style: TextStyle(
                color: greyColor1,
                fontSize: 12.sp,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
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
            color: blackBrownColor,
            fontSize: 16.sp,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: greyColor10,
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
              fontSize: 16.sp,
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 518.h,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: greyColor10,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
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
                  letterSpacing: -0.36,
                ),
              ),
              SizedBox(height: 20.h),
              SvgPicture.asset(
                'assets/yellow_smile_icon.svg',
                width: 124.w,
                height: 124.h,
              ),
              SizedBox(height: 40.h),
              Expanded(
                child: GridView.builder(
                  itemCount: 8,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 13.w,
                    mainAxisSpacing: 13.h,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          tempSelectedAnimalId = index + 1; // 임시로 선택된 animalId
                        });
                      },
                      child: Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: ShapeDecoration(
                          color: Color(0xFFF9F6F0),
                          shape: OvalBorder(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16.h),
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
                      print('Please select an animal before completing.');
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
            ],
          ),
        );
      },
    );
  }
}
