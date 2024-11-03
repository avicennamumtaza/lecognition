class GetDiagnozeResultParams {
  GetDiagnozeResultParams({
    required this.email,
    required this.username,
    required this.password,
  });
  final String email;
  final String username;
  final String password;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "email": email,
      "username": username,
      "password": password,
    };
  }
}