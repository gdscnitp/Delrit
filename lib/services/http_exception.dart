class HttpException implements Exception {
  final String message;

  HttpException({this.message = ""});

  @override
  //TODO: need of this override
  String toString() {
    return message;
  }
}
