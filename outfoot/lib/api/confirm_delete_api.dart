import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// 인증판 삭제

class ConfirmDeleteApi {
  final Dio dio = Dio();
  final String? baseUrl = dotenv.env['BASE_URL'];
  final String? accessToken = dotenv.env['ACCESS_TOKEN'];

  Future<void> deleteConfirm(int ConfirmId) async {
    try {
      final response = await dio.delete('$baseUrl/confirm/$ConfirmId');

      if (response.statusCode == 200) {
        print("인증판 삭제 성공하셨습니다");
      } else {
        print("인증판 삭제 실패하셨습니다");
      }
    } catch (e) {
      print("오류 발생: $e");
    }
  }
}
