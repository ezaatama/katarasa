class PaySnapBeforeToken {
  final String email;
  final String name;
  final String paymentSub;
  final String grandTotal;
  final String paymentId;

  PaySnapBeforeToken({
    required this.email,
    required this.name,
    required this.paymentSub,
    required this.grandTotal,
    required this.paymentId,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "payment_sub": paymentSub,
        "grand_total": grandTotal,
        "payment_id": paymentId,
      };
}

class PaymentSnapTokenResponse {
  Status status;
  PaySnapResponse data;

  PaymentSnapTokenResponse({
    required this.status,
    required this.data,
  });

  factory PaymentSnapTokenResponse.fromJson(Map<String, dynamic> json) =>
      PaymentSnapTokenResponse(
        status: Status.fromJson(json["status"]),
        data: PaySnapResponse.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "data": data.toJson(),
      };
}

class PaySnapResponse {
  String token;
  String redirectUrl;

  PaySnapResponse({
    required this.token,
    required this.redirectUrl,
  });

  factory PaySnapResponse.fromJson(Map<String, dynamic> json) =>
      PaySnapResponse(
        token: json["token"] ?? "",
        redirectUrl: json["redirect_url"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "redirect_url": redirectUrl,
      };
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
