import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/core/network/dio_client.dart';

/// Provides a configured [Dio] instance to the application.
///
/// This provider is responsible for configuring common HTTP settings such as:
///
/// - API base URL
/// - Connection timeout
/// - Request send timeout
/// - Response receive timeout
/// - Default request headers
/// - Development logging
///
/// The Dio instance is created once by Riverpod and can be reused
/// throughout the application.
final dioProvider = Provider<Dio>((ref) {

  final baseUrl = dotenv.env['API_BASE_URL'];

  print('==============================');
  print('API BASE URL: $baseUrl');
  print('==============================');

  final dio = Dio(
    BaseOptions(
      /// Base URL used for all API requests.
      baseUrl: baseUrl ?? '',

      /// Maximum time allowed to establish a connection with the server.
      connectTimeout: const Duration(seconds: 15),

      /// Maximum time allowed to send request data to the server.
      sendTimeout: const Duration(seconds: 15),

      /// Maximum time allowed to receive the server response.
      receiveTimeout: const Duration(seconds: 15),

      /// Default headers sent with API requests.
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  /// Logs Dio requests and responses during development.
  ///
  /// This is useful for debugging API calls, request bodies,
  /// response bodies, and request headers.
  dio.interceptors.add(
    LogInterceptor(
      requestBody: true,
      responseBody: true,
      requestHeader: true,
      responseHeader: false,
    ),
  );

  return dio;
});

/// Provides the application's centralized [DioClient].
/// 
/// Feature-level data sources should depend on [DioClient] instead of
/// directly accessing Dio.
final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient(
    ref.watch(dioProvider),
  );
});