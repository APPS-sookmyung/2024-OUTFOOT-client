import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfoot/api/add_friend_api.dart';
import 'package:flutter/services.dart';
import 'package:outfoot/colors/colors.dart';
import 'package:outfoot/screens/navigation_bar/bottom_navigation_bar.dart';

class AddFriendPopup extends StatefulWidget {
  const AddFriendPopup({super.key});

  @override
  _AddFriendPopupState createState() => _AddFriendPopupState();
}

class _AddFriendPopupState extends State<AddFriendPopup> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _memberIdController = TextEditingController();
  final TextEditingController _tokenController = TextEditingController();
  final FriendService _friendService = FriendService();

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
  }

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

  Future<void> _onAddFriend() async {
    final friendCode = _codeController.text;
    final memberId = _memberIdController.text;
    final token = _tokenController.text;

    final resultMessage =
        await _friendService.addFriend(memberId, friendCode, token);

    String message;
    switch (resultMessage) {
      case '200':
        message = "친구 추가에 성공하였습니다";
        break;
      case '400_self':
        message = "자기 자신을 친구로 추가할 수 없습니다";
        break;
      case '400_not_exist':
        message = "존재하지 않는 회원입니다";
        break;
      case '400_already_friend':
        message = "이미 존재하는 친구입니다";
        break;
      default:
        message = "알 수 없는 오류가 발생했습니다.";
    }

    _showPopup(context, message);
  }

  void _showPopup(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: _textStyle(16.0, FontWeight.w400, greyColor2, -0.32),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                '닫기',
                style: _textStyle(16.0, FontWeight.w600, mainBrownColor, -0.32),
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 반응형을 위한 화면 너비와 높이 정의
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: lightColor1,
        leading: _svgIcon('assets/icon/before_arrow.svg',
            width: screenWidth * 0.05, height: screenHeight * 0.03),
        centerTitle: true,
        title: Text(
          '친구 추가하기',
          style: _textStyle(
              screenWidth * 0.045, FontWeight.w600, greyColor1, -0.32),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                  onTap: _onAddFriend,
                  child: Container(
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.06,
                    decoration: _boxDecoration(mainBrownColor),
                    child: Center(
                      child: Text(
                        '추가하기',
                        textAlign: TextAlign.center,
                        style: _textStyle(screenWidth * 0.04, FontWeight.w600,
                            lightMainColor, -0.28),
                      ),
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
    final String inviteCode = '123456'; // 임의의 코드

    return Container(
      width: screenWidth * 0.85,
      height: screenHeight * 0.18,
      decoration: _boxDecoration(darkBrownColor),
      child: Stack(
        children: [
          Positioned(
            top: screenHeight * 0.03,
            left: screenWidth * 0.08,
            child: Text(
              '친구를 초대해보세요',
              style: _textStyle(
                  screenWidth * 0.03, FontWeight.w400, lightMainColor, -0.22),
            ),
          ),
          Positioned(
            top: screenHeight * 0.05,
            left: screenWidth * 0.08,
            child: Text(
              '내 코드',
              style: _textStyle(
                  screenWidth * 0.035, FontWeight.w500, lightMainColor, -0.28),
            ),
          ),
          Positioned(
            top: screenHeight * 0.08,
            right: screenWidth * 0.05,
            child: _svgIcon('assets/icon/logo_basic.svg'),
          ),
          Positioned(
            top: screenHeight * 0.12,
            left: screenWidth * 0.08,
            child: Row(
              children: <Widget>[
                Text(
                  inviteCode,
                  style: _textStyle(screenWidth * 0.05, FontWeight.w600,
                      lightMainColor, -0.4),
                ),
                SizedBox(width: screenWidth * 0.02),
                GestureDetector(
                  onTap: () => _copyToClipboard(inviteCode),
                  child: _svgIcon('assets/icon/copy.svg',
                      width: screenWidth * 0.05, height: screenHeight * 0.03),
                ),
                SizedBox(width: screenWidth * 0.02),
                GestureDetector(
                  onTap: () => _copyToClipboard(inviteCode),
                  child: Text(
                    '복사하기',
                    style: _textStyle(screenWidth * 0.03, FontWeight.w400,
                        lightMainColor, -0.22),
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
      width: screenWidth * 0.85,
      height: screenHeight * 0.18,
      decoration: _boxDecoration(beigeColor),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '친구에게 받은 코드를 입력해주세요',
              style: _textStyle(
                  screenWidth * 0.03, FontWeight.w400, greyColor2, -0.22),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              '친구 코드',
              style: _textStyle(
                  screenWidth * 0.035, FontWeight.w500, greyColor1, -0.28),
            ),
            SizedBox(height: screenHeight * 0.02),
            Container(
              width: double.infinity,
              height: screenHeight * 0.05,
              decoration: _boxDecoration(lightColor2),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: TextField(
                  controller: _codeController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '친구 코드 입력',
                    hintStyle: _textStyle(screenWidth * 0.035, FontWeight.w400,
                        greyColor4, -0.28),
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
