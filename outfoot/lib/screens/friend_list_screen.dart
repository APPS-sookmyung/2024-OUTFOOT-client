import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfoot/colors/colors.dart';
import 'package:dio/dio.dart';
import 'package:outfoot/api/friend_list_check_api.dart';
import 'package:outfoot/models/friend_list_check_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:outfoot/screens/navigation_bar/bottom_navigation_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outfoot/services/data/friendlist_data.dart';

class FriendList extends StatefulWidget {
  const FriendList({super.key});

  @override
  _FriendListState createState() => _FriendListState();
}

final List<FriendlistData> dataList = [
  FriendlistData("이해림", "플러터 같이 공유해요"),
  FriendlistData("정서연", "귤 드세요"),
  FriendlistData("Sam Kim", "hello everyone"),
];

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
            width: 17.375.w,
            height: 18.688.h,
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
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20.0.h),
                    Text(
                      // '총 ${_friendList.length}명',
                      '총 5명',
                      style: _textStyle(
                          14.0, FontWeight.w400, greyColor3, 0.8, -0.28),
                    ),
                    SizedBox(height: 8.0.h),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  final friends = [
                    {'name': '정서연', 'intro': '안녕하세요 OUTFOOT PM입니다'},
                    {'name': '이해림', 'intro': '안녕하세요 OUTFOOT FE입니다'},
                    {'name': '이지은', 'intro': '안녕하세요 OUTFOOT BE입니다'},
                    {'name': '주아정', 'intro': '안녕하세요 OUTFOOT BE입니다'},
                    {'name': '윤현서', 'intro': '안녕하세요 OUTFOOT BE입니다'}
                  ];

                  final friend = friends[index];
                  final initials = friend['name']![0];

                  return Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 10.0.h),
                    padding: EdgeInsets.symmetric(
                        vertical: 13.0.h, horizontal: 19.0.w),
                    decoration: _boxDecoration(Colors.white),
                    child: Row(
                      children: [
                        Container(
                          width: 48.0.w,
                          height: 48.0.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: index == 0
                                ? Colors.yellow[100]
                                : index == 1
                                    ? Colors.brown[200]
                                    : Colors.brown[300],
                          ),
                          child: Center(
                            child: Text(
                              initials,
                              style: _textStyle(16, FontWeight.w600, Colors.black, 1.2, -0.4),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                friend['name']!,
                                style: _textStyle(16, FontWeight.w500, Colors.black, 1.2, -0.32),
                              ),
                              SizedBox(height: 4.0.h),
                              Text(
                                friend['intro']!,
                                style: _textStyle(12, FontWeight.w400, Colors.grey, 1.2, -0.22),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16.0.w),
                        Container(
                          width: 60.0.w,
                          height: 30.0.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0.r),
                            border: Border.all(color: Colors.red),
                          ),
                          child: Center(
                            child: Text(
                              '삭제',
                              style: _textStyle(14, FontWeight.w400, Colors.red, 1.2, -0.28),
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
