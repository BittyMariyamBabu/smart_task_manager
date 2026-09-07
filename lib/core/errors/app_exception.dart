/// A custom exception class for application-specific errors.
/// 
/// This class extends the built-in Exception class and allows for 
/// the creation of exceptions with custom messages. It can be used 
/// throughout the application to represent various error conditions 
/// in a consistent manner.
class AppException implements Exception {
  final String message;

  const AppException(this.message);

  @override
  String toString() => message;
}