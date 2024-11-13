import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:outfoot/models/personal_goal_model.dart';

class FriendService {
  final Dio dio = Dio();
  final String? baseUrl = dotenv.env['BASE_URL'];

  Future<String> addFriend(String memberId, String code, String token) async {
    try {
      final response = await dio.post(
        '$baseUrl/friends//$memberId?code=$code',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      print("서버 응답: ${response.data}");

      if (response.statusCode == 200) {
        final goal = Goal.fromJson(response.data);
        return "200"; // 성공 코드 반환
      } else if (response.statusCode == 400) {
        // JSON 데이터를 파싱하여 세부 오류 코드 확인
        final responseData = json.decode(response.data);

        // 서버에서 전달된 오류 코드에 따라 메시지 구분
        switch (responseData['error']) {
          case 'NOT_FRIEND_SELF':
            return '400_self'; // 자기 자신 추가 불가
          case 'MEMBER_NOT_FOUND':
            return '400_not_exist'; // 존재하지 않는 회원
          case 'FRIEND_DUPLICATED':
            return '400_already_friend'; // 이미 친구인 상태
          default:
            return '400_unknown'; // 알 수 없는 400 오류
        }
      } else {
        return "error_unknown"; // 기타 상태 코드 오류
      }
    } catch (e) {
      return 'error_network: $e'; // 네트워크 또는 기타 예외 오류 처리
    }
  }
}
