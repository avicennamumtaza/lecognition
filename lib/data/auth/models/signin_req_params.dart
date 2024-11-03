class SigninReqParams {
  SigninReqParams({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "email": email,
      "password": password,
    };
  }
}
