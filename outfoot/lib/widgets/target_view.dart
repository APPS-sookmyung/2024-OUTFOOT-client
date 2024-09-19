import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProgressCard extends StatelessWidget {
  final String startDate;
  final String title;
  final double progressPercentage;
  final String assetPath;

  const ProgressCard({
    Key? key,
    required this.startDate,
    required this.title,
    required this.progressPercentage,
    this.assetPath = '', // 기본값을 빈 문자열로 설정
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '시작일 $startDate',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFFA4A4A4),
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w400,
                height: 1.1,
                letterSpacing: -0.24,
              ),
            ),
            SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF4A4A4A),
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
                height: 1.1,
                letterSpacing: -0.32,
              ),
            ),
            SizedBox(height: 12),
            // 진행상황 바
            Stack(
              children: [
                Container(
                  width: 275,
                  height: 6.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFDFDFDF),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Container(
                  width: 275 * (progressPercentage / 100), // 퍼센트에 맞춰 너비 조절
                  height: 6.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFC8AA9B),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '완성도 ${progressPercentage.toStringAsFixed(0)}% 완성 중',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFFA4A4A4),
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                  height: 1.1,
                  letterSpacing: -0.24,
                ),
              ),
            ),
          ],
        ),
        if (assetPath.isNotEmpty)  
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: SvgPicture.asset(
                  assetPath,
                  width: 15,
                  height: 16,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
