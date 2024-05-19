sealed class AppException implements Exception {
  const AppException(
    this.code,
    this.message,
  );

  final String message;
  final String code;

  @override
  String toString() => 'AppException: $message';
}

class AppFirebaseException extends AppException {
  const AppFirebaseException(
    super.code,
    super.message,
  );
}

class UnknownException extends AppException {
  const UnknownException() : super('UNKNOWN', 'An unknown error occurred');
}
