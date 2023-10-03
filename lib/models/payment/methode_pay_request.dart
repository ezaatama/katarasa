class MethodPaymentResponse {
  Status status;
  List<MethodPament> data;

  MethodPaymentResponse({
    required this.status,
    required this.data,
  });

  factory MethodPaymentResponse.fromJson(Map<String, dynamic> json) =>
      MethodPaymentResponse(
        status: Status.fromJson(json["status"]),
        data: List<MethodPament>.from(
            json["data"].map((x) => MethodPament.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class MethodPament {
  String idPaymentMethodCategory;
  String paymentTypeLabel;
  String paymentType;
  bool option;
  List<SubPayment> subPayment;

  MethodPament({
    required this.idPaymentMethodCategory,
    required this.paymentTypeLabel,
    required this.paymentType,
    required this.option,
    required this.subPayment,
  });

  factory MethodPament.fromJson(Map<String, dynamic> json) => MethodPament(
        idPaymentMethodCategory: json["id_payment_method_category"],
        paymentTypeLabel: json["payment_type_label"],
        paymentType: json["payment_type"],
        option: json["option"],
        subPayment: List<SubPayment>.from(
            json["subPayment"].map((x) => SubPayment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id_payment_method_category": idPaymentMethodCategory,
        "payment_type_label": paymentTypeLabel,
        "payment_type": paymentType,
        "option": option,
        "subPayment": List<dynamic>.from(subPayment.map((x) => x.toJson())),
      };
}

class SubPayment {
  String paymentSub;
  String paymentSubLabel;
  String icon;
  int fee;
  String paymentType;
  bool qris;
  String paymentForm;

  SubPayment({
    required this.paymentSub,
    required this.paymentSubLabel,
    required this.icon,
    required this.fee,
    required this.paymentType,
    required this.qris,
    required this.paymentForm,
  });

  factory SubPayment.fromJson(Map<String, dynamic> json) => SubPayment(
        paymentSub: json["payment_sub"],
        paymentSubLabel: json["payment_sub_label"],
        icon: json["icon"],
        fee: json["fee"],
        paymentType: json["payment_type"],
        qris: json["qris"],
        paymentForm: json["payment_form"],
      );

  Map<String, dynamic> toJson() => {
        "payment_sub": paymentSub,
        "payment_sub_label": paymentSubLabel,
        "icon": icon,
        "fee": fee,
        "payment_type": paymentType,
        "qris": qris,
        "payment_form": paymentForm,
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
