import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:outfoot/models/profile_edit_model.dart';

class ProfileEditApi {
  final Dio _dio = Dio();

  /// 프로필 수정 API 요청
  Future<ProfileEditResponse> updateProfile({
    required String nickname,
    required String myIntro,
    required String email,
    required String token,
  }) async {
    final String? baseUrl = dotenv.env['BASE_URL'];

    try {
      print("Request URL: $baseUrl/my");

      final response = await _dio.put(
        '$baseUrl/my', 
        data: {
          'nickname': nickname,
          'myIntro': myIntro,
          'email': email,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return ProfileEditResponse.fromJson(response.data);
      } else {
        throw Exception('프로필 수정 실패: ${response.data}');
      }
    } catch (e) {
      throw Exception('오류 발생: $e');
    }
  }
}
