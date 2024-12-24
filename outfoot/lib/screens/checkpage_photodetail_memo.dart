import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:outfoot/colors/colors.dart';
import 'package:outfoot/api/like_post_api.dart';
import 'package:outfoot/api/like_delete_api.dart';
import 'package:outfoot/api/dislike_post_api.dart';
import 'package:outfoot/api/dislike_delete_api.dart';
import 'package:outfoot/screens/navigation_bar/comment_bottom_navigation_bar.dart';
import 'package:outfoot/screens/navigation_bar/auth_top_navigation_bar.dart';
import 'package:outfoot/services/data/memo_data.dart';
import 'package:outfoot/utils/goal_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = greyColor7
      ..strokeWidth = 0.7
      ..style = PaintingStyle.stroke;

    var dashWidth = 5.0;
    var dashSpace = 3.0;
    var startX = 0.0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

final Data = MemoData("정지원", "안녕하세요 만나서 반가워요", "24.12.26", "하루에 물 2리터 마시기", "건강한 이너뷰티", "오늘도 뿌듯한 하루~~", "마치 하마가 된 거 같고, 뿌듯함ㅋㅋ", "24.12.26 작성됨");
final List<CommentData>dataList = [
  CommentData("이해림", "12/26 14:29", "저까지 뿌듯해지는 인증샷입니다!"),
  CommentData("정서연", "12/26 14:39", "나도 도전할게게"),
  CommentData("Sam Kim", "12/26 16:12", "NICE"),
  CommentData("Sam Kim", "12/26 16:13", "Good"),
];

class CheckpagePhotodetailMemo extends StatefulWidget {
  final String token;
  final String confirmId;

  CheckpagePhotodetailMemo({required this.token, required this.confirmId});

  @override
  _CheckpagePhotodetailMemoState createState() =>
      _CheckpagePhotodetailMemoState();
}

class _CheckpagePhotodetailMemoState extends State<CheckpagePhotodetailMemo> {
  int likeCount = 0;
  int dislikeCount = 0;
  bool isLiked = false;
  bool isDisliked = false;
  bool isLoading = true;

  final DislikePostApi dislikePostApi = DislikePostApi();
  final DislikeDeleteApi dislikeDeleteApi = DislikeDeleteApi();
  final LikePostApi likePostApi = LikePostApi();
  final LikeDeleteApi likeDeleteApi = LikeDeleteApi();

  @override
  void initState() {
    super.initState();
    fetchGoal(widget.token, widget.confirmId).then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> fetchGoal(String token, String id) async {
    final String? baseUrl = dotenv.env['BASE_URL'];

    try {
      final response = await Dio().get(
        '$baseUrl/confirm/$id',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        setState(() {
          likeCount = data['likeCount'] ?? 0;
          dislikeCount = data['dislikeCount'] ?? 0;
          isLiked = data['isLiked'] ?? false;
          isDisliked = data['isDisliked'] ?? false;
        });

        // Update GoalProvider
        final goalProvider = Provider.of<GoalProvider>(context, listen: false);
        goalProvider.updateGoal(Data.title ?? '기본 목표 제목',
            Data.intro ?? '기본 목표 설명', data['imageUrl'] ?? '');
        goalProvider.updateDate( Data.date1 ?? '24.01.01');
      } else {
        throw Exception('Failed to fetch goal data');
      }
    } catch (e) {
      print('Error fetching goal data: $e');
    }
  }

  Future<void> toggleLike() async {
    if (isLiked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('이미 좋아요를 눌렀습니다.')),
      );
      return;
    }

    try {
      if (isDisliked) {
        await dislikeDeleteApi
            .deleteDislikeConfirm(int.parse(widget.confirmId));
        setState(() {
          dislikeCount--;
          isDisliked = false;
        });
      }

      await likePostApi.PostLikeConfirm(int.parse(widget.confirmId));
      setState(() {
        likeCount++;
        isLiked = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('좋아요를 눌렀습니다.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('좋아요 요청에 실패했습니다.')),
      );
      print('좋아요 동기화 오류: $e');
    }
  }

  Future<void> toggleDislike() async {
    if (isDisliked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('이미 싫어요를 눌렀습니다.')),
      );
      return;
    }

