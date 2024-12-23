import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:outfoot/models/add_friend_model.dart';

class AddFriendApi {
  final Dio _dio = Dio();

  /// 친구 추가 API 요청
  Future<FriendResponse> inviteCode(String code, String token) async {
    final String? baseUrl = dotenv.env['BASE_URL'];

    try {
      print("Request URL: $baseUrl/friends?code=$code");

      final response = await _dio.post(
        '$baseUrl/friends?code=$code',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print("API 성공: 친구 추가 완료");
        return FriendResponse(
          status: '200',
          message: '친구 추가에 성공하였습니다.',
        );
      } else if (response.statusCode == 400) {
        final error = response.data['error'] ?? '알 수 없는 오류';
        print("API 400 오류: $error");
        return FriendResponse(
          status: '400',
          message: '친구 추가 실패',
          errorCode: error,
        );
      } else {
        print("API 알 수 없는 상태 코드: ${response.statusCode}");
        return FriendResponse(
          status: response.statusCode.toString(),
          message: '알 수 없는 상태 코드',
        );
      }
    } on DioError catch (e) {
      if (e.response != null) {
        final statusCode = e.response?.statusCode.toString() ?? 'unknown';
        final errorMessage = e.response?.data['message'] ?? 'Unknown error';
        print("DioError 발생: 상태 코드: $statusCode, 메시지: $errorMessage");

        return FriendResponse(
          status: statusCode,
          message: errorMessage,
        );
      } else {
        print("DioError 네트워크 오류: ${e.message}");
        return FriendResponse(
          status: 'error_network',
          message: '네트워크 오류 발생',
        );
      }
    } catch (e) {
      print("예상치 못한 오류: $e");
      return FriendResponse(
        status: 'error_unknown',
        message: '예상치 못한 오류 발생',
      );
    }
  }
}
