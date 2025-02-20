import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// 인정 삭제

class LikeDeleteApi {
  final Dio dio = Dio();
  final String? baseUrl = dotenv.env['BASE_URL'];

  Future<void> deleteLikeConfirm(int confirmId) async {
    try {
      final response = await dio.delete('$baseUrl/like/$confirmId');

      if (response.statusCode == 200) {
        print("인증 삭제에 성공하셨습니다");
      } else {
        print ("인증 삭제에 실패하셨습니다");
      } 
     } catch (e) {
      print("오류 발생: $e");
     }
  }
}