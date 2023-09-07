class RegisterRequest {
  final String name;
  final String phoneNumber;
  final String email;
  final String password;
  final String genderId;

  RegisterRequest(
      {required this.name,
      required this.phoneNumber,
      required this.email,
      required this.password,
      required this.genderId});

  Map<String, dynamic> toMap() => {
        'name': name,
        'phone_number': phoneNumber,
        'email': email,
        'password': password,
        'gender_id': genderId
      };

  static final List<String> gender = ["Laki-laki", "Perempuan"];
}
