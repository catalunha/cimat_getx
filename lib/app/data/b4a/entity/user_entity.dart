import 'package:cimat/app/core/models/user_model.dart';
import 'package:cimat/app/data/b4a/entity/user_profile_entity.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class UserEntity {
  static const String className = '_User';

  Future<UserModel> fromParse(ParseObject parseUser) async {
    return UserModel(
      id: parseUser.objectId!,
      email: parseUser.get('username'),
      userProfile: parseUser.get('userProfile') != null
          ? UserProfileEntity().fromParse(parseUser.get('userProfile'))
          : null,
    );
  }
}
