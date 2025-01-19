import 'package:dio/dio.dart';
import '../models/friend_list_check_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FriendService {
  final Dio _dio = Dio();
  final String? baseUrl = dotenv.env['BASE_URL'];
  final String? accessToken = dotenv.env['ACCESS_TOKEN'];

  // 친구 목록 가져오기
  Future<FriendListResponse> getFriendList(String token) async {
    try {
      final response = await _dio.get(
        '$baseUrl/friends',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      // JSON 데이터를 FriendListResponse 객체로 변환
      return FriendListResponse.fromJson(response.data);
    } catch (e) {
      rethrow; // 에러를 호출한 곳에서 처리하도록 던집니다.
    }
  }

  // 친구 삭제
  Future<void> deleteFriend(String token, String friendId) async {
    try {
      await _dio.delete(
        '$baseUrl/friends/$friendId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } catch (e) {
      rethrow; // 에러를 호출한 곳에서 처리하도록 던집니다.
    }
  }
}
