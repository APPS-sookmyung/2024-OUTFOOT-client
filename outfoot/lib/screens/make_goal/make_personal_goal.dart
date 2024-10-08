import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfoot/api/personal_goal_api.dart';
import 'package:outfoot/models/personal_goal_model.dart';
import 'package:outfoot/colors/colors.dart';

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

  void _postGoal() async {
    if (selectedAnimalId == null) {
      print('Please select an animal before submitting.');
      return;
    }

    final token = ''; //토큰 발급받아 넣는 곳

    final response = await _goalApi.postGoal(
      token,
      _goalNameController.text,
      _goalDescriptionController.text,
      selectedAnimalId!,
    );
    print(response);
  }

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            _buildMateSelectionSection(),
            SizedBox(height: 32),
            _buildTextFieldSection(
                '목표 명', '하루에 물 2리터 마시기', _goalNameController),
            SizedBox(height: 24),
            _buildTextFieldSection(
                '한 줄 소개', '건강한 이너뷰티', _goalDescriptionController),
            Spacer(),
            _buildCompleteButton('설정 완료', _postGoal),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildMateSelectionSection() {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: apricotColor2,
            child: Icon(Icons.person, size: 40, color: Colors.white),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              _showMateSelectionModal(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: yellowColor,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              '도장 메이트 선택',
              style: TextStyle(
                color: greyColor1,
                fontSize: 12,
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
            fontSize: 16,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: greyColor10,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
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
        height: 50,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: apricotColor2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              fontSize: 16,
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
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 518,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: greyColor10,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              SizedBox(height: 16),
              Text(
                '해당 목표의\n도장 메이트를 선택해주세요',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: greyColor1,
                  fontSize: 18,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.36,
                ),
              ),
              SizedBox(height: 20),
              SvgPicture.asset(
                'assets/yellow_smile_icon.svg',
                width: 124,
                height: 124,
              ),
              SizedBox(height: 40),
              Expanded(
                child: GridView.builder(
                  itemCount: 8,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 13,
                    mainAxisSpacing: 13,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          tempSelectedAnimalId = index + 1; // 임시로 선택된 animalId
                        });
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: ShapeDecoration(
                          color: Color(0xFFF9F6F0),
                          shape: OvalBorder(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
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
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    '선택 완료',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
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
