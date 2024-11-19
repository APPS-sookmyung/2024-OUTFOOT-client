import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfoot/colors/colors.dart';
import 'package:outfoot/screens/navigation_bar/bottom_navigation_bar.dart';

class AddFriendPopup extends StatefulWidget {
  const AddFriendPopup({super.key});

  @override
  _AddFriendPopupState createState() => _AddFriendPopupState();
}

class _AddFriendPopupState extends State<AddFriendPopup> {
  final TextEditingController _codeController = TextEditingController();
  String? _inviteCode;

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

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

  void _showPopup(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: EdgeInsets.all(16.0),
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '친구 추가 성공',
                    textAlign: TextAlign.center,
                    style: _textStyle(16.0, FontWeight.w400, greyColor2, -0.32),
                  ),
                  SizedBox(width: 8.0),
                  _svgIcon('assets/icon/party_popper.svg',
                      width: 24.0, height: 24.0),
                ],
              ),
              SizedBox(height: 25.0),
              Text(
                message,
                textAlign: TextAlign.center,
                style: _textStyle(18.0, FontWeight.w500, greyColor1, -0.36),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                '닫기',
                style: _textStyle(16.0, FontWeight.w600, mainBrownColor, -0.32),
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
      appBar: AppBar(
        backgroundColor: lightColor1,
        title: Text(
          '친구 추가하기',
          style: _textStyle(
              screenWidth * 0.045, FontWeight.w600, greyColor1, -0.32),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          color: lightColor1,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: screenHeight * 0.03),
                _buildInviteCodeCard(screenWidth, screenHeight),
                SizedBox(height: screenHeight * 0.02),
                _svgIcon('assets/arrow.svg',
                    width: screenWidth * 0.05, height: screenHeight * 0.03),
                SizedBox(height: screenHeight * 0.03),
                _buildFriendCodeInput(screenWidth, screenHeight),
                SizedBox(height: screenHeight * 0.03),
                GestureDetector(
                  onTap: () => _showPopup(context, "친구 추가에 성공하였습니다."),
                  child: Container(
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.06,
                    decoration: BoxDecoration(
                      color: mainBrownColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text('추가하기',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w600,
                            color: lightMainColor,
                            letterSpacing: -0.28,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  Widget _buildInviteCodeCard(double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth * 0.85,
      height: screenHeight * 0.18,
      decoration: BoxDecoration(
        color: darkBrownColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Stack(
        children: [
          Positioned(
            top: screenHeight * 0.03,
            left: screenWidth * 0.08,
            child: Text(
              '친구를 초대해보세요',
              style: TextStyle(
                fontSize: screenWidth * 0.03,
                fontWeight: FontWeight.w400,
                color: lightMainColor,
                letterSpacing: -0.22,
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.05,
            left: screenWidth * 0.08,
            child: Text(
              '내 코드',
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                fontWeight: FontWeight.w500,
                color: lightMainColor,
                letterSpacing: -0.28,
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.12,
            left: screenWidth * 0.08,
            child: Row(
              children: <Widget>[
                Text(
                  'A29NB67', // 임의 코드
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.w600,
                    color: lightMainColor,
                    letterSpacing: -0.4,
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                GestureDetector(
                  onTap: () =>
                      _copyToClipboard(_inviteCode ?? '초대 코드를 불러올 수 없습니다.'),
                  child: _svgIcon('assets/icon/copy.svg',
                      width: screenWidth * 0.05, height: screenHeight * 0.03),
                ),
                SizedBox(width: screenWidth * 0.02),
                GestureDetector(
                  onTap: () =>
                      _copyToClipboard(_inviteCode ?? '초대 코드를 불러올 수 없습니다.'),
                  child: Text(
                    '복사하기',
                    style: TextStyle(
                      fontSize: screenWidth * 0.03,
                      fontWeight: FontWeight.w400,
                      color: lightMainColor,
                      letterSpacing: -0.22,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: screenHeight * 0.07,
            left: screenWidth * 0.55,
            child: _svgIcon('assets/icon/logo_basic.svg',
                width: screenWidth * 0.05, height: screenHeight * 0.03),
          )
        ],
      ),
    );
  }

  Widget _buildFriendCodeInput(double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth * 0.85,
      height: screenHeight * 0.18,
      decoration: BoxDecoration(
        color: beigeColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '친구에게 받은 코드를 입력해주세요',
              style: TextStyle(
                fontSize: screenWidth * 0.03,
                fontWeight: FontWeight.w400,
                color: greyColor2,
                letterSpacing: -0.22,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              '친구 코드',
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                fontWeight: FontWeight.w500,
                color: greyColor1,
                letterSpacing: -0.28,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Container(
              width: double.infinity,
              height: screenHeight * 0.05,
              decoration: BoxDecoration(
                color: lightColor2,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: TextField(
                  controller: _codeController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '친구 코드 입력',
                    hintStyle: TextStyle(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w400,
                      color: greyColor4,
                      letterSpacing: -0.28,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
