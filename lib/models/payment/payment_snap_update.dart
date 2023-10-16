class PaySnapUpdateData {
  final String paymentFee;
  final String paymentForm;
  final String paymentSub;
  final String paymentSubLabel;
  final String paymentType;
  final String paymentTypeLabel;
  final String fee;
  final String idInvoice;
  final String orderCode;
  final String orderId;
  final String token;
  final String totalPembayaran;

  PaySnapUpdateData({
    required this.paymentFee,
    required this.paymentForm,
    required this.paymentSub,
    required this.paymentSubLabel,
    required this.paymentType,
    required this.paymentTypeLabel,
    required this.fee,
    required this.idInvoice,
    required this.orderCode,
    required this.orderId,
    required this.token,
    required this.totalPembayaran,
  });

  Map<String, dynamic> toJson() => {
        "payment_fee": paymentFee,
        "payment_form": paymentForm,
        "payment_sub": paymentSub,
        "payment_sub_label": paymentSubLabel,
        "payment_type": paymentType,
        "payment_type_label": paymentTypeLabel,
        "fee": fee,
        "id_invoice": idInvoice,
        "order_code": orderCode,
        "order_id": orderId,
        "token": token,
        "total_pembayaran": totalPembayaran,
      };
}

class PaySnapUpdateResponse {
  Status status;
  PaySnapUpdate data;

  PaySnapUpdateResponse({
    required this.status,
    required this.data,
  });

  factory PaySnapUpdateResponse.fromJson(Map<String, dynamic> json) =>
      PaySnapUpdateResponse(
        status: Status.fromJson(json["status"]),
        data: PaySnapUpdate.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "data": data.toJson(),
      };
}

class PaySnapUpdate {
  String orderId;
  String paymentId;
  String token;

  PaySnapUpdate({
    required this.orderId,
    required this.paymentId,
    required this.token,
  });

  factory PaySnapUpdate.fromJson(Map<String, dynamic> json) => PaySnapUpdate(
        orderId: json["order_id"],
        paymentId: json["payment_id"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "payment_id": paymentId,
        "token": token,
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
