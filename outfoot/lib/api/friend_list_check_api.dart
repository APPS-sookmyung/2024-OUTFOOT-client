import 'package:outfoot/models/friend_list_check_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FriendService {
  final Dio dio = Dio();

  Future<FriendListResponse> getFriendList(String token) async {
    final String? baseUrl = dotenv.env['BASE_URL'];

    try {
      final response = await dio.get(
        '$baseUrl/friends',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return FriendListResponse.fromJson(response.data['response']);
      } else {
        throw Exception("Failed to load friend list");
      }
    } catch (e) {
      throw Exception("Error fetching friend list: $e");
    }
  }

  Future<void> deleteFriend(String token, String friendId) async {
    final String url = '${dotenv.env['BASE_URL']}/friends/$friendId';
    try {
      await dio.delete(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
    } on DioError catch (e) {
      debugPrint('Error deleting friend: ${e.message}');
      throw e; // 에러를 호출한 쪽에서 처리하도록 던짐
    }
  }
}
