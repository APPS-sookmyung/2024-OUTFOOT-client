import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:outfoot/models/view_single_model.dart';

// 도장판 단건 조회

class ViewSingleApi {
  final Dio dio;
  final String baseUrl;

  ViewSingleApi({required this.dio})
      : baseUrl = dotenv.env['BASE_URL'] ?? '';

  Future<ViewGoal> getGoal(String token, String checkPageId) async {
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
      return ViewGoal.fromJson(response.data);
    } else {
      throw Exception('Failed to load goal');
    }
  } catch (e) {
    print('오류 발생: $e');
    throw Exception('Failed to fetch goal');
  }
  }
}
