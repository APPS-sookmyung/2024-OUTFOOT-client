import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfoot/colors/colors.dart';
import 'package:dio/dio.dart';
import 'package:outfoot/api/friend_list_check_api.dart';
import 'package:outfoot/models/friend_list_check_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:outfoot/screens/navigation_bar/bottom_navigation_bar.dart';

class FriendList extends StatefulWidget {
  const FriendList({super.key});

  @override
  _FriendListState createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  final FriendService _friendService = FriendService();
  List<Friend> _friendList = [];
  bool _isLoading = true;
  String? token;

  @override
  void initState() {
    super.initState();
    _fetchFriendList();
  }

  Future<void> _fetchFriendList() async {
    token = dotenv.env['TOKEN'];
    if (token == null) {
      debugPrint("Error: TOKEN is not defined in .env");
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      final response = await _friendService.getFriendList(token!);
      setState(() {
        _friendList = response.friendLists;
        _isLoading = false;
      });
      debugPrint('Friend list loaded: ${_friendList.length} friends found.');
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        // 친구 목록이 없을 때 404 오류를 친구 없음 상태로 처리
        setState(() {
          _friendList = []; // 빈 리스트로 설정하여 친구가 없음을 표시
          _isLoading = false;
        });
      } else {
        // 다른 오류 처리
        setState(() {
          _isLoading = false;
        });
        debugPrint('Error fetching friend list: ${e.message}');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      debugPrint('Unexpected error: $error');
    }
  }

  Future<void> _deleteFriend(String friendId) async {
    final token = 'token'; // 실제 토큰 값으로 교체
    try {
      await _friendService.deleteFriend(token, friendId);
      setState(() {
        _friendList.removeWhere((friend) => friend.id == int.parse(friendId));
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('친구가 성공적으로 삭제되었습니다.')),
      );
    } on DioError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('삭제 중 오류가 발생했습니다: ${e.message}')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('예상치 못한 오류가 발생했습니다: $error')),
      );
    }
  }

  TextStyle _textStyle(double fontSize, FontWeight fontWeight, Color color,
      double height, double letterSpacing) {
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
          '친구 목록',
          style: _textStyle(16, FontWeight.w600, greyColor1, 0.8, -0.28),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: lightColor1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Text(
                      '총 ${_friendList.length}명',
                      style: _textStyle(
                          14.0, FontWeight.w400, greyColor3, 0.8, -0.28),
                    ),
                    SizedBox(height: 8.0),
                    Expanded(
                      child: ListView.builder(
                        itemCount: _friendList.length,
                        itemBuilder: (context, index) {
                          final friend = _friendList[index];
                          return Container(
                            width: 320.0,
                            height: 88.0,
                            margin: EdgeInsets.only(bottom: 10.0),
                            padding: EdgeInsets.symmetric(
                                vertical: 13.0, horizontal: 19.0),
                            decoration: _boxDecoration(lightColor2),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 61.0,
                                  height: 61.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: yellowColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      friend.nickname.isNotEmpty
                                          ? friend.nickname[0]
                                          : '친구',
                                      style: _textStyle(20.0, FontWeight.w600,
                                          greyColor1, 0.8, -0.4),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            friend.nickname,
                                            style: _textStyle(
                                                16.0,
                                                FontWeight.w500,
                                                greyColor1,
                                                0.8,
                                                -0.32),
                                          ),
                                          SizedBox(width: 8.0),
                                          _svgIcon('assets/icon/next_arrow.svg',
                                              width: 20.0, height: 20.0),
                                        ],
                                      ),
                                      SizedBox(height: 5.0),
                                      Text(
                                        friend.intro.isNotEmpty
                                            ? friend.intro
                                            : '소개글이 없습니다',
                                        style: _textStyle(12.0, FontWeight.w400,
                                            greyColor2, 1.1, -0.22),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 16.0),
                                Container(
                                  width: 49.0,
                                  height: 30.0,
                                  decoration: _boxDecoration(lightMainColor),
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size(49.0, 30.0),
                                      alignment: Alignment.center,
                                    ),
                                    onPressed: () => _deleteFriend(
                                        friend.id.toString()), // 삭제 동작
                                    child: Text(
                                      '삭제',
                                      style: _textStyle(
                                        14.0,
                                        FontWeight.w400,
                                        redColor,
                                        1.3, // 줄 간격 조정
                                        -0.28,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: 2),
    );
  }
}
