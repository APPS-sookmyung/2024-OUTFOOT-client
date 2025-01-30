import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:outfoot/models/view_single_model.dart';

// 도장판 단건 조회

class ViewSingleApi {
  final Dio dio;
  final String? baseUrl;
  final String? accessToken = dotenv.env['TOKEN'];

  // 생성자에서 dio와 baseUrl 주입받기
  ViewSingleApi({required this.dio})
      : baseUrl = dotenv.env['BASE_URL']; // BASE_URL 초기화

  Future<ViewGoal?> getGoal(String token, String checkPageId) async {
    try {
      final response = await dio.get(
        '$baseUrl/checkpages/$checkPageId/foot',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      print("서버 응답: ${response.data}");

      if (response.statusCode == 200) {
        final goal = ViewGoal.fromJson(response.data); // 서버 응답을 ViewGoal 객체로 변환
        return goal; // ViewGoal 객체 반환
      } else {
        print("서버 오류: ${response.statusCode}");
        return null; // 실패 시 null 반환
      }
    } catch (e) {
      print('오류 발생: $e');
      return null; // 예외 발생 시 null 반환
    }
  }
}
