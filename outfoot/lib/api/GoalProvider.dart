import 'package:flutter/foundation.dart';

class GoalProvider with ChangeNotifier {
  List<String> _goalImages = []; // ✅ 인증 이미지 리스트
  List<String> get goalImages => _goalImages;

  void addImage(String imageUrl) {
    _goalImages.add(imageUrl);
    notifyListeners(); // ✅ UI 업데이트 반영
  }
}
