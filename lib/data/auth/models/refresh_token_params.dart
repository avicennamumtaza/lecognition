class RefreshTokenParams {
  RefreshTokenParams({
    required this.refreshToken,
  });
  final String refreshToken;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "refresh": refreshToken,
    };
  }
}
