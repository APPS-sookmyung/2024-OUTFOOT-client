import 'package:flutter/material.dart';

class GoalProvider with ChangeNotifier {
  String _title = '';
  String _intro = '';
  String? _imagePath;
  String _date = '24.01.01'; // 기본값으로 더미 날짜 설정
  bool _isAssetImage = false;
  String _contentTitle = ""; // 새로 추가된 contentTitle
  String _content = ""; // 새로 추가된 content

  String get title => _title.isNotEmpty ? _title : '기본 목표 제목';
  String get intro => _intro.isNotEmpty ? _intro : '기본 목표 설명';
  String? get imagePath => _imagePath;
  String get date => _date.isNotEmpty ? _date : '2024.01.01';
  bool get isAssetImage => _isAssetImage;
  String get contentTitle =>
      _contentTitle.isNotEmpty ? _contentTitle : '제목을 입력하세요';
  String get content =>
      _content.isNotEmpty ? _content : '내용을 입력하세요 (최대 50자 작성 가능)';

  void updateGoal(String title, String intro, String? imagePath) {
    _title = title;
    _intro = intro;
    _imagePath = imagePath;
    notifyListeners();
  }

  void updateContentTitle(String newContentTitle) {
    _contentTitle = newContentTitle;
    notifyListeners();
  }

  void updateContent(String newContent) {
    _content = newContent;
    notifyListeners();
  }

  void updateDate(String date) {
    _date = date;
    notifyListeners();
  }
}
