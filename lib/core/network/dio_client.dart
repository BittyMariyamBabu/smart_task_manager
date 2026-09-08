import 'package:dio/dio.dart';
import 'package:task_manager/core/network/dio_exception.dart';

/// Centralized HTTP client for communicating with REST APIs.
///
/// This class wraps Dio and provides common handling for:
///
/// - GET requests
/// - POST requests
/// - PUT requests
/// - DELETE requests
/// - HTTP status codes
/// - Network errors
/// - Connection timeouts
/// - Server errors
/// - API error messages
///
/// Feature-level data sources should use this class instead of accessing
/// Dio directly.
class DioClient {
  /// Dio instance used to execute HTTP requests.
  final Dio _dio;

  /// Creates a [DioClient] using the provided Dio instance.
  DioClient(this._dio);

  /// Sends a GET request to the given [path].
  ///
  /// [queryParameters] contains optional URL query parameters.
  ///
  /// [options] can be used to override Dio request options.
  ///
  /// [cancelToken] can be used to cancel the request.
  ///
  /// Returns the HTTP [Response] when the request is successful.
  ///
  /// Throws:
  /// - [NetworkException] for network-related failures.
  /// - [ServerException] for unsuccessful HTTP responses.
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return handleResponse(response);
    }  on DioException catch (e) {
      throw handleDioException(e);
    }
  }

  /// Sends a POST request to the given [path].
  ///
  /// [data] contains the request body.
  ///
  /// [queryParameters] contains optional URL query parameters.
  ///
  /// [options] can be used to override Dio request options.
  ///
  /// [cancelToken] can be used to cancel the request.
  ///
  /// Returns the HTTP [Response] when the request is successful.
  ///
  /// Throws:
  /// - [NetworkException] for network-related failures.
  /// - [ServerException] for unsuccessful HTTP responses.
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return handleResponse(response);
    } on DioException catch (e) {
      throw handleDioException(e);
    }
  }

  /// Sends a PUT request to the given [path].
  ///
  /// [data] contains the request body.
  ///
  /// [queryParameters] contains optional URL query parameters.
  ///
  /// [options] can be used to override Dio request options.
  ///
  /// [cancelToken] can be used to cancel the request.
  ///
  /// [cancelToken] can be used to cancel the request.
  ///
  /// Returns the HTTP [Response] when the request is successful.
  ///
  /// Throws:
  /// - [NetworkException] for network-related failures.
  /// - [ServerException] for unsuccessful HTTP responses.
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return handleResponse(response);
    } on DioException catch (e) {
      throw handleDioException(e);
    }
  }

  /// Sends a DELETE request to the given [path].
  ///
  /// [data] contains an optional request body.
  ///
  /// [queryParameters] contains optional URL query parameters.
  ///
  /// [options] can be used to override Dio request options.
  ///
  /// [cancelToken] can be used to cancel the request.
  ///
  /// Returns the HTTP [Response] when the request is successful.
  ///
  /// Throws:
  /// - [NetworkException] for network-related failures.
  /// - [ServerException] for unsuccessful HTTP responses.
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return handleResponse(response);
    } on DioException catch (e) {
      throw handleDioException(e);
    }
  }
}