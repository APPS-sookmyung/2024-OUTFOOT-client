import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// 도장판 삭제

class CheckPageApi {
  final Dio _dio = Dio();
  final String? baseUrl = dotenv.env['BASE_URL'];
  final String? accessToken = dotenv.env['TOKEN'];

  Future<void> deleteCheckPage(int checkPageId) async {
    try {
      final response = await _dio.delete('$baseUrl/checkpages/$checkPageId');

      if (response.statusCode == 200) {
        print('CheckPage deleted successfully.');
      } else {
        print(
            'Failed to delete CheckPage. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting CheckPage: $e');
    }
  }
}
