import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:outfoot/models/confirm_get_model.dart';

// 인증판 개별 조회

class ConfirmGetApi {
  final Dio dio = Dio();
  final String? baseUrl = dotenv.env['BASE_URL'];
  final String? accessToken = dotenv.env['TOKEN'];

  Future<ConfirmGoal?> getGoal(String token, String confirmId) async {
    try {
      final response = await dio.get(
        '$baseUrl/confirm/$confirmId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );
      print("서버 응답: ${response.data}");

      if (response.statusCode == 200) {
        final goal = ConfirmGoal.fromJson(response.data);
        return goal;
      } else {
        print("서버 오류: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("오류 발생: $e");
      return null;
    }
  }
}
