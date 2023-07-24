import 'package:dio/dio.dart';

class DioException implements Exception {
  late String errorMessage;

  DioException.fromDioError(DioExceptionType dioError) {
    switch (dioError) {
      case DioExceptionType.cancel:
        errorMessage = 'Request to the server was cancelled.';
        break;
      case DioExceptionType.connectionTimeout:
        errorMessage = 'Connection timed out.';
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Receiving timeout occurred.';
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = 'Request send timeout.';
        break;
      // case DioExceptionType.badResponse:
      //   errorMessage = _handleStatusCode(
      //       dioError.statusCode, dioError.response?.data);
      //   break;
      // case DioExceptionType.unknown:
      //   if (DioException. .message.contains('SocketException')) {
      //     errorMessage =
      //         'Cannot connect to the SynapseRx Server. Please ensure you have data and your device is not in airplane mode';
      //   break;
      // }
      // errorMessage = 'Unexpected error occurred.';
      // break;
      default:
        errorMessage = 'Something went wrong';
        break;
    }
  }

  String _handleStatusCode(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request: ${error['message']}';
      case 401:
        return 'Authentication failed: ${error['message']}';
      case 403:
        return '${error['message']}';
      case 404:
        return 'The requested resource does not exist.';
      case 405:
        return 'Method not allowed. Please check the Allow header for the allowed HTTP methods.';
      case 415:
        return 'Unsupported media type. The requested content type or version number is invalid.';
      case 422:
        return 'Data validation failed.';
      case 429:
        return 'Too many requests.';
      case 500:
        return 'Internal server error.';
      default:
        return 'Oops something went wrong!';
    }
  }

  @override
  String toString() => errorMessage;
}
