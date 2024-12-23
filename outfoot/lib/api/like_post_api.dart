import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// 인정 생성

class LikePostApi {
  final Dio dio = Dio();
  final String? baseUrl = dotenv.env['BASE_URL'];

  Future<void> PostLikeConfirm(int confirmId) async {
    try {
      final response = await dio.post('$baseUrl/like/$confirmId');

      if (response.statusCode == 200) {
        print("인증 추가에 성공하셨습니다");
      } else {
        print("인증 추가에 실패하셨습니다. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("오류 발생 :$e");
    }
  }
}