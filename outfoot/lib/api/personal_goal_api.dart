import 'package:dio/dio.dart';

class PersonalGoalApi {
  final Dio dio = Dio();
  final String baseUrl = 'http://54.180.146.185:8080';

  Future<Response> postGoal(
      String token, String title, String intro, int animalId) async {
    try {
      final response = await dio.post(
        '$baseUrl/checkpages',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'title': title,
          'intro': intro,
          'animalId': animalId.toString(),
        },
      );
      return response;
    } catch (e) {
      print('Error posting goal: $e');
      rethrow;
    }
  }
}