    try {
      if (isLiked) {
        await likeDeleteApi.deleteLikeConfirm(int.parse(widget.confirmId));
        setState(() {
          likeCount--;
          isLiked = false;
        });
      }

      await dislikePostApi.PostDislikeConfirm(int.parse(widget.confirmId));
      setState(() {
        dislikeCount++;
        isDisliked = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('싫어요를 눌렀습니다.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('싫어요 요청에 실패했습니다.')),
      );
      print('싫어요 동기화 오류: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final goalProvider = Provider.of<GoalProvider>(context);

    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AuthTopNavigationBar(checkPageId: 1),
      backgroundColor: lightColor1,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
              // 기존 UI 유지
              Padding(
                padding: EdgeInsets.only(left: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 19.64,
                        vertical: 20.37,
                      ),
                      decoration: BoxDecoration(
                        color: mainBrownColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          (Data.name)[0],
                          style: TextStyle(
                            fontSize: 13.834,
                            color: Colors.white,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            height: 1.1,
                            letterSpacing: -0.277,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 17.03),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 11),
                            child: Text(
                              Data.name,
                              style: TextStyle(
                                fontSize: 14,
                                color: greyColor1,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                height: 1.1,
                                letterSpacing: -0.22,
                              ),
                            ),
                          ),
                          SizedBox(height: 5.5),
                          Text(
                            goalProvider.content.isNotEmpty
                                ? goalProvider.content
                                : Data.myintro,
                            style: TextStyle(
                              fontSize: 12,
                              color: greyColor1,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              height: 1.1,
                              letterSpacing: -0.24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Stack(
                children: [
                  // 이미지
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 320,
                      height: 212,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: goalProvider.isAssetImage ||
                                  (goalProvider.imagePath?.isEmpty ?? true)
                              ? AssetImage('assets/testImg.png')
                                  as ImageProvider<Object>
                              : NetworkImage(goalProvider.imagePath!),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  // 회색 그라데이션 박스
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 320,
                      height: 212,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            greyColor1.withOpacity(0.5),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  // 텍스트
                  Padding(
                    padding: EdgeInsets.only(left: 35.0, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 날짜
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.83, vertical: 5.7),
                          decoration: BoxDecoration(
                            color: lightColor2.withOpacity(1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            goalProvider.date.isNotEmpty
                                ? goalProvider.date
                                : Data.date1,
                            style: TextStyle(
                              fontSize: 11,
                              color: blackBrownColor,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              height: 1.1,
                              letterSpacing: -0.22,
                            ),
                          ),
                        ),
                        SizedBox(height: 18.76),
                        // 제목
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              goalProvider.title.isNotEmpty
                                  ? goalProvider.title
                                  : Data.title,
                              style: TextStyle(
                                fontSize: 18,
                                color: yellowColor2,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                                height: 1.1,
                                letterSpacing: -0.36,
                              ),
                            ),
                            SizedBox(width: 3.69),
                            Transform.translate(
                              offset: Offset(0, -9.0),
                              child: Container(
                                width: 7.991,
                                height: 7.991,
                                decoration: BoxDecoration(
                                  color: yellowColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.63),
                        // 내용
                        Text(
                          goalProvider.content.isNotEmpty
                              ? goalProvider.intro
                              : Data.intro,
                          style: TextStyle(
                            fontSize: 12,
                            color: greyColor3,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            height: 1.1,
                            letterSpacing: -0.24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 좋아요/싫어요 박스
                  Positioned(
                    left: 200,
                    top: 165,
                    child: Container(
                      width: 98.774,
                      height: 28.871,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(51, 42, 42, 42),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: toggleLike,
                            child: SvgPicture.asset(
                              'assets/admit.svg',
                              width: 10,
                              height: 14,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '$likeCount',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 1.1,
                              letterSpacing: -0.24,
                            ),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: toggleDislike,
                            child: SvgPicture.asset(
                              'assets/no_admit.svg',
                              width: 10,
                              height: 14,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '$dislikeCount',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 1.1,
                              letterSpacing: -0.24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.only(left: 20.3, right: 19.8),
                child: Container(
                  width: 319.921,
                  height: 150.685,
                  decoration: BoxDecoration(
                    color: lightColor2,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: 19.91, left: 16.5, right: 170),
                        child: Text(
                          goalProvider.contentTitle.isNotEmpty
                              ? goalProvider.contentTitle
                              : Data.content1,
                          style: TextStyle(
                            fontSize: 14,
                            color: greyColor1,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            height: 1.1,
                            letterSpacing: -0.28,
                          ),
                        ),
                      ),
                      SizedBox(height: 14),
                      Container(
                        width: 294.058,
                        height: 0,
                        child: CustomPaint(
                          painter: DashedLinePainter(),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 2, left: 21.67),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: goalProvider.content.isNotEmpty
                                  ? goalProvider.content
                                  : Data.content2,
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: greyColor1,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400,
                                height: 1.1,
                                letterSpacing: -0.24,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15, left: 228),
                        child: Text(
                          goalProvider.date.isNotEmpty
                              ? goalProvider.date
                              : Data.date1 + '작성됨',
                          style: TextStyle(
                            fontSize: 11,
                            color: mainBrownColor,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            letterSpacing: -0.22,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: CustomPaint(
                  painter: DashedLinePainter(),
                  size: Size(320, 0),
                ),
              ),
              SizedBox(height: 29),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  '댓글 4개',
                  style: TextStyle(
                    fontSize: 14,
                    color: greyColor1,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                    height: 1.1,
                    letterSpacing: -0.28,
                  ),
                ),
              ),
              SizedBox(height: 11),
// 댓글 리스트
              // 첫 번째 댓글
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Container(
                  width: 319.921,
                  height: 71.224,
                  decoration: BoxDecoration(
                    color: lightColor2,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.only(left: 20.3, right: 19.8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Transform.translate(
                          offset: Offset(-15, -17),
                          child: SvgPicture.asset(
                            'assets/paw_another.svg',
                            width: 16,
                            height: 16,
                          ),
                        ),
                        SizedBox(width: 0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      dataList[0].nickname,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: greyColor1,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w500,
                                        height: 1.1,
                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 7),
                                  Text(
                                    dataList[0].date,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: greyColor4,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w400,
                                      height: 1.1,
                                      letterSpacing: -0.22,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Text(
                                dataList[0].comment,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: greyColor1,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  height: 1.1,
                                  letterSpacing: -0.24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 11),

// 두 번째 댓글
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Container(
                  width: 319.921,
                  height: 71.224,
                  decoration: BoxDecoration(
                    color: lightColor2,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.only(left: 20.3, right: 19.8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Transform.translate(
                          offset: Offset(-15, -17),
                          child: SvgPicture.asset(
                            'assets/paw_another.svg',
                            width: 16,
                            height: 16,
                          ),
                        ),
                        SizedBox(width: 0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      dataList[1].nickname,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: greyColor1,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w500,
                                        height: 1.1,
                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 7),
                                  Text(
                                    dataList[1].date,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: greyColor4,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w400,
                                      height: 1.1,
                                      letterSpacing: -0.22,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Text(
                                dataList[1].comment,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: greyColor1,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  height: 1.1,
                                  letterSpacing: -0.24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 11),

// 세 번째 댓글
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Container(
                  width: 319.921,
                  height: 71.224,
                  decoration: BoxDecoration(
                    color: lightColor2,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.only(left: 20.3, right: 19.8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Transform.translate(
                          offset: Offset(-15, -17),
                          child: SvgPicture.asset(
                            'assets/paw_another.svg',
                            width: 16,
                            height: 16,
                          ),
                        ),
                        SizedBox(width: 0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      dataList[2].nickname,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: greyColor1,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w500,
                                        height: 1.1,
                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 7),
                                  Text(
                                    dataList[2].date,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: greyColor4,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w400,
                                      height: 1.1,
                                      letterSpacing: -0.22,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Text(
                                dataList[2].comment,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: greyColor1,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  height: 1.1,
                                  letterSpacing: -0.24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 11),

// 네 번째 댓글
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Container(
                  width: 319.921,
                  height: 71.224,
                  decoration: BoxDecoration(
                    color: lightColor2,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.only(left: 20.3, right: 19.8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Transform.translate(
                          offset: Offset(-15, -17),
                          child: SvgPicture.asset(
                            'assets/paw_another.svg',
                            width: 16,
                            height: 16,
                          ),
                        ),
                        SizedBox(width: 0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      dataList[3].nickname,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: greyColor1,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w500,
                                        height: 1.1,
                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 7),
                                  Text(
                                    dataList[3].date,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: greyColor4,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w400,
                                      height: 1.1,
                                      letterSpacing: -0.22,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Text(
                                dataList[3].comment,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: greyColor1,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  height: 1.1,
                                  letterSpacing: -0.24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CommentBottomNavigationBar(),
    );
  }
}
