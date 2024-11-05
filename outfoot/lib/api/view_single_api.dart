import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:outfoot/models/view_single_model.dart';

class ViewSingleApi {
  final Dio dio;
  final String baseUrl;

  ViewSingleApi({required this.dio})
      : baseUrl = dotenv.env['BASE_URL'] ?? '';

  Future<String> getGoal(String token, String checkPageId) async {
    try {
      final response = await dio.get(
        '$baseUrl/checkpages/$checkPageId/foot',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      print("서버 응답: ${response.data}");

      if (response.statusCode == 200) {
        final goal = Goal.fromJson(response.data);
        return "=============데이터 전송 성공==============\n";
      } else if (response.statusCode == 400) {
        return "=============잘못된 요청 (400)==============\n";
      } else if (response.statusCode == 401) {
        return "=============권한 오류 (401)==============\n";
      } else {
        return "=============서버 오류: ${response.statusCode}==============\n";
      }
    } catch (e) {
      print('오류 발생: $e');
      return '============데이터 전송 실패==============: 네트워크 오류\n';
    }
  }
}
