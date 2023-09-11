import 'package:dio/dio.dart';

import 'auth_services.dart';

class Tokens extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      options.headers['Authorization'] =
          'Bearer ${await AuthService().getFirebaseIdToken()}';
      return handler.next(options);
    } on DioException catch (e) {
      handler.reject(e);
    } catch (e) {
      handler.reject(
        DioException(
            requestOptions: options,
            type: DioExceptionType.connectionError,
            error: e),
      );
    }
  }
}
