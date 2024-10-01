import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:outfoot/models/view_all_model.dart';

class ViewAllApi {
  final Dio dio = Dio();
  final String? baseUrl = dotenv.env['BASE_URL'];

  Future<String> getView(String token)
    async {
      try {
        final requestData = {

        };

        print("전송 데이터: $requestData");

        final response = await dio.get(
          '$baseUrl/checkpages',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          ),
          data : requestData,
        );

        print("서버 응답: ${response.data}");

        if (response.statusCode == 200) {
          final goal = Goal.fromJson(response.data);
          return "=========데이터 전송 성공===========\n";
        } else {
          return "=========데이터 전송 실패===========\n";
        } 
      } catch (e) {
        return "=========데이터 전송 실패===========$e\n";
      }
    }
}