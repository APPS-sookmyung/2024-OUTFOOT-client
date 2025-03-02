import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:outfoot/screens/login/kakao_login_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

class UserController with ChangeNotifier {
  String? _accessToken;
  String? get accessToken => _accessToken;

  final Dio _dio = Dio(); // Dio 인스턴스 생성

  Future<void> kakaoLogin() async {
    final String kakaoAuthUrl = dotenv.env['KAKAO_AUTH_URL'] ?? '';

    if (kakaoAuthUrl.isEmpty) {
      print('KAKAO_AUTH_URL이 설정되지 않았습니다.');
      return;
    }

    try {
      final response = await _dio.get(kakaoAuthUrl);

      if (response.statusCode == 200) {
        final data = response.data;
        _accessToken = data['accesstoken'];
        notifyListeners();
        print('로그인 성공: accessToken 저장 완료');
      } else {
        print('카카오 로그인 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('카카오 로그인 요청 중 오류 발생: $e');
    }
  }
}
