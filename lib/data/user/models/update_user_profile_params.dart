class UpdateUserProfileParams {
  UpdateUserProfileParams({
    required this.email,
    required this.username,
    required this.password,
    this.userAvatar = null,
  });
  final String email;
  final String username;
  final String password;
  final int? userAvatar;

  Map<String, dynamic> toMap() {
    print("USER AVATAR $userAvatar");
    if (userAvatar != null) {
      return <String, dynamic>{
        "email": email,
        "username": username,
        "password": password,
        "avatar": userAvatar,
      };
    }
    return <String, dynamic>{
      "email": email,
      "username": username,
      "password": password,
    };
  }
}
