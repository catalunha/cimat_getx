import 'package:cimat/app/core/models/user_profile_model.dart';
import 'package:cimat/app/data/utils/pagination.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

abstract class UserProfileRepository {
  Future<List<UserProfileModel>> list(
    QueryBuilder<ParseObject> query,
    Pagination pagination,
  );
  Future<String> update(UserProfileModel userProfileModel);
  Future<UserProfileModel?> readById(String id);
  Future<UserProfileModel?> getByRegister(String? value);
}
