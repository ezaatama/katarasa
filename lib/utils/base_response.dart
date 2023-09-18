import 'package:dio/dio.dart';

class ObjResponse {
  bool success;
  dynamic response;
  Headers? headers;
  BaseResponse errresponse;

  ObjResponse(this.success, this.response, this.headers, this.errresponse);

  @override
  String toString() {
    if (!success) {
      return "Not Success, Status : $success \n Message : $errresponse.message";
    }
    return "Status : $success \n Message : $response";
  }
}

class BaseResponse {
  Status status;
  Map<String, dynamic> data;
  // String message;
  String errors;
  dynamic response;

  BaseResponse({
    required this.status,
    required this.data,
    // required this.message,
    required this.errors,
    this.response,
  });

  @override
  String toString() {
    return "Not Success, Code : ${status.code} and Msg : ${status.message} \n Message : $errors";
  }
}

class Status {
  int code;
  String message;

  Status({
    required this.code,
    required this.message,
  });
}

class Error {
  String message;
  String? field;
  String? value;

  Error({
    required this.message,
    this.field,
    this.value,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        message: json["message"],
        field: json["field"],
        value: json["value"],
      );
}
