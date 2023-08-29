class HttpException implements Exception {
  final _message;
  final _prefix;
  final dynamic response;

  HttpException([
    this._message,
    this._prefix,
    this.response,
  ]);

  @override
  String toString() {
    if (_prefix == null) return "$_message";
    return "$_prefix : $_message";
  }
}

class FetchDataException extends HttpException {
  FetchDataException([String? message])
      : super(message, "Error During Communication");
}

class BadRequestException extends HttpException {
  BadRequestException([message, response]) : super(message, null, response);
}

class UnauthorisedException extends HttpException {
  UnauthorisedException([message]) : super(message, "Unauthorised");
}

class InvalidInputException extends HttpException {
  InvalidInputException([message]) : super(message, "Invalid Input");

  @override
  String toString() {
    return "$_message";
  }
}

class NoBodyResponseException extends HttpException {
  NoBodyResponseException() : super("Empty response");
}

class ConnectionProblemException extends HttpException {
  ConnectionProblemException() : super("Network issue");
}

class TimeoutException extends HttpException {
  TimeoutException() : super("Timeout");
}

class InternalServerException extends HttpException {
  InternalServerException() : super("Internal Server Error");
}

class ApiResponse<T> {
  T? data;
  String? message;
}

class ErrorResponse {
  ErrorResponse({
    required this.message,
  });

  String message;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        message: json["message"] ?? "",
      );
}
