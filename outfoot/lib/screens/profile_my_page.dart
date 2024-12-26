import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfoot/colors/colors.dart';
import 'package:outfoot/services/data/mypage_data.dart';
import '../widgets/target_view.dart';
import 'package:outfoot/widgets/dashed_path_painter.dart';
import 'package:outfoot/screens/navigation_bar/bottom_navigation_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// 이동 페이지
import 'package:outfoot/screens/add_friend_popup_screen.dart';
import 'package:outfoot/screens/friend_list_screen.dart';
import 'package:outfoot/screens/edit_profile_page.dart';
import 'package:outfoot/screens/setting.dart';
import 'package:outfoot/screens/checkpage_foot.dart';
import 'package:outfoot/screens/add_friend_screen.dart';

class ProfileMyPage extends StatefulWidget {
  const ProfileMyPage({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileMyPage> {
  bool _isLoading = false; // API 호출 제거로 항상 false

  TextStyle _textStyle(double fontSize, FontWeight fontWeight, Color color,
      double letterSpacing, double height) {
    return TextStyle(
      fontSize: fontSize.sp,
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
      borderRadius: BorderRadius.circular(10.0.r),
      color: color,
      boxShadow: boxShadow,
    );
  }

  final Data = SettingData(
      "정지원", "안녕하세요 만나서 반가워요", "시작일: 2024-12-26 ", "OUTFOOT FE 모각코");

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
    return intro.length > 20
        ? Data.myintro.substring(0, 20) + '…'
        : Data.myintro;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Data.name == null
              ? Center(child: Text('No data found')) // 데이터가 없을 때 처리
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 0.4.sh, // 화면의 40% 크기로 설정
                            decoration: BoxDecoration(
                              color: lightColor2,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20.r),
                                bottomRight: Radius.circular(20.r),
                              ),
                            ),
                            child: CustomPaint(
                              size: Size(
                                  double.infinity, 0.04.sh), // 화면의 4% 크기로 설정
                              painter: DashedPathPainter(),
                            ),
                          ),
                          Positioned(
                            top: 0.08.sh,
                            right: 0.05.sw,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditProfile(),
                                      ),
                                    );
                                  },
                                  child: _svgIcon(
                                    'assets/icon/edit.svg',
                                    width: 0.02.sw,
                                    height: 0.03.sh,
                                  ),
                                ),
                                SizedBox(width: 0.04.sw),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SettingUI(),
                                      ),
                                    );
                                  },
                                  child: _svgIcon(
                                    'assets/icon/setting.svg',
                                    width: 0.06.sw,
                                    height: 0.03.sh,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 0.13.sh,
                            left: 0.06.sw,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 0.2.sw,
                                      height: 0.2.sw,
                                      decoration: BoxDecoration(
                                        color: mainBrownColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Positioned(
                                      left: 0.14.sw,
                                      top: 0.06.sh,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditProfile(),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          child: Center(
                                            child: SizedBox(
                                              width: 36,
                                              height: 36,
                                              child: _svgIcon(
                                                'assets/edit2.svg',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0.0,
                                      child: Container(
                                        width: 0.2.sw,
                                        height: 0.2.sw,
                                        alignment: Alignment.center,
                                        child: Text(
                                          getDisplayName("정"),
                                          style: _textStyle(
                                              0.07.sw,
                                              FontWeight.w600,
                                              lightMainColor,
                                              0.52,
                                              0.8),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 0.06.sw),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '좋은 아침이에요,',
                                      style: _textStyle(
                                          0.05.sw,
                                          FontWeight.w500,
                                          blackBrownColor,
                                          0.4,
                                          0.8),
                                    ),
                                    SizedBox(height: 0.01.sh),
                                    Row(
                                      children: [
                                        Text(
                                          '정지원',
                                          style: _textStyle(
                                              0.05.sw,
                                              FontWeight.w700,
                                              blackBrownColor,
                                              0.4,
                                              0.8),
                                        ),
                                        Text(
                                          ' 님!',
                                          style: _textStyle(
                                              0.05.sw,
                                              FontWeight.w500,
                                              blackBrownColor,
                                              0.4,
                                              0.8),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 0.02.sh),
                                    Text(
                                      '안녕하세요 만나서 반가워요',
                                      style: _textStyle(
                                          0.04.sw,
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
                            top: 0.27.sh,
                            left: 0.06.sw,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 0.25.sw,
                                  height: 0.08.sh,
                                  decoration: _boxDecoration(mainBrownColor2),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => FriendList(),
                                        ),
                                      );
                                    },
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '친구 수',
                                            style: _textStyle(
                                              0.03.sw,
                                              FontWeight.w400,
                                              greyColor1,
                                              0.24,
                                              0.8,
                                            ),
                                          ),
                                          SizedBox(height: 0.01.sh),
                                          Text(
                                            '5',
                                            style: _textStyle(
                                              0.04.sw,
                                              FontWeight.w500,
                                              greyColor1,
                                              0.32,
                                              0.8,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 0.03.sw),
                                Container(
                                  width: 0.6.sw,
                                  height: 0.08.sh,
                                  decoration: _boxDecoration(milkBrownColor1),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AddFriend(),
                                        ),
                                      );
                                    },
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(width: 0.05.sw),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '코드를 통해',
                                                style: _textStyle(
                                                    0.03.sw,
                                                    FontWeight.w400,
                                                    lightMainColor,
                                                    0.24,
                                                    0.8),
                                              ),
                                              SizedBox(height: 0.01.sh),
                                              Text(
                                                '친구 추가하기',
                                                style: _textStyle(
                                                    0.04.sw,
                                                    FontWeight.w500,
                                                    lightMainColor,
                                                    0.28,
                                                    0.8),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
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
                            // Text('Username: ${_profile?.name ?? 'Unknown'}'),
                            // Text('Email: ${_profile?.code ?? 'N/A'}'),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      // 첫 번째 카드 (완성도 99%)
                      Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: Container(
                          width: 330.w,
                          height: 113.h,
                          padding: EdgeInsets.all(16.0.w),
                          decoration: BoxDecoration(
                            color: lightColor,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: ProgressCard(
                            startDate: '2024-03-01',
                            title: 'OUTFOOT 모각코',
                            progressPercentage: 99, // 완성도 99% 수정
                            assetPath: 'assets/lock_icon.svg',
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Padding(
                        padding: EdgeInsets.only(left: 20.sp),
                        child: GestureDetector(
                          // 클릭 이벤트 추가
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CheckPageFoot(), // 이동할 페이지
                              ),
                            );
                          },
                          child: Container(
                            width: 330.w,
                            height: 113.h,
                            padding: EdgeInsets.all(16.0.sp),
                            decoration: BoxDecoration(
                              color: lightColor2,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: ProgressCard(
                              startDate: '2024-12-01',
                              title: '하루에 물 2리터 마시기',
                              progressPercentage: 78,
                              assetPath: '',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: 2),
    );
  }
}
