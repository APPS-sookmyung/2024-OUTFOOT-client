import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Color(0xFFDFDFDF)
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

class CheckpagePhotodetailMemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFEFD),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.only(left: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 19.64, vertical: 20.37),
                      decoration: BoxDecoration(
                        color: Color(0xFFC8AA9B),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          '문',
                          style: TextStyle(
                            fontSize: 13.834,
                            color: Color(0xFFFFFFFF),
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
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 11),
                                  child: Text(
                                    '문서영',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF3E3E3E),
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w500,
                                      height: 1.1,
                                      letterSpacing: -0.22,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5.5),
                                Text(
                                  '안뇽하세요 반가워요 안ㄴ...',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF3E3E3E),
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                    height: 1.1,
                                    letterSpacing: -0.24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          Padding(
                            padding: EdgeInsets.only(top: 11),
                            child: Container(
                              width: 100,
                              height: 40,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xFFC8AA9B),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  '프로필 보기',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFFFFFFFF),
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                    height: 1.1,
                                    letterSpacing: -0.24,
                                  ),
                                ),
                              ),
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
                  Container(
                    width: double.infinity,
                    height: 212,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/your_image.jpg'), // 갤러리에서 가져온 이미지
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Container(
                      width: 319.921,
                      height: 212.283,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF3E3E3E).withOpacity(0.5),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 35.0, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.83, vertical: 5.7),
                          decoration: BoxDecoration(
                            color: Color(0xFFFAF7F0).withOpacity(1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '24.03.31',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF5B411C),
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              height: 1.1,
                              letterSpacing: -0.22,
                            ),
                          ),
                        ),
                        SizedBox(height: 18.76),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '하루에 물 2리터 마시기',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF5B411C),
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
                                  color: Color(0xFFFFEAA5),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.63),
                        Text(
                          '건강한 이너뷰티',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF8B8B8B),
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            height: 1.1,
                            letterSpacing: -0.24,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 190, top: 60),
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
                                SvgPicture.asset(
                                  'assets/admit.svg',
                                  width: 10,
                                  height: 14,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '15',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFFFFFFFF),
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500,
                                    height: 1.1,
                                    letterSpacing: -0.24,
                                  ),
                                ),
                                SizedBox(width: 10),
                                SvgPicture.asset(
                                  'assets/no_admit.svg',
                                  width: 10,
                                  height: 14,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '1',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFFFFFFFF),
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
                    color: Color(0xFFFAF7F0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 19.91, left: 16.5, right:170),
                        child: Text(
                          '오늘도 뿌듯한 하루~~',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF3E3E3E),
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
                              hintText: '마치 하마가 된 거 같고, 뿌듯함ㅋㅋ',
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF3E3E3E),
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
                          '24.03.31 작성됨',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFFC8AA9B),
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
                padding: EdgeInsets.only(left:20),
                child: CustomPaint(
                  painter: DashedLinePainter(),
                  size: Size(320, 0),
                ),
              ),
              SizedBox(height: 29),
              Padding(
                padding: EdgeInsets.only(left:20),
                child:Text(
                  '댓글 4개',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF3E3E3E),
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                    height: 1.1,
                    letterSpacing: -0.28,
                  ),
                ),
              ),
              SizedBox(height: 11),
              Padding(
                padding: EdgeInsets.only(left:20),
                child: Container(
                  width: 319.921,
                  height: 71.224,
                  decoration: BoxDecoration(
                    color: Color(0xFFFAF7F0),
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
                                      '물 먹는 하마',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF3E3E3E),
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w500,
                                        height: 1.1,
                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 7),
                                  Text(
                                    '03/31 14:29',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFFA4A4A4),
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
                                '저까지 뿌듯해지는 인증샷이네여 멋져요!',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF3E3E3E),
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
              Padding(
                padding: EdgeInsets.only(left:20),
                child: Container(
                  width: 319.921,
                  height: 71.224,
                  decoration: BoxDecoration(
                    color: Color(0xFFFAF7F0),
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
                                      '밥 먹는 사람',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF3E3E3E),
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w500,
                                        height: 1.1,
                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 7),
                                  Text(
                                    '03/31 14:29',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFFA4A4A4),
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
                                '저도 갑자기 밥이 먹고싶어지는 거 같습니다~!',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF3E3E3E),
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
              Padding(
                padding: EdgeInsets.only(left:20),
                child: Container(
                  width: 319.921,
                  height: 71.224,
                  decoration: BoxDecoration(
                    color: Color(0xFFFAF7F0),
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
                                      '강호동',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF3E3E3E),
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w500,
                                        height: 1.1,
                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 7),
                                  Text(
                                    '03/31 14:29',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFFA4A4A4),
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
                                '와우 나도 얼른 라면 먹으러 가야겠다',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF3E3E3E),
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
              Padding(
                padding: EdgeInsets.only(left:20),
                child: Container(
                  width: 319.921,
                  height: 71.224,
                  decoration: BoxDecoration(
                    color: Color(0xFFFAF7F0),
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
                                      '용산구 카리나',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xFF3E3E3E),
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w500,
                                        height: 1.1,
                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 7),
                                  Text(
                                    '03/31 14:29',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFFA4A4A4),
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
                                '물 마시는 거 진짜 중요한건데 넘 굿굿이네요~~ '
                                + '    화이팅 제가 응원할게요',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF3E3E3E),
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
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CheckpagePhotodetailMemo(),
  ));
}
