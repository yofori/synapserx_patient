import 'package:dio/dio.dart';

import 'auth_services.dart';

class Tokens extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers['Authorization'] =
        'Bearer ${await AuthService().getFirebaseIdToken()}';
    return handler.next(options);
  }
}
