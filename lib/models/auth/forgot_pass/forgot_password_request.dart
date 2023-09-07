class ForgotPasswordRequest {
  final String email;
  final String newPass;

  ForgotPasswordRequest({required this.email, required this.newPass});

  Map<String, dynamic> toMap() => {'email': email, 'passwordBaru': newPass};
}
