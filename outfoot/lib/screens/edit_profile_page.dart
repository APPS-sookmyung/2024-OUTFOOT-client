import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfoot/colors/colors.dart';
import 'package:outfoot/widgets/dashed_line_painter.dart';
import 'package:outfoot/api/profile_edit_api.dart';
import 'package:outfoot/models/profile_edit_model.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final ProfileEditApi _profileEditApi = ProfileEditApi();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _introController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  TextStyle _textStyle(double fontSize, FontWeight fontWeight, Color color,
      double letterSpacing) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: 'Pretendard',
      fontStyle: FontStyle.normal,
      fontWeight: fontWeight,
      color: color,
      height: 0.8,
      letterSpacing: letterSpacing,
    );
  }

  BoxDecoration _boxDecoration(Color color, [List<BoxShadow>? boxShadow]) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: color,
      boxShadow: boxShadow,
    );
  }

  Widget _svgIcon(String assetName,
      {double? width, double? height, BoxFit fit = BoxFit.none}) {
    return SvgPicture.asset(
      assetName,
      width: width,
      height: height,
      fit: fit,
    );
  }

   Future<void> _updateProfile() async {

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _profileEditApi.updateProfile(
        nickname: _nicknameController.text,
        myIntro: _introController.text,
        email: _emailController.text,
        token: 'user-access-token',
      );

      if (response.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('프로필이 성공적으로 수정되었습니다!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('수정 실패: ${response.message}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('오류 발생: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainBrownColor2.withOpacity(0.5),
        leading: _svgIcon('assets/icon/before_arrow.svg',
            width: 17.38, height: 8.69),
        centerTitle: true,
        title: Text(
          '프로필 수정',
          style: _textStyle(16.0, FontWeight.w600, Color(0xFF3E3E3E), -0.32),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 312.0,
                color: mainBrownColor2.withOpacity(0.5),
              ),
            ],
          ),
          Positioned(
            top: 64.0,
            left: (MediaQuery.of(context).size.width - 98.0) / 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 98.0,
                  height: 98.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: mainBrownColor,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        '문',
                        style: _textStyle(
                            24.0, FontWeight.bold, Colors.white, 0.0),
                      ),
                      Positioned(
                        bottom: 0,
                        left: (98.0 - 69.0) / 2,
                        child: Container(
                          width: 69.0,
                          height: 30.0,
                          decoration: _boxDecoration(yellowColor),
                        ),
                      ),
                      Positioned(
                        top: 78.0,
                        child: Text(
                          '사진 수정',
                          style: _textStyle(
                              12, FontWeight.w400, greyColor1, -0.24),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 24.0),
                Row(
                  children: [
                    Positioned(
                      top: 78.0,
                      left: 159.0,
                      child: Text(
                        '문서영',
                        style: _textStyle(
                            16.0, FontWeight.w500, greyColor1, -0.32),
                      ),
                    ),
                    Positioned(
                      top: 78.0,
                      left: 164.17,
                      child: Transform.rotate(
                        angle: (3.14159 / 180),
                        child: Container(
                          width: 15.0,
                          height: 15.0,
                          child: SvgPicture.asset(
                            'assets/icon/edit.svg',
                            color: mainBrownColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 219.0,
            left: (MediaQuery.of(context).size.width - 320.0) / 2,
            child: Container(
              width: 320.0,
              height: 72.0,
              decoration: _boxDecoration(lightMainColor),
            ),
          ),
          Positioned(
            top: 264.0,
            right: 42.0,
            child: Text(
              '19/20',
              style: _textStyle(11, FontWeight.w400, mainBrownColor, -0.22),
            ),
          ),
          Positioned(
            top: 310.5,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 2),
              painter: DashedLinePainter(color: mainBrownColor2),
            ),
          ),
          Positioned(
            top: 341.0,
            left: 20.5,
            right: 20.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '이메일 주소',
                  style: _textStyle(12.0, FontWeight.w400, greyColor2, 0.24),
                ),
                SizedBox(height: 8.0),
                Container(
                  width: double.infinity,
                  height: 46.0,
                  decoration: _boxDecoration(lightColor2),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  '비밀번호 변경',
                  style: _textStyle(12.0, FontWeight.w400, greyColor2, 0.24),
                ),
                SizedBox(height: 8.0),
                Container(
                  width: double.infinity,
                  height: 46.0,
                  decoration: _boxDecoration(lightColor2),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  '비밀번호 확인',
                  style: _textStyle(12.0, FontWeight.w400, greyColor2, 0.24),
                ),
                SizedBox(height: 8.0),
                Container(
                  width: double.infinity,
                  height: 46.0,
                  decoration: _boxDecoration(lightColor2),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 38.0),
                Container(
                  width: 320.0,
                  height: 45.994,
                  decoration: _boxDecoration(mainBrownColor),
                  child: Center(
                    child: Text(
                      '변경하기',
                      textAlign: TextAlign.center,
                      style: _textStyle(
                          14.0, FontWeight.w600, lightMainColor, -0.28),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
