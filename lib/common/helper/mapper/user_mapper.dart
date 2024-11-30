import 'package:lecognition/domain/user/entities/user.dart';

class UserMapper {
  static UserEntity toEntity(UserEntity data) {
    return UserEntity(
      id: data.id,
      username: data.username,
      email: data.email,
      password: data.password,
      avatar: data.avatar,
    );
  }
}
