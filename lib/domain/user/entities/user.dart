class UserEntity {
  int? id;
  int? avatar;
  String? username;
  String? email;
  String? password;

  UserEntity({this.id, this.username, this.email, this.password, this.avatar});

  UserEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['avatar'] = this.avatar;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
