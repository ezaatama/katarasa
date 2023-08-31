class CategoriesResponse {
  Status status;
  List<CategoriesRequest> data;

  CategoriesResponse({
    required this.status,
    required this.data,
  });

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      CategoriesResponse(
        status: Status.fromJson(json["status"]),
        data: List<CategoriesRequest>.from(
            json["data"].map((x) => CategoriesRequest.fromJson(x))),
      );
}

class CategoriesRequest {
  String name;
  String value;

  CategoriesRequest({
    required this.name,
    required this.value,
  });

  factory CategoriesRequest.fromJson(Map<String, dynamic> json) =>
      CategoriesRequest(
        name: json["name"],
        value: json["value"],
      );
}

class Status {
  int code;
  String message;

  Status({
    required this.code,
    required this.message,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        code: json["code"],
        message: json["message"],
      );
}
