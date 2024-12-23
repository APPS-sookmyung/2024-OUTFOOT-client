import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfoot/api/add_friend_api.dart';
import 'package:outfoot/colors/colors.dart';
import 'package:outfoot/models/add_friend_model.dart';

class AddFriendPopup extends StatefulWidget {
  const AddFriendPopup({Key? key}) : super(key: key);

  @override
  _AddFriendPopupState createState() => _AddFriendPopupState();
}

class _AddFriendPopupState extends State<AddFriendPopup> {
  final TextEditingController _codeController = TextEditingController();
  final AddFriendApi _addFriend = AddFriendApi();
  bool _isAdding = false;

  Future<void> _onAddFriend() async {
    final friendCode = _codeController.text.trim();
    final token = 'token'; // 인증 토큰 제공

    if (friendCode.isEmpty) {
      _showPopup('친구 코드를 입력해주세요.');
      return;
    }

    setState(() {
      _isAdding = true;
    });

    try {
      final FriendResponse response =
          await _addFriend.inviteCode(friendCode, token);

      String message = response.message;
      if (response.status == '400') {
        switch (response.errorCode) {
          case 'NOT_FRIEND_SELF':
            message = "자기 자신을 친구로 추가할 수 없습니다.";
            break;
          case 'MEMBER_NOT_FOUND':
            message = "존재하지 않는 회원입니다.";
            break;
          case 'FRIEND_DUPLICATED':
            message = "이미 존재하는 친구입니다.";
            break;
          default:
            message = response.message;
        }
      }

      _showPopup(message);
    } catch (e) {
      _showPopup('오류가 발생했습니다: $e');
    } finally {
      setState(() {
        _isAdding = false;
      });
    }
  }

  void _showPopup(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Center(
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: _textStyle(16.0, FontWeight.w400, greyColor2, 0.8, -0.32),
            ),
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                child: Text(
                  '닫기',
                  style: _textStyle(
                      16.0, FontWeight.w600, mainBrownColor, 0.8, -0.32),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  TextStyle _textStyle(double fontSize, FontWeight fontWeight, Color color,
      double height, double letterSpacing) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: 'Pretendard',
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

  Widget _svgIcon(String assetName,
      {double? width, double? height, BoxFit fit = BoxFit.none}) {
    return SvgPicture.asset(
      assetName,
      width: width,
      height: height,
      fit: fit,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor1,
      appBar: AppBar(
        backgroundColor: lightColor1,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: _svgIcon('assets/icon/before_arrow.svg',
              width: 17.0, height: 8.0),
        ),
        centerTitle: true,
        title: Text(
          '친구 추가하기',
          style: _textStyle(16.0, FontWeight.w600, greyColor1, 0.8, -0.32),
        ),
      ),
      body: _isAdding
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 24.0),
                    Text(
                      '내 코드 공유하기',
                      style: _textStyle(
                          14.0, FontWeight.w500, greyColor1, 1.2, -0.28),
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      width: 320.0,
                      padding: const EdgeInsets.all(16.0),
                      decoration: _boxDecoration(beigeColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '친구에게 받은 코드를 입력하세요.',
                            style: _textStyle(
                                12.0, FontWeight.w400, greyColor2, 0.8, -0.22),
                          ),
                          const SizedBox(height: 8.0),
                          TextField(
                            controller: _codeController,
                            decoration: InputDecoration(
                              hintText: '친구 코드 입력',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: _onAddFriend,
                      child: Container(
                        width: 320.0,
                        height: 50.0,
                        alignment: Alignment.center,
                        decoration: _boxDecoration(mainBrownColor),
                        child: Text(
                          '추가하기',
                          style: _textStyle(16.0, FontWeight.w600,
                              lightMainColor, 0.8, -0.28),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
