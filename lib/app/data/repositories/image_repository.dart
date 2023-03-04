import 'package:cimat/app/core/models/image_model.dart';
import 'package:cimat/app/data/utils/pagination.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

abstract class ImageRepository {
  Future<List<ImageModel>> list(
    QueryBuilder<ParseObject> query,
    Pagination pagination,
  );
  Future<ImageModel> update(ImageModel itemModel);
  Future<ImageModel?> readById(String id);
}
