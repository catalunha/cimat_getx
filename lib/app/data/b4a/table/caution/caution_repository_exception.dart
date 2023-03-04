class CautionRepositoryException implements Exception {
  final String code;
  final String message;
  CautionRepositoryException({
    required this.code,
    required this.message,
  });
}
