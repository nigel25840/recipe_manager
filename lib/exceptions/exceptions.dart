class ServerFailure implements Exception {
  final int code;
  final String message;
  ServerFailure({required this.code, required this.message});
}