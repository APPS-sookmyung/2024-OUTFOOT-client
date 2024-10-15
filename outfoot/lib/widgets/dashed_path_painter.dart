import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:ui' as ui;

class DashedPathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, size.height - 28), // 시작점 (왼쪽 아래)
        Offset(0, size.height), // 끝점 (왼쪽 아래)
        [
          Color(0x00FAF7F0),
          Color(0xFFFAF7F0),
          Color(0xFFDFC4B6),
        ],
        [0.0, 0.3, 1.0],
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    // 아랫면만 점선 만들기
    final RRect roundedRect = RRect.fromRectAndCorners(
      Rect.fromLTWH(0, size.height - 29, size.width, 28), // 아랫면 그리기
      bottomLeft: Radius.circular(20),
      bottomRight: Radius.circular(20),
    );

    // 점선 패턴 (5, 5)
    final Path dashedPath = Path()..addRRect(roundedRect);

    // 점선을 그리는 함수 호출
    drawDashedPath(canvas, dashedPath, paint, dashArray: [5, 5]);
  }

  void drawDashedPath(Canvas canvas, Path path, Paint paint,
      {required List<double> dashArray}) {
    final PathMetrics pathMetrics = path.computeMetrics();
    for (PathMetric pathMetric in pathMetrics) {
      double distance = 0.0;
      bool draw = true;
      while (distance < pathMetric.length) {
        final double dashLength = dashArray[draw ? 0 : 1];
        final double nextDistance = distance + dashLength;
        if (draw) {
          canvas.drawPath(
              pathMetric.extractPath(distance, nextDistance), paint);
        }
        distance = nextDistance;
        draw = !draw;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
