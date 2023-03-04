import 'package:cimat/app/core/models/item_model.dart';
import 'package:cimat/app/data/b4a/entity/item_entity.dart';
import 'package:cimat/app/data/repositories/item_repository.dart';
import 'package:cimat/app/data/utils/pagination.dart';
import 'package:cimat/app/routes.dart';
import 'package:cimat/app/view/controllers/utils/loader_mixin.dart';
import 'package:cimat/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class ItemSearchController extends GetxController
    with LoaderMixin, MessageMixin {
  final ItemRepository _itemRepository;
  ItemSearchController({
    required ItemRepository itemRepository,
  }) : _itemRepository = itemRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  List<ItemModel> itemList = <ItemModel>[].obs;

  final _pagination = Pagination().obs;
  final _lastPage = false.obs;
  get lastPage => _lastPage.value;

  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(ItemEntity.className));

  @override
  void onInit() {
    itemList.clear();
    _changePagination(1, 2);
    ever(_pagination, (_) async => await getMoreData());
    loaderListener(_loading);
    messageListener(_message);

    super.onInit();
  }

  void _changePagination(int page, int limit) {
    _pagination.update((val) {
      val!.page = page;
      val.limit = limit;
    });
  }

  void nextPage() {
    _changePagination(_pagination.value.page + 1, _pagination.value.limit);
  }

  Future<void> search({
    required bool descriptionContainsBool,
    required String descriptionContainsString,
    required bool serieContainsBool,
    required String serieContainsString,
    required bool loteContainsBool,
    required String loteContainsString,
    required bool brandContainsBool,
    required String brandContainsString,
    required bool modelContainsBool,
    required String modelContainsString,
    required bool calibreContainsBool,
    required String calibreContainsString,
    required bool docContainsBool,
    required String docContainsString,
    required bool obsCautionContainsBool,
    required String obsCautionContainsString,
    required bool groupEqualsToBool,
    required String groupEqualsToString,
    required bool isMunitionEqualsToBool,
    required bool isMunitionEqualsToValue,
    required bool isBlockedOperatorEqualsToBool,
    required bool isBlockedOperatorEqualsToValue,
    required bool isBlockedDocEqualsToBool,
    required bool isBlockedDocEqualsToValue,
  }) async {
    _loading(true);
    query = QueryBuilder<ParseObject>(ParseObject(ItemEntity.className));

    if (descriptionContainsBool) {
      query.whereContains('description', descriptionContainsString);
    }
    if (serieContainsBool) {
      query.whereContains('serie', serieContainsString);
    }
    if (loteContainsBool) {
      query.whereContains('lote', loteContainsString);
    }
    if (brandContainsBool) {
      query.whereContains('brand', brandContainsString);
    }
    if (modelContainsBool) {
      query.whereContains('model', modelContainsString);
    }
    if (calibreContainsBool) {
      query.whereContains('calibre', calibreContainsString);
    }
    if (docContainsBool) {
      query.whereContains('doc', docContainsString);
    }
    if (obsCautionContainsBool) {
      query.whereContains('obsCaution', obsCautionContainsString);
    }
    if (groupEqualsToBool) {
      query.whereContainedIn('groups', [groupEqualsToString]);
    }
    if (isMunitionEqualsToBool) {
      query.whereEqualTo('isMunition', isMunitionEqualsToValue);
    }
    if (isBlockedOperatorEqualsToBool) {
      query.whereEqualTo('isBlockedOperator', isBlockedOperatorEqualsToValue);
    }
    if (isBlockedDocEqualsToBool) {
      query.whereEqualTo('isBlockedDoc', isBlockedDocEqualsToValue);
    }
    query.orderByDescending('updatedAt');

    itemList.clear();
    // if (lastPage) {
    _lastPage(false);
    _pagination.update((val) {
      val!.page = 1;
      val.limit = 2;
    });
    // }
    // await getMoreData();

    // _changePagination(_pagination.value.page, _pagination.value.limit);
    _loading(false);
    Get.toNamed(Routes.itemSearchList);
  }

  Future<void> getMoreData() async {
    if (!lastPage) {
      _loading(true);
      List<ItemModel> temp = await _itemRepository.list(
        query,
        _pagination.value,
      );
      if (temp.isEmpty) {
        _lastPage(true);
      }
      itemList.addAll(temp);
      _loading(false);
    }
  }
}
