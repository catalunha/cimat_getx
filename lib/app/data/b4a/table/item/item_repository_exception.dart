class ItemRepositoryException implements Exception {
  final String code;
  final String message;
  ItemRepositoryException({
    required this.code,
    required this.message,
  });
}
