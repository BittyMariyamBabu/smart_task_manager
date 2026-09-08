import 'package:dio/dio.dart';
import 'package:task_manager/core/errors/app_exception.dart';

/// Handles a successful or unsuccessful HTTP response.
///
/// A response with a status code in the range [200-299] is considered
/// successful and is returned to the caller.
///
/// For any other status code, an [AppException] is thrown. The method
/// attempts to extract a meaningful error message from the API response
/// before falling back to a default message based on the HTTP status code.

/// - [AppException] when the response contains a non-success status code.
Response<T> handleResponse<T>(Response<T> response) {
  final statusCode = response.statusCode ?? 0;

  // HTTP status codes from 200 to 299 indicate success.
  if (statusCode >= 200 && statusCode < 300) {
    return response;
  }

  // Convert unsuccessful HTTP responses into an application exception.
  throw AppException(
    message: _extractMessage(response) ??
        _defaultStatusMessage(statusCode),
    statusCode: statusCode,
  );
}

/// Converts a [DioException] into an application-level [AppException].
///
/// This method handles errors that occur while Dio is processing a request,
/// such as connection failures, timeouts, cancelled requests, and server
/// responses with error status codes.
///
/// If the exception contains an HTTP response, the response status code
/// and API-provided error message are used.
///
/// If there is no response, the [DioExceptionType] is used to determine
/// the appropriate error message.
///
/// This keeps Dio-specific exceptions inside the network layer so that
/// repositories and UI layers do not need to depend directly on Dio.
AppException handleDioException(DioException exception) {
  final response = exception.response;

  // The server returned a response but with an error status code.
  if (response != null) {
    final statusCode = response.statusCode ?? 0;

    return AppException(
      message: _extractMessage(response) ??
          _defaultStatusMessage(statusCode),
      statusCode: statusCode,
    );
  }

  // Handle errors where a server response was not received.
  switch (exception.type) {
    /// The connection could not be established within the configured
    /// connection timeout duration.
    case DioExceptionType.connectionTimeout:
      return AppException(
        message: 'Unable to connect to the server.',
      );

    /// Dio could not establish a network connection.
    ///
    /// This commonly occurs when the device has no internet connection.
    case DioExceptionType.connectionError:
      return AppException(
        message: 'Unable to connect to the server.',
      );

    /// The request could not be sent within the configured timeout.
    case DioExceptionType.sendTimeout:
      return AppException(
        message: 'Request timed out.',
      );

    /// The server did not send a response within the configured timeout.
    case DioExceptionType.receiveTimeout:
      return AppException(
        message: 'Server took too long to respond.',
      );

    /// The server certificate could not be trusted.
    case DioExceptionType.badCertificate:
      return AppException(
        message: 'Secure connection could not be established.',
      );

    /// The request was explicitly cancelled.
    case DioExceptionType.cancel:
      return AppException(
        message: 'Request was cancelled.',
      );

    /// Dio received an invalid HTTP response.
    case DioExceptionType.badResponse:
      return AppException(
        message: 'Invalid server response.',
      );

    /// An unknown or unexpected Dio error occurred.
    case DioExceptionType.unknown:
      return AppException(
        message: 'Something went wrong. Please try again.',
      );

    /// The response transformation took longer than the configured timeout.
    case DioExceptionType.transformTimeout:
      return AppException(
        message: 'Response processing timed out.',
      );
  }
}

/// Extracts an error message from the API response.
///
/// The API is expected to return an error message using either the
/// `message` or `error` field.
/// The method first checks the `message` field. If it is not available,
/// it checks the `error` field.
///
/// Returns:
/// - The API-provided error message when available.
/// - `null` when no usable error message is found.
String? _extractMessage(Response response) {
  final data = response.data;

  if (data is Map<String, dynamic>) {
    final message = data['message'];

    if (message is String && message.isNotEmpty) {
      return message;
    }

    final error = data['error'];

    if (error is String && error.isNotEmpty) {
      return error;
    }
  }

  return null;
}

/// Returns a user-friendly default message for an HTTP status code.
///
/// This method is used when the API response does not provide its own
/// meaningful error message.
///
/// Supported status codes include:
///
/// - `400` Bad Request
/// - `401` Unauthorized
/// - `403` Forbidden
/// - `404` Not Found
/// - `409` Conflict
/// - `422` Unprocessable Entity
/// - `429` Too Many Requests
/// - `500` Internal Server Error
/// - `502` Bad Gateway
/// - `503` Service Unavailable
/// - `504` Gateway Timeout
///
/// Returns:
/// - A user-friendly error message for the supplied status code.
String _defaultStatusMessage(int statusCode) {
  switch (statusCode) {
    case 400:
      return 'Bad request.';

    case 401:
      return 'Unauthorized. Please login again.';

    case 403:
      return 'You do not have permission to perform this action.';

    case 404:
      return 'Requested resource was not found.';

    case 409:
      return 'Conflict occurred.';

    case 422:
      return 'Validation failed.';

    case 429:
      return 'Too many requests. Please try again later.';

    case 500:
      return 'Internal server error.';

    case 502:
    case 503:
    case 504:
      return 'Server is temporarily unavailable.';

    default:
      return 'Something went wrong.';
  }
}