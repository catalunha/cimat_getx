import 'dart:developer';

import 'package:cimat/app/core/models/caution_model.dart';
import 'package:cimat/app/data/b4a/entity/caution_entity.dart';
import 'package:cimat/app/data/b4a/table/caution/caution_repository_exception.dart';
import 'package:cimat/app/data/b4a/utils/parse_error_code.dart';
import 'package:cimat/app/data/repositories/caution_repository.dart';
import 'package:cimat/app/data/utils/pagination.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class CautionRepositoryB4a implements CautionRepository {
  Future<QueryBuilder<ParseObject>> getQueryAll(
      QueryBuilder<ParseObject> query, Pagination? pagination) async {
    if (pagination != null) {
      query.setAmountToSkip((pagination.page - 1) * pagination.limit);
      query.setLimit(pagination.limit);
    }
    query.includeObject([
      'deliveryUserProfile',
      'receiverUserProfile',
      'givebackUserProfile',
      'item',
      'item.image'
    ]);
    return query;
  }

  @override
  Future<List<CautionModel>> list(
    QueryBuilder<ParseObject> query,
    Pagination? pagination,
  ) async {
    QueryBuilder<ParseObject> query2;
    query2 = await getQueryAll(query, pagination);

    ParseResponse? response;
    try {
      response = await query2.query();
      List<CautionModel> listTemp = <CautionModel>[];
      if (response.success && response.results != null) {
        for (var element in response.results!) {
          listTemp.add(CautionEntity().fromParse(element));
        }
        return listTemp;
      } else {
        return [];
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw CautionRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<CautionModel?> readById(String id) async {
    log('+++', name: 'CautionRepositoryB4a.readById');
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(CautionEntity.className));
    query.whereEqualTo('objectId', id);
    query.includeObject([
      'deliveryUserProfile',
      'receiverUserProfile',
      'givebackUserProfile',
      'item',
      'item.image'
    ]);
    query.first();
    ParseResponse? response;
    try {
      response = await query.query();

      if (response.success && response.results != null) {
        return CautionEntity().fromParse(response.results!.first);
      } else {
        throw Exception();
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw CautionRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<String> update(CautionModel profileModel) async {
    final userProfileParse = await CautionEntity().toParse(profileModel);
    ParseResponse? response;
    try {
      response = await userProfileParse.save();

      if (response.success && response.results != null) {
        ParseObject userProfile = response.results!.first as ParseObject;
        return userProfile.objectId!;
      } else {
        throw Exception();
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw CautionRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }
}
