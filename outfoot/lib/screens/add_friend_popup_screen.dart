import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfoot/colors/colors.dart';
import 'package:outfoot/screens/navigation_bar/bottom_navigation_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddFriendPopup extends StatefulWidget {
  const AddFriendPopup({super.key});

  @override
  _AddFriendPopupState createState() => _AddFriendPopupState();
}

class _AddFriendPopupState extends State<AddFriendPopup> {
  final TextEditingController _codeController = TextEditingController();
  String _inviteCode = "A29NB67"; // 🔥 임시 초대 코드
  bool _isLoading = false;

  TextStyle _textStyle(double fontSize, FontWeight fontWeight, Color color,
      double letterSpacing) {
    return TextStyle(
      fontSize: fontSize.sp,
      fontFamily: 'Pretendard',
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    _showPopup("초대 코드가 복사되었습니다.");
  }

  void _addFriend() {
    final code = _codeController.text.trim();
    if (code.isEmpty) {
      _showPopup("코드를 입력해주세요.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // 친구 추가 로직 (임시)
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });

      if (code == _inviteCode) {
        _showPopup("친구 추가에 성공하였습니다!");
      } else {
        _showPopup("존재하지 않는 친구 코드입니다.");
      }
    });
  }

  void _showPopup(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          contentPadding: EdgeInsets.all(16.0.w),
          title: Text(
            message,
            textAlign: TextAlign.center,
            style: _textStyle(16.0, FontWeight.w500, greyColor1, -0.28),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                '닫기',
                style: _textStyle(14.0, FontWeight.w600, mainBrownColor, -0.22),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: lightMainColor,
      appBar: AppBar(
        backgroundColor: lightMainColor,
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
          '친구 추가하기',
          style: _textStyle(16, FontWeight.w600, greyColor1, -0.28),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 27.0.w, top: 27.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔥 내 코드 공유하기
              Text(
                '내 코드 공유하기',
                style: _textStyle(14.0, FontWeight.w500, greyColor1, -0.28),
              ),
              SizedBox(height: 16.h),
              _buildInviteCodeCard(screenWidth, screenHeight),
              SizedBox(height: 32.h),

              // 🔥 친구 추가하기
              Text(
                '친구 추가하기',
                style: _textStyle(14.0, FontWeight.w500, greyColor1, -0.28),
              ),
              SizedBox(height: 16.h),
              _buildFriendCodeInput(screenWidth, screenHeight),
              SizedBox(height: 16.h),

              // 추가하기 버튼
              GestureDetector(
                onTap: _isLoading ? null : _addFriend,
                child: Container(
                  width: screenWidth * 0.85.w,
                  height: screenHeight * 0.06.h,
                  decoration: BoxDecoration(
                    color: mainBrownColor,
                    borderRadius: BorderRadius.circular(10.0.r),
                  ),
                  child: Center(
                    child: _isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "추가하기",
                            style: _textStyle(
                                16.0, FontWeight.w600, lightMainColor, -0.28),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: 2),
    );
  }

  Widget _buildInviteCodeCard(double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth * 0.85.w,
      height: screenHeight * 0.18.h,
      decoration: BoxDecoration(
        color: darkBrownColor,
        borderRadius: BorderRadius.circular(10.0.r),
      ),
      child: Stack(
        children: [
          Positioned(
            top: screenHeight * 0.05.h,
            left: screenWidth * 0.08.w,
            child: Text(
              '내 코드',
              style: _textStyle(14.0, FontWeight.w500, lightMainColor, -0.28),
            ),
          ),
          Positioned(
            top: screenHeight * 0.12.h,
            left: screenWidth * 0.08.w,
            child: Row(
              children: [
                Text(
                  _inviteCode,
                  style:
                      _textStyle(20.0, FontWeight.w600, lightMainColor, -0.4),
                ),
                SizedBox(width: screenWidth * 0.02.w),
                GestureDetector(
                  onTap: () => _copyToClipboard(_inviteCode),
                  child: SvgPicture.asset(
                    'assets/icon/copy.svg',
                    width: screenWidth * 0.05.w,
                    height: screenHeight * 0.03.h,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendCodeInput(double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth * 0.85.w,
      height: screenHeight * 0.18.h,
      decoration: BoxDecoration(
        color: beigeColor,
        borderRadius: BorderRadius.circular(10.0.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '친구 코드',
              style: _textStyle(14.0, FontWeight.w500, greyColor1, -0.28),
            ),
            SizedBox(height: screenHeight * 0.02.h),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '친구 코드 입력',
                hintStyle: _textStyle(12.0, FontWeight.w400, greyColor4, -0.28),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
