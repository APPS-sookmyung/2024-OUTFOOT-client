import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:outfoot/colors/colors.dart';
import 'package:outfoot/api/auth_addition_api.dart';
import 'package:outfoot/screens/navigation_bar/bottom_navigation_bar.dart';
import 'package:outfoot/utils/goal_provider.dart' as utils_goal_provider;
import 'package:provider/provider.dart';
import 'package:outfoot/screens/navigation_bar/material_top_navigation_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outfoot/services/data/upload_data.dart';

// 이동 페이지
import 'package:outfoot/screens/checkpage_photodetail_memo.dart';

class DashedBorder extends StatelessWidget {
  final Widget child;

  DashedBorder({required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedPainter(),
      child: child,
    );
  }
}

class DashedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Color(0xFFF3E7C9)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    var dashWidth = 5.0;
    var dashSpace = 5.0;

    var path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(10),
      ));

    var pathMetrics = path.computeMetrics();
    for (var pathMetric in pathMetrics) {
      var distance = 0.0;
      while (distance < pathMetric.length) {
        var segment = pathMetric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(segment, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = greyColor9
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

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

final Data = UploadData("24.12.27", "하루에 물 2리터 마시기", "건강한 이너뷰티");

class _UploadState extends State<Upload> {
  final AuthAdditionApi _api = AuthAdditionApi();
  final TextEditingController _titleController =
      TextEditingController(text: "");
  final TextEditingController _contentController = TextEditingController();
  File? _image;

  @override
  void initState() {
    super.initState();
    _titleController.text = "";
    _contentController.text = "";
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final goalProvider =
          Provider.of<utils_goal_provider.GoalProvider>(context, listen: false);
      _titleController.text = goalProvider.contentTitle;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _submitGoal() async {
    if (_titleController.text.isEmpty ||
        _contentController.text.isEmpty ||
        _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('제목, 내용, 이미지를 모두 입력해주세요.')),
      );
      return;
    }

    final goalProvider =
        Provider.of<utils_goal_provider.GoalProvider>(context, listen: false);
    goalProvider.updateContentTitle(_titleController.text); // contentTitle 업데이트
    goalProvider.updateContent(_contentController.text); // content 업데이트

    String token = 'your_token_here'; // 실제 토큰 값으로 대체
    String checkPageId = 'your_check_page_id_here'; // 실제 체크 페이지 ID로 대체

    String result = await _api.postGoal(
      token,
      checkPageId,
      _titleController.text,
      _contentController.text,
      _image!.path, // 선택된 이미지 파일 경로
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result)),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CheckpagePhotodetailMemo(
          token: token,
          confirmId: '1',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: lightColor1,
        extendBodyBehindAppBar: false,
        appBar: MeterialTopNavigationBar(checkPageId: 1),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0.w),
            child: Consumer<utils_goal_provider.GoalProvider>(
              builder: (context, goalProvider, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.83.w, vertical: 5.7.h),
                        decoration: BoxDecoration(
                          color: lightColor2,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          // goalProvider.date,
                          Data.date,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: blackBrownColor,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            height: 1.1,
                            letterSpacing: -0.22,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 18.76.h),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            // goalProvider.title,
                            Data.title,
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: blackBrownColor,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              height: 1.1,
                              letterSpacing: -0.36,
                            ),
                          ),
                          SizedBox(width: 3.69.w),
                          Transform.translate(
                            offset: Offset(0, -9.0.h),
                            child: Container(
                              width: 7.991.w,
                              height: 7.991.h,
                              decoration: BoxDecoration(
                                color: yellowColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.63.h),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Text(
                        // goalProvider.intro,
                        Data.intro,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: greyColor3,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                          height: 1.1,
                          letterSpacing: -0.24,
                        ),
                      ),
                    ),
                    SizedBox(height: 22.42.h),
                    Padding(
                      padding: EdgeInsets.only(left: 20.3.w, right: 19.8.w),
                      child: Container(
                        width: 319.921.w,
                        height: 212.283.h,
                        decoration: BoxDecoration(
                          color: beigeColor,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: DashedBorder(
                          child: _image == null
                              ? InkWell(
                                  onTap: _pickImage,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/floating_action.svg',
                                        width: 37.099.w,
                                        height: 37.099.h,
                                      ),
                                      SizedBox(height: 14.46.h),
                                      Text(
                                        '사진 추가',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: mainBrownColor,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                          height: 1.1,
                                          letterSpacing: -0.28,
                                        ),
                                      ),
                                      SizedBox(height: 7.23.h),
                                      Text(
                                        '인증 사진을 추가해주세요',
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: greyColor3,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w400,
                                          height: 1.1,
                                          letterSpacing: -0.22,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Image.file(
                                    _image!,
                                    fit: BoxFit.cover,
                                    width: 319.921.w,
                                    height: 212.283.h,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.41.h),
                    Padding(
                      padding: EdgeInsets.only(right: 15.w),
                      child: Row(
                        children: [
                          Expanded(child: SizedBox()), // 좌측 공간 확보
                          SvgPicture.asset(
                            'assets/arrow.svg',
                            width: 17.375.w,
                            height: 17.375.h,
                          ),
                          Expanded(child: SizedBox()), // 우측 공간 확보
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Padding(
                      padding: EdgeInsets.only(left: 20.3.w, right: 19.8.w),
                      child: Container(
                        width: 319.921.w,
                        height: 189.h,
                        decoration: BoxDecoration(
                          color: lightColor2,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 5.h, left: 21.67.w, right: 190.w),
                              child: TextField(
                                controller: _titleController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText:
                                      '제목을 입력하세요', // GoalProvider와 분리된 hintText
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    fontSize: 14.sp,
                                    color: greyColor3,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                    height: 1.1,
                                    letterSpacing: -0.28,
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: greyColor1,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  height: 1.1,
                                  letterSpacing: -0.28,
                                ),
                              ),
                            ),
                            Container(
                              width: 294.058.w,
                              height: 0.h,
                              child: CustomPaint(
                                painter: DashedLinePainter(),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 21.67.w),
                              child: Container(
                                height: 104.h,
                                child: TextField(
                                  controller: _contentController,
                                  maxLength: 50,
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    counterText: "",
                                    hintText: '내용을 입력하세요 (최대 50자 작성 가능)',
                                    hintStyle: TextStyle(
                                      fontSize: 12.sp,
                                      color: greyColor3,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w400,
                                      height: 1.1,
                                      letterSpacing: -0.24,
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: greyColor1,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                    height: 1.1,
                                    letterSpacing: -0.24,
                                  ),
                                  onChanged: (_) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(bottom: 15.h, right: 10.w),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  // '${_contentController.text.length}/50',
                                  " ",
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: mainBrownColor,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.22,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 41.8.h),
                    Padding(
                      padding: EdgeInsets.only(left: 267.w, right: 20.82.w),
                      child: GestureDetector(
                        onTap: _submitGoal,
                        child: Container(
                          width: 71.321.w,
                          height: 30.149.h,
                          decoration: BoxDecoration(
                            color: mainBrownColor,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Center(
                            child: Text(
                              '완료',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                                height: 1.1,
                                letterSpacing: -0.24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: 1),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Upload(),
  ));
}
