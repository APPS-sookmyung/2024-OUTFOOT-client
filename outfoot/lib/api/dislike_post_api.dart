import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// 부정 생성

class DislikePostApi {
  final Dio dio = Dio();
  final String? baseUrl = dotenv.env['BASE_URL'];
  final String? accessToken = dotenv.env['TOKEN'];

  Future<void> PostDislikeConfirm(int confirmId) async {
    try {
      final response = await dio.post('$baseUrl/dislike/$confirmId');

      if (response.statusCode == 200) {
        print("부정 추가에 성공하셨습니다");
      } else {
        print("부정 추가에 실패하셨습니다 Status CodeL ${response.statusCode}");
      }
    } catch (e) {
      print("오류 발생: $e");
    }
  }
}
