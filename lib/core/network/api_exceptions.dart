import 'package:dio/dio.dart';

import 'api_error.dart';

class ApiExceptions {
  static ApiError handleError(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    if (data is Map<String, dynamic> && data['message'] != null) {
      return ApiError(message: data['message']);
    }

    if (statusCode == 409 ||
        (data is Map<String, dynamic> &&
            (data['message']?.toString().toLowerCase().contains('exists') ??
                false))) {
      return ApiError(message: "Email already exists");
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(message: "Connection timeout with API server");
      case DioExceptionType.receiveTimeout:
        return ApiError(message: "Receive timeout in connection");
      case DioExceptionType.sendTimeout:
        return ApiError(message: "Request timeout");
      default:
        return ApiError(message: "Something went wrong");
    }
  }
}
