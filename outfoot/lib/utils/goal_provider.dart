import 'package:flutter/material.dart';

class GoalProvider with ChangeNotifier {
  String _title = '';
  String _content = '';
  String? _imagePath;
  String _date = '24.01.01'; // 기본값으로 더미 날짜 설정

  String get title => _title.isNotEmpty ? _title : '기본 목표 제목';
  String get content => _content.isNotEmpty ? _content : '기본 목표 설명';
  String? get imagePath => _imagePath;
  String get date => _date.isNotEmpty ? _date : '2024.01.01';

  void updateGoal(String title, String content, String? imagePath) {
    _title = title;
    _content = content;
    _imagePath = imagePath;
    notifyListeners();
  }

  void updateDate(String date) {
    _date = date;
    notifyListeners();
  }
}
