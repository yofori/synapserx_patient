import 'dart:developer';

import 'package:dio/dio.dart';
import 'dio_tokens.dart';
import 'settings.dart';

class DioClient {
  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: "${GlobalData.baseUrl}/api",
            connectTimeout: const Duration(seconds: 50),
            receiveTimeout: const Duration(seconds: 30),
          ),
        )..interceptors.addAll([
            Tokens(),
          ]);

  final Dio _dio;

  Future<dynamic> test() async {
    log('testing endpoint');
    try {
      Response response = await _dio.get(
        '/user/test',
      );
      print(response.data);
      return response.data;
    } on DioException catch (err) {
      final errorMessage = err.message.toString();
      log(errorMessage);
      var data = {'Message': errorMessage};
      return data;
    }
  }
}
