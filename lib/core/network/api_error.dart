class ApiError {
  final String message;
  final int? statusCoed;

  ApiError({required this.message, this.statusCoed});

  @override
  String toString() {
    return 'error: $message';
  }
}
