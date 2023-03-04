class ImageRepositoryException implements Exception {
  final String code;
  final String message;
  ImageRepositoryException({
    required this.code,
    required this.message,
  });
}
