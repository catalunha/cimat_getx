import 'dart:developer';

import 'package:cimat/app/core/models/item_model.dart';
import 'package:cimat/app/data/b4a/entity/item_entity.dart';
import 'package:cimat/app/data/b4a/table/item/item_repository_exception.dart';
import 'package:cimat/app/data/b4a/utils/parse_error_code.dart';
import 'package:cimat/app/data/repositories/item_repository.dart';
import 'package:cimat/app/data/utils/pagination.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ItemRepositoryB4a implements ItemRepository {
  Future<QueryBuilder<ParseObject>> getQueryAll(
      QueryBuilder<ParseObject> query, Pagination pagination) async {
    query.setAmountToSkip((pagination.page - 1) * pagination.limit);
    query.setLimit(pagination.limit);
    query.includeObject(['image']);
    return query;
  }

  @override
  Future<List<ItemModel>> list(
    QueryBuilder<ParseObject> query,
    Pagination pagination,
  ) async {
    QueryBuilder<ParseObject> query2;
    query2 = await getQueryAll(query, pagination);

    ParseResponse? response;
    try {
      response = await query2.query();
      List<ItemModel> listTemp = <ItemModel>[];
      if (response.success && response.results != null) {
        for (var element in response.results!) {
          listTemp.add(ItemEntity().fromParse(element));
        }
        return listTemp;
      } else {
        return [];
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw ItemRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<ItemModel?> readById(String id) async {
    log('+++', name: 'ItemRepositoryB4a.readById');
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(ItemEntity.className));
    query.whereEqualTo('objectId', id);
    query.includeObject(['image']);
    query.first();
    ParseResponse? response;
    try {
      response = await query.query();

      if (response.success && response.results != null) {
        return ItemEntity().fromParse(response.results!.first);
      } else {
        throw Exception();
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw ItemRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<ItemModel> update(ItemModel profileModel) async {
    final userProfileParse = await ItemEntity().toParse(profileModel);
    ParseResponse? response;
    try {
      response = await userProfileParse.save();

      if (response.success && response.results != null) {
        ParseResponse? responseObject;
        ParseObject parseObject = response.results!.first;
        responseObject = await ParseObject(ItemEntity.className)
            .getObject(parseObject.objectId!, include: ['image']);
        if (responseObject.success && responseObject.results != null) {
          return ItemEntity().fromParse(responseObject.results!.first);
        } else {
          throw Exception();
        }
      } else {
        throw Exception();
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw ItemRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<ItemModel?> getBySerie(String value) async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(ItemEntity.className));
    query.whereEqualTo('serie', value);
    query.whereEqualTo('isBlockedOperator', false);
    query.whereEqualTo('isBlockedDoc', false);
    query.includeObject(['image']);

    query.first();
    ParseResponse? response;
    try {
      response = await query.query();

      if (response.success && response.results != null) {
        return ItemEntity().fromParse(response.results!.first);
      } else {
        // throw Exception();
        return null;
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw ItemRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }

  @override
  Future<List<ItemModel>> getByLote(String value) async {
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(ItemEntity.className));
    query.whereEqualTo('lote', value);
    query.whereEqualTo('isBlockedOperator', false);
    query.whereEqualTo('isBlockedDoc', false);
    query.includeObject(['image']);

    ParseResponse? response;
    try {
      response = await query.query();
      List<ItemModel> listTemp = <ItemModel>[];

      if (response.success && response.results != null) {
        for (var element in response.results!) {
          listTemp.add(ItemEntity().fromParse(element));
        }
        return listTemp;
      } else {
        return [];
      }
    } on Exception {
      var errorCodes = ParseErrorCode(response!.error!);
      throw ItemRepositoryException(
        code: errorCodes.code,
        message: errorCodes.message,
      );
    }
  }
}
