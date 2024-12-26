import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:outfoot/screens/login/kakao_login_api.dart';

class UserController with ChangeNotifier {
  User? _user;
  KakaoLoginApi kakaoLoginApi;
  User? get user => _user;

  UserController({required this.kakaoLoginApi});

  Future<void> kakaoLogin() async {
    try {
      final user = await kakaoLoginApi.signWithKakao();
      if (user != null && user is User) {
        _user = user;
        notifyListeners();
      } else {
        print('로그인 실패: 유저 정보 없음');
      }
    } catch (e) {
      print('카카오 로그인 처리 중 오류 발생: $e');
    }
  }
}
