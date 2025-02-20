import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// 부정 삭제 

class DislikeDeleteApi {
  final Dio dio = Dio();
  final String? baseUrl = dotenv.env['BASE_URL'];


  Future<void> deleteDislikeConfirm(int confirmId) async {
    try {
      final response = await dio.delete('$baseUrl/dislike/$confirmId');

      if (response.statusCode == 200) {
        print ("부정 삭제 성공하셨습니다");
      } else {
        print ("부정 삭제에 실패하셨습니다");
      }
    } catch (e) {
      print ("오류 발생: $e");
    }
  }
}