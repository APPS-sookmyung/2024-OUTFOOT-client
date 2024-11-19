import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:outfoot/models/profile_my_model.dart';

class ProfileMyApi {
  final Dio dio = Dio();
  final String? baseUrl = dotenv.env['BASE_URL'];

  Future<Profile?> profileMy(String token) async {
    try {
      final response = await dio.get(
        '$baseUrl/my',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Response Status: ${response.statusCode}');
        return Profile.fromJson(response.data);
      } else {
        print("서버 오류: ${response.statusCode}");
        return null;
      }
    } on DioError catch (dioError) {
      print('Dio 예외 발생: ${dioError.message}');
      if (dioError.response != null) {
        print('응답 상태 코드: ${dioError.response!.statusCode}');
        print('응답 데이터: ${dioError.response!.data}');
      } else {
        print('네트워크 오류: ${dioError.error}');
      }
      return null;
    } catch (e) {
      print('예기치 않은 오류 발생: $e');
      return null;
    }
  }
}
