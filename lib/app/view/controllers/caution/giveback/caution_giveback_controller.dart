import 'package:cimat/app/core/models/caution_model.dart';
import 'package:cimat/app/core/models/item_model.dart';
import 'package:cimat/app/core/models/user_profile_model.dart';
import 'package:cimat/app/data/b4a/entity/caution_entity.dart';
import 'package:cimat/app/data/b4a/table/caution/caution_repository_exception.dart';
import 'package:cimat/app/data/repositories/caution_repository.dart';
import 'package:cimat/app/data/repositories/item_repository.dart';
import 'package:cimat/app/view/controllers/splash/splash_controller.dart';
import 'package:cimat/app/view/controllers/utils/loader_mixin.dart';
import 'package:cimat/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class CautionGivebackController extends GetxController
    with LoaderMixin, MessageMixin {
  final ItemRepository _itemRepository;
  final CautionRepository _cautionRepository;
  CautionGivebackController({
    required ItemRepository itemRepository,
    required CautionRepository cautionRepository,
  })  : _itemRepository = itemRepository,
        _cautionRepository = cautionRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  List<CautionModel> cautionList = <CautionModel>[].obs;

  final _cautionModel = Rxn<CautionModel>();
  CautionModel? get cautionModel => _cautionModel.value;
  set cautionModel(CautionModel? profileModelNew) =>
      _cautionModel(profileModelNew);

  @override
  void onInit() async {
    loaderListener(_loading);
    messageListener(_message);
    // getCurrentCautions();
    super.onInit();
  }

  Future<void> getCurrentCautions() async {
    cautionList.clear();
    // _loading(true);
    // var splashController = Get.find<SplashController>();
    // UserProfileModel givebackUserProfile =
    //     splashController.userModel!.userProfile!;
    QueryBuilder<ParseObject> query =
        QueryBuilder<ParseObject>(ParseObject(CautionEntity.className));
    query.includeObject([
      'deliveryUserProfile',
      'receiverUserProfile',
      'givebackUserProfile',
      'item'
    ]);
    // query.whereEqualTo(
    //     'givebackUserProfile',
    //     (ParseObject(UserProfileEntity.className)
    //           ..objectId = givebackUserProfile.id)
    //         .toPointer());
    query.whereEqualTo('receiverIsStartGiveback', true);
    query.whereEqualTo('givebackIsAnalyzingItem', null);
    // query.whereNotEqualTo('givebackIsAnalyzingItem', true);
    // query.whereNotEqualTo('givebackIsAnalyzingItem', false);
    List<CautionModel> temp = await _cautionRepository.list(query, null);
    cautionList.addAll(temp);
    // _loading(false);
  }

  // Future<void> getPermanentCautions() async {
  //   cautionList.clear();
  //   // _loading(true);
  //   var splashController = Get.find<SplashController>();
  //   UserProfileModel givebackUserProfile =
  //       splashController.userModel!.userProfile!;
  //   QueryBuilder<ParseObject> query =
  //       QueryBuilder<ParseObject>(ParseObject(CautionEntity.className));
  //   query.includeObject(['deliveryUserProfile', 'givebackUserProfile', 'item']);
  //   query.whereEqualTo(
  //       'givebackUserProfile',
  //       (ParseObject(UserProfileEntity.className)
  //             ..objectId = givebackUserProfile.id)
  //           .toPointer());
  //   query.whereNotEqualTo('givebackIsAnalyzingItem', true);
  //   query.whereNotEqualTo('givebackIsAnalyzingItem', false);
  //   query.whereEqualTo('receiverIsPermanentItem', true);
  //   List<CautionModel> temp = await _cautionRepository.list(query, null);
  //   cautionList.addAll(temp);
  //   // _loading(false);
  // }

  // Future<void> getHistoryCautions() async {
  //   cautionList.clear();
  //   // _loading(true);
  //   var splashController = Get.find<SplashController>();
  //   UserProfileModel givebackUserProfile =
  //       splashController.userModel!.userProfile!;
  //   QueryBuilder<ParseObject> query =
  //       QueryBuilder<ParseObject>(ParseObject(CautionEntity.className));
  //   query.includeObject(['deliveryUserProfile', 'givebackUserProfile', 'item']);
  //   query.whereEqualTo(
  //       'givebackUserProfile',
  //       (ParseObject(UserProfileEntity.className)
  //             ..objectId = givebackUserProfile.id)
  //           .toPointer());
  //   // query.whereEqualTo('receiverIsStartGiveback', true);
  //   List<CautionModel> temp = await _cautionRepository.list(query, null);
  //   cautionList.addAll(temp);
  //   // _loading(false);
  // }

  Future<void> updateGivebackIsAnalyzingItemWithRefused(
      CautionModel cautionModel, String description) async {
    try {
      // _loading(true);
      var splashController = Get.find<SplashController>();
      UserProfileModel givebackUserProfile =
          splashController.userModel!.userProfile!;
      DateTime now = DateTime.now();
      DateTime datetime =
          DateTime(now.year, now.month, now.day, now.hour, now.minute);
      CautionModel cautionModelTemp;

      cautionModelTemp = cautionModel.copyWith(
        givebackUserProfile: givebackUserProfile,
        givebackIsAnalyzingItem: false,
        givebackAnalyzedItemDt: datetime,
        givebackDescription: description,
      );
      ItemModel itemModelSend = cautionModel.item!;
      await _itemRepository.update(
          itemModelSend.copyWith(isBlockedOperator: false, isBlockedDoc: true));

      await _cautionRepository.update(cautionModelTemp);

      getCurrentCautions();
    } on CautionRepositoryException {
      // _loading(false);
      _message.value = MessageModel(
        title: 'Erro em CautionDeliveryController',
        message: 'Não foi possivel salvar em Caution',
        isError: true,
      );
    } finally {
      // _loading(false);
    }
  }

  Future<void> updateGivebackIsAnalyzingItemWithAccepted(
      CautionModel cautionModel) async {
    try {
      // _loading(true);
      var splashController = Get.find<SplashController>();
      UserProfileModel givebackUserProfile =
          splashController.userModel!.userProfile!;
      DateTime now = DateTime.now();
      DateTime datetime =
          DateTime(now.year, now.month, now.day, now.hour, now.minute);
      CautionModel cautionModelTemp;

      cautionModelTemp = cautionModel.copyWith(
        givebackUserProfile: givebackUserProfile,
        givebackIsAnalyzingItem: true,
        givebackAnalyzedItemDt: datetime,
        givebackDescription: '',
      );
      ItemModel itemModelSend = cautionModel.item!;
      await _itemRepository.update(
          itemModelSend.copyWith(isBlockedDoc: true, isBlockedOperator: false));

      await _cautionRepository.update(cautionModelTemp);
      getCurrentCautions();
    } on CautionRepositoryException {
      // _loading(false);
      _message.value = MessageModel(
        title: 'Erro em CautionDeliveryController',
        message: 'Não foi possivel salvar em Caution',
        isError: true,
      );
    } finally {
      // _loading(false);
    }
  }

  // Future<void> updateGivebackStartGiveback(
  //     CautionModel cautionModel, String description) async {
  //   try {
  //     // _loading(true);
  //     DateTime now = DateTime.now();
  //     DateTime datetime =
  //         DateTime(now.year, now.month, now.day, now.hour, now.minute);
  //     CautionModel cautionModelTemp;
  //     cautionModelTemp = cautionModel.copyWith(
  //       receiverIsStartGiveback: true,
  //       receiverGivebackItemDt: datetime,
  //       receiverGivebackDescription: description,
  //     );

  //     await _cautionRepository.update(cautionModelTemp);
  //     getCurrentCautions();
  //   } on CautionRepositoryException {
  //     // _loading(false);
  //     _message.value = MessageModel(
  //       title: 'Erro em CautionDeliveryController',
  //       message: 'Não foi possivel salvar em Caution',
  //       isError: true,
  //     );
  //   } finally {
  //     // _loading(false);
  //   }
  // }

  // Future<void> updateGivebackIsPermanentItem(
  //     CautionModel cautionModel, bool value) async {
  //   try {
  //     // _loading(true);
  //     CautionModel cautionModelTemp;
  //     cautionModelTemp = cautionModel.copyWith(
  //       receiverIsPermanentItem: value,
  //     );

  //     await _cautionRepository.update(cautionModelTemp);
  //     Get.back();
  //   } on CautionRepositoryException {
  //     // _loading(false);
  //     _message.value = MessageModel(
  //       title: 'Erro em CautionDeliveryController',
  //       message: 'Não foi possivel salvar em Caution',
  //       isError: true,
  //     );
  //   } finally {
  //     // _loading(false);
  //   }
  // }
}
