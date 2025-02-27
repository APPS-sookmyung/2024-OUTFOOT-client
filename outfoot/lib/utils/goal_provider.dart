import 'package:flutter/material.dart';

class GoalProvider with ChangeNotifier {
  Map<String, String> _goalTitles = {};
  Map<String, String> _goalIntros = {};
  Map<String, String> _goalDates = {};
  Map<String, List<String>> _goalImages = {};

  List<Map<String, dynamic>> _goalList = [];

  List<Map<String, dynamic>> get goalList => _goalList;

  String generateGoalId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  String getGoalTitle(String goalId) {
    return _goalTitles[goalId] ?? "기본 목표 제목";
  }

  String getGoalIntro(String goalId) {
    return _goalIntros[goalId] ?? '기본 목표 설명';
  }

  String getGoalDate(String goalId) {
    return _goalDates[goalId] ?? "2024-01-01";
  }

  void updateGoalTitle(String goalId, String newTitle) {
    _goalTitles[goalId] = newTitle;
    notifyListeners();
  }

  void updateGoalDate(String goalId, String newDate) {
    _goalDates[goalId] = newDate;
    notifyListeners();
  }

  List<String> getGoalImages(String goalId) {
    return _goalImages[goalId] ?? [];
  }

  void updateGoal(String goalId, String title, String intro, String date) {
    _goalTitles[goalId] = title;
    _goalIntros[goalId] = intro;
    _goalDates[goalId] = date;

    int index = _goalList.indexWhere((goal) => goal["goalId"] == goalId);
    if (index != -1) {
      _goalList[index]["goalId"] = goalId.toString(); // ✅ goalId 유지
      _goalList[index]["title"] = title;
      _goalList[index]["startDate"] = date;
    }

    notifyListeners();
  }

  void addImage(String goalId, String imageUrl) {
    _goalImages[goalId] ??= [];
    _goalImages[goalId]!.add(imageUrl);
    notifyListeners();
  }

  bool goalExists(String goalId) {
    return _goalTitles.containsKey(goalId) ||
        _goalList.any((goal) => goal["goalId"] == goalId);
  }

  void addGoal(Map<String, dynamic> goal) {
    if (!goalExists(goal["goalId"].toString())) {
      _goalList.add({
        "goalId": goal["goalId"].toString(), // ✅ goalId를 String으로 유지
        "title": goal["title"],
        "startDate": goal["startDate"],
        "progress": (goal["progress"] ?? 0.0).toDouble(), // ✅ null 방지
        "imageUrl": goal["imageUrl"] ?? "",
      });
      notifyListeners();
    }
  }

  void deleteGoal(String goalId) {
    _goalTitles.remove(goalId);
    _goalIntros.remove(goalId);
    _goalDates.remove(goalId);
    _goalImages.remove(goalId);
    _goalList.removeWhere((goal) => goal["goalId"] == goalId);
    notifyListeners();
  }
}
