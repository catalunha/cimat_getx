import 'package:cimat/app/core/models/image_model.dart';
import 'package:cimat/app/data/b4a/entity/image_entity.dart';
import 'package:cimat/app/data/b4a/utils/parse_error_code.dart';
import 'package:cimat/app/data/repositories/image_repository.dart';
import 'package:cimat/app/data/utils/pagination.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'image_repository_exception.dart';

class ImageRepositoryB4a implements ImageRepository {
  Future<QueryBuilder<ParseObject>> getQueryAll(
      QueryBuilder<ParseObject> query, Pagination pagination) async {
    query.setAmountToSkip((pagination.page - 1) * pagination.limit);
    query.setLimit(pagination.limit);

    return query;
  }

  @override
  Future<List<ImageModel>> list(
    QueryBuilder<ParseObject> query,
    Pagination pagination,
  ) async {
    QueryBuilder<ParseObject> query2;
    query2 = await getQueryAll(query, pagination);

    ParseResponse? response;
    try {
      response = await query2.query();
      List<ImageModel> listTemp = <ImageModel>[];
      if (response.success && response.results != null) {
        for (var element in response.results!) {
          listTemp.add(ImageEntity().fromParse(element));
        }
        return listTemp;
      } else {
        return [];
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw ImageRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<ImageModel?> readById(String id) async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(ImageEntity.className));
    query.whereEqualTo('objectId', id);

    query.first();
    ParseResponse? response;
    try {
      response = await query.query();

      if (response.success && response.results != null) {
        return ImageEntity().fromParse(response.results!.first);
      } else {
        throw Exception();
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw ImageRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<ImageModel> update(ImageModel profileModel) async {
    final userProfileParse = await ImageEntity().toParse(profileModel);
    ParseResponse? response;
    try {
      response = await userProfileParse.save();

      if (response.success && response.results != null) {
        return ImageEntity().fromParse(response.results!.first);
      } else {
        throw Exception();
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw ImageRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }
}
