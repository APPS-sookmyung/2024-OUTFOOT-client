import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FriendService {
  final Dio dio = Dio();
  final String? baseUrl = dotenv.env['BASE_URL'];
  final String? accessToken = dotenv.env['ACCESS_TOKEN'];

  /// 친구 추가 API
  Future<String> addFriend(String memberId, String code, String token) async {
    try {
      final url = '$baseUrl/friends?code=$code';
      print("친구 추가 요청 시작");
      print("Request URL: $url");
      print("Request Headers: Authorization: Bearer $accessToken");

      final response = await dio.post(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return '200'; // 친구 추가 성공
      } else if (response.statusCode == 400) {
        final errorBody =
            response.data is String ? jsonDecode(response.data) : response.data;

        print("에러 응답 본문: $errorBody");

        // 에러 코드에 따라 반환 값 설정
        final errorCode = errorBody['response']?['errorCode'];
        switch (errorCode) {
          case 'NOT_FRIEND_SELF':
            return '400_self';
          case 'MEMBER_NOT_FOUND':
            return '400_not_exist';
          case 'FRIEND_DUPLICATED':
            return '400_already_friend';
          default:
            print("알 수 없는 에러 코드: $errorCode");
            return '400_unknown';
        }
      }

      print("예상치 못한 상태 코드: ${response.statusCode}");
      return '500'; // Unknown server error
    } catch (e) {
      if (e is DioException) {
        print("DioException 발생: ${e.message}");
        if (e.response != null) {
          print("상태 코드: ${e.response?.statusCode}");
          print("응답 데이터: ${e.response?.data}");

          // 서버에서 반환된 데이터 처리
          if (e.response?.statusCode == 400) {
            final errorBody = e.response?.data;
            final errorCode = errorBody['response']?['errorCode'];
            switch (errorCode) {
              case 'NOT_FRIEND_SELF':
                return '400_self';
              case 'MEMBER_NOT_FOUND':
                return '400_not_exist';
              case 'FRIEND_DUPLICATED':
                return '400_already_friend';
              default:
                print("알 수 없는 에러 코드: $errorCode");
                return '400_unknown';
            }
          }
        } else {
          print("서버에 도달하지 못함: ${e.message}");
        }
      } else {
        print("알 수 없는 오류 발생: $e");
      }
      return 'network_error';
    }
  }

  /// 초대 코드 가져오기 API
  Future<String?> fetchInviteCode(String token) async {
    try {
      // 요청 정보 출력
      print("초대 코드 요청 시작");
      final requestUrl = '$baseUrl/my';
      print("Request URL: $requestUrl");
      print("Request Headers: Authorization: Bearer $token");

      final response = await dio.get(
        requestUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        print("초대 코드 응답 데이터: $data");
        return data['response']['code']; // 서버에서 반환된 초대 코드
      } else {
        print("초대 코드 요청 실패: 상태 코드 ${response.statusCode}");
        return null;
      }
    } catch (e) {
      // DioException 처리
      if (e is DioException) {
        print("DioException 발생: ${e.message}");
        if (e.response != null) {
          print("상태 코드: ${e.response?.statusCode}");
          print("응답 데이터: ${e.response?.data}");
        } else {
          print("서버에 도달하지 못함: ${e.message}");
        }
      } else {
        print("알 수 없는 오류 발생: $e");
      }
      return null; // 요청 실패 시 null 반환
    }
  }
}
