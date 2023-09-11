class DetailAlamatRequest {
  Status status;
  List<dynamic> data;

  DetailAlamatRequest({
    required this.status,
    required this.data,
  });

  factory DetailAlamatRequest.fromJson(Map<String, dynamic> json) =>
      DetailAlamatRequest(
        status: Status.fromJson(json["status"]),
        data: List<dynamic>.from(json["data"].map((x) => x)),
      );

  static final List<String> namaAlamat = ["Rumah", "Kantor"];
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

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}
