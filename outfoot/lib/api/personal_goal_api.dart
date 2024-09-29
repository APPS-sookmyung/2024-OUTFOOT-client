import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:outfoot/models/personal_goal_model.dart';

class PersonalGoalApi {
  final Dio dio = Dio();
  final String? baseUrl = dotenv.env['BASE_URL'];

  Future<String> postGoal(
      String token, String title, String intro, int animalId) async {
    try {
      final requestData = {
        'title': title,
        'intro': intro,
        'animalId': animalId.toString(),
      };

      print("전송 데이터: $requestData");

      final response = await dio.post(
        '$baseUrl/checkpages',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
        data: requestData,
      );

      print("서버 응답: ${response.data}");

      if (response.statusCode == 200) {
        final goal = Goal.fromJson(response.data);
        print("Goal ID: ${goal.id}\n");
        print("Title: ${goal.title}\n");
        print("Intro: ${goal.intro}\n");
        print("Created At: ${goal.createdAt}\n");
        print("Animal Position: ${goal.animalPosition}\n");
        print("Animal: ${goal.animal}\n");
        return "=============데이터 전송 성공==============\n";
      } else {
        return "=============데이터 전송 실패==============\n";
      }
    } catch (e) {
      return '============데이터 전송 실패==============: $e\n';
    }
  }
}
