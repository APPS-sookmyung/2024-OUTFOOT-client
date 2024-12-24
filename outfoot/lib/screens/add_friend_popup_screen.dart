import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfoot/api/add_friend_api.dart';
import 'package:outfoot/colors/colors.dart';
import 'package:outfoot/screens/navigation_bar/bottom_navigation_bar.dart';
import 'package:outfoot/api/add_friend_api.dart';

class AddFriendPopup extends StatefulWidget {
  final String memberId;
  final String token;

  const AddFriendPopup(
      {required this.memberId, required this.token, super.key});

  @override
  _AddFriendPopupState createState() => _AddFriendPopupState();
}

class _AddFriendPopupState extends State<AddFriendPopup> {
  final TextEditingController _codeController = TextEditingController();
  final FriendService _friendService = FriendService();
  String? _inviteCode;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchInviteCode();
  }

  TextStyle _textStyle(double fontSize, FontWeight fontWeight, Color color,
      double letterSpacing) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: 'Pretendard',
      fontWeight: fontWeight,
      color: color,
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

  void _fetchInviteCode() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final inviteCode = await _friendService.fetchInviteCode(widget.token);
      setState(() {
        _inviteCode = inviteCode ?? "코드를 불러올 수 없습니다.";
      });
    } catch (e) {
      print("초대 코드 가져오기 실패: $e");
      setState(() {
        _inviteCode = "코드를 불러올 수 없습니다.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _addFriend() async {
    final code = _codeController.text.trim();
    if (code.isEmpty) {
      _showPopup(context, "코드를 입력해주세요.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final response =
        await _friendService.addFriend(widget.memberId, code, widget.token);
    print("addFriend 메서드 반환값: $response");

    setState(() {
      _isLoading = false;
    });

    switch (response) {
      case "200":
        _showPopup(context, "친구 추가에 성공하였습니다!");
        break;
      case "400_self":
        _showPopup(context, "자기 자신은 친구로 추가할 수 없습니다.");
        break;
      case "400_not_exist":
        _showPopup(context, "존재하지 않는 친구 코드입니다.");
        break;
      case "400_already_friend":
        _showPopup(context, "이미 추가된 친구입니다.");
        break;
      case "400_unknown":
        _showPopup(context, "알 수 없는 오류가 발생했습니다. 다시 시도해주세요.");
        break;
      default:
        _showPopup(context, "네트워크 오류가 발생했습니다. 다시 시도해주세요.");
    }
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
            width: 17.375,
            height: 18.688,
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
          padding: const EdgeInsets.only(left: 27.0, top: 27),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '내 코드 공유하기',
                    style: _textStyle(14.0, FontWeight.w500, greyColor1, -0.28),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '내 코드를 공유해 친구를 초대하세요',
                      style:
                          _textStyle(11.0, FontWeight.w400, greyColor2, -0.22),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              _buildInviteCodeCard(screenWidth, screenHeight),
              SizedBox(height: 16),
              Center(
                child: SvgPicture.asset(
                  'assets/arrow.svg',
                  width: screenWidth * 0.05,
                  height: screenHeight * 0.03,
                ),
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '친구 추가하기',
                    style: _textStyle(14.0, FontWeight.w500, greyColor1, -0.28),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '추가할 친구 코드를 입력하세요',
                      style:
                          _textStyle(11.0, FontWeight.w400, greyColor2, -0.22),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              _buildFriendCodeInput(screenWidth, screenHeight),
              SizedBox(height: 16),
              GestureDetector(
                onTap: _isLoading ? null : _addFriend,
                child: Container(
                  width: screenWidth * 0.85,
                  height: screenHeight * 0.06,
                  decoration: BoxDecoration(
                    color: mainBrownColor,
                    borderRadius: BorderRadius.circular(10.0),
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
              children: [
                Text(
                  _inviteCode ?? 'A29NB67',
                  style:
                      _textStyle(20.0, FontWeight.w600, lightMainColor, -0.4),
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
              style: _textStyle(11.0, FontWeight.w400, greyColor2, -0.22),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              '친구 코드',
              style: _textStyle(14.0, FontWeight.w500, greyColor1, -0.28),
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
                    hintStyle:
                        _textStyle(12.0, FontWeight.w400, greyColor4, -0.28),
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
