import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:outfoot/models/auth_addition_model.dart';

// 인증판 생성

class AuthAdditionApi {
  final Dio dio = Dio();
  final String? baseUrl = dotenv.env['BASE_URL'];
  final String? accessToken = dotenv.env['TOKEN'];

  Future<String> postGoal(String token, String checkPageId, String title,
      String content, String imageUrl) async {
    try {
      final requestData = {
        'title': title,
        'content': content,
        'image': imageUrl,
      };

      print("전송 데이터: $requestData");

      final response = await dio.post(
        '$baseUrl/confirm/$checkPageId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
        data: requestData,
      );

      print("서버 응답: ${response.data}");

      if (response.statusCode == 200) {
        final goal = AddGoal.fromJson(response.data);
        return "=============데이터 전송 성공==============\n";
      } else {
        return "=============데이터 전송 실패==============\n";
      }
    } catch (e) {
      return '============데이터 전송 실패==============: $e\n';
    }
  }
}
