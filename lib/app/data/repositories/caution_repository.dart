import 'package:cimat/app/core/models/caution_model.dart';
import 'package:cimat/app/data/utils/pagination.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

abstract class CautionRepository {
  Future<List<CautionModel>> list(
    QueryBuilder<ParseObject> query,
    Pagination? pagination,
  );
  Future<String> update(CautionModel userProfileModel);
  Future<CautionModel?> readById(String id);
}
