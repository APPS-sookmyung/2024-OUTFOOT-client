import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfoot/api/profile_my_page_api.dart';
import 'package:outfoot/colors/colors.dart';
import 'package:outfoot/services/data/mypage_data.dart';
import '../widgets/target_view.dart';
import 'package:outfoot/widgets/dashed_path_painter.dart';
import 'package:outfoot/screens/navigation_bar/bottom_navigation_bar.dart';
import 'package:outfoot/models/profile_my_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:outfoot/services/data/mypage_data.dart';

class ProfileMyPage extends StatefulWidget {
  const ProfileMyPage({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileMyPage> {
  final ProfileMyApi _profileApi = ProfileMyApi();
  Profile? _profile;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    final String? token = dotenv.env['TOKEN'];
    if (token == null) {
      debugPrint("Error: TOKEN is not defined in .env");
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final profile = await _profileApi.profileMy(token);
    setState(() {
      _profile = profile;
      _isLoading = false;
    });
  }

  TextStyle _textStyle(double fontSize, FontWeight fontWeight, Color color,
      double letterSpacing, double height) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: 'Pretendard',
      fontStyle: FontStyle.normal,
      fontWeight: fontWeight,
      color: color,
      height: height,
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

  final Data = SettingData("정지원", "안녕하세요 만나서 반가워요", "시작일: 2024-12-26 ", "OUTFOOT FE 모각코");

  Widget _svgIcon(String assetName,
      {double? width, double? height, BoxFit fit = BoxFit.none}) {
    return SvgPicture.asset(
      assetName,
      width: width,
      height: height,
      fit: fit,
    );
  }

  String getDisplayName(String? name) {
    if (Data.name == null || Data.name.isEmpty) {
      return " "; // 기본값 지정
    }
    return Data.name[0]; // 이름의 첫 번째 글자 반환
  }

  String truncateIntro(String? intro) {
    if (intro == null) return "소개글을 작성해주세요";
    return intro.length > 20 ? Data.myintro.substring(0, 20) + '…' : Data.myintro;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _profile == null
              ? Center(child: Text('No data found')) // 데이터가 없을 때 처리
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: screenWidth,
                            height: screenHeight * 0.4,
                            decoration: BoxDecoration(
                              color: lightColor2,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: CustomPaint(
                              size: Size(screenWidth, screenHeight * 0.04),
                              painter: DashedPathPainter(),
                            ),
                          ),
                          Positioned(
                            top: screenHeight * 0.08,
                            right: screenWidth * 0.05,
                            child: Row(
                              children: [
                                _svgIcon('assets/icon/edit.svg',
                                    width: screenWidth * 0.02,
                                    height: screenHeight * 0.03),
                                SizedBox(width: screenWidth * 0.04),
                                _svgIcon('assets/icon/setting.svg',
                                    width: screenWidth * 0.06,
                                    height: screenHeight * 0.03),
                              ],
                            ),
                          ),
                          Positioned(
                            top: screenHeight * 0.13,
                            left: screenWidth * 0.08,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: screenWidth * 0.2,
                                      height: screenWidth * 0.2,
                                      decoration: BoxDecoration(
                                        color: mainBrownColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Positioned(
                                      left: screenWidth * 0.14,
                                      top: screenHeight * 0.06,
                                      child: Container(
                                        child: Center(
                                          child: SizedBox(
                                            width: 36,
                                            height: 36,
                                            child: _svgIcon('assets/edit2.svg',
                                                fit: BoxFit.contain),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0.0,
                                      child: Container(
                                        width: screenWidth * 0.2,
                                        height: screenWidth * 0.2,
                                        alignment: Alignment.center,
                                        child: Text(
                                          // getDisplayName(_profile?.name),
                                          Data.name,
                                          style: _textStyle(
                                              screenWidth * 0.07,
                                              FontWeight.w600,
                                              lightMainColor,
                                              0.52,
                                              0.8),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: screenWidth * 0.06),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '좋은 아침이에요,',
                                      style: _textStyle(
                                          screenWidth * 0.05,
                                          FontWeight.w500,
                                          blackBrownColor,
                                          0.4,
                                          0.8),
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    Row(
                                      children: [
                                        Text(
                                          // _profile?.name ?? '사용자',
                                          Data.name,
                                          style: _textStyle(
                                              screenWidth * 0.05,
                                              FontWeight.w700,
                                              blackBrownColor,
                                              0.4,
                                              0.8),
                                        ),
                                        Text(
                                          ' 님!',
                                          style: _textStyle(
                                              screenWidth * 0.05,
                                              FontWeight.w500,
                                              blackBrownColor,
                                              0.4,
                                              0.8),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    Text(
                                      truncateIntro(_profile?.myIntro),
                                      style: _textStyle(
                                          screenWidth * 0.04,
                                          FontWeight.w400,
                                          greyColor1,
                                          1.2,
                                          0.28),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: screenHeight * 0.27,
                            left: screenWidth / 2 - screenWidth * 0.4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: screenWidth * 0.25,
                                  height: screenHeight * 0.08,
                                  decoration: _boxDecoration(mainBrownColor2),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '친구 수',
                                          style: _textStyle(
                                              screenWidth * 0.03,
                                              FontWeight.w400,
                                              greyColor1,
                                              0.24,
                                              0.8),
                                        ),
                                        SizedBox(height: screenHeight * 0.01),
                                        Text(
                                          '${_profile?.friendCount ?? 0}',
                                          style: _textStyle(
                                              screenWidth * 0.04,
                                              FontWeight.w500,
                                              greyColor1,
                                              0.32,
                                              0.8),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.03),
                                Container(
                                  width: screenWidth * 0.6,
                                  height: screenHeight * 0.08,
                                  decoration: _boxDecoration(milkBrownColor1),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(width: screenWidth * 0.05),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '코드를 통해',
                                              style: _textStyle(
                                                  screenWidth * 0.03,
                                                  FontWeight.w400,
                                                  lightMainColor,
                                                  0.24,
                                                  0.8),
                                            ),
                                            SizedBox(
                                                height: screenHeight * 0.01),
                                            Text(
                                              '친구 추가하기',
                                              style: _textStyle(
                                                  screenWidth * 0.04,
                                                  FontWeight.w500,
                                                  lightMainColor,
                                                  0.28,
                                                  0.8),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                right: screenWidth * 0.05),
                                            child: _svgIcon(
                                                'assets/people_icon.svg',
                                                width: screenWidth * 0.15,
                                                height: screenHeight * 0.06),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Username: ${_profile?.name ?? 'Unknown'}'),
                            Text('Email: ${_profile?.code ?? 'N/A'}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
