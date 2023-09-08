class UbahPasswordRequest {
  String passwordBaru;

  UbahPasswordRequest({
    required this.passwordBaru,
  });

  Map<String, dynamic> toJson() => {
        "passwordBaru": passwordBaru,
      };
}
