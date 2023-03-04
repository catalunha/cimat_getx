import 'package:cimat/app/core/models/caution_model.dart';
import 'package:cimat/app/core/models/item_model.dart';
import 'package:cimat/app/core/models/user_profile_model.dart';
import 'package:cimat/app/data/b4a/table/caution/caution_repository_exception.dart';
import 'package:cimat/app/data/b4a/table/item/item_repository_exception.dart';
import 'package:cimat/app/data/repositories/caution_repository.dart';
import 'package:cimat/app/data/repositories/item_repository.dart';
import 'package:cimat/app/data/repositories/user_profile_repository.dart';
import 'package:cimat/app/view/controllers/splash/splash_controller.dart';
import 'package:cimat/app/view/controllers/utils/loader_mixin.dart';
import 'package:cimat/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';

class CautionDeliveryController extends GetxController
    with LoaderMixin, MessageMixin {
  final UserProfileRepository _userProfileRepository;
  final ItemRepository _itemRepository;
  final CautionRepository _cautionRepository;
  CautionDeliveryController({
    required UserProfileRepository userProfileRepository,
    required ItemRepository itemRepository,
    required CautionRepository cautionRepository,
  })  : _userProfileRepository = userProfileRepository,
        _itemRepository = itemRepository,
        _cautionRepository = cautionRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final _cautionModel = Rxn<CautionModel>();
  CautionModel? get cautionModel => _cautionModel.value;
  set cautionModel(CautionModel? profileModelNew) =>
      _cautionModel(profileModelNew);
  int quantityEnd = 1;
  // String registerEnd = '';
  List<ItemModel> itemModelSelected = [];
  bool operatorContainRestrictionsWithItem = false;
  @override
  void onInit() async {
    // if (Get.arguments == null) {
    //   registerEnd = '';
    // } else {
    //   registerEnd = Get.arguments;
    // }
    loaderListener(_loading);
    messageListener(_message);
    super.onInit();
  }

  Future<bool> consult({
    String? serie,
    String? lote,
    String? register,
    int quantity = 1,
  }) async {
    try {
      _loading(true);
      quantityEnd = quantity;
      // registerEnd = register!;
      var splashController = Get.find<SplashController>();
      UserProfileModel deliveryUserProfile =
          splashController.userModel!.userProfile!;

      DateTime now = DateTime.now();
      DateTime deliveryDt =
          DateTime(now.year, now.month, now.day, now.hour, now.minute);

      List<ItemModel> itemModelList = [];
      if (serie != null && serie.isNotEmpty) {
        ItemModel? itemModel = await _itemRepository.getBySerie(serie);
        if (itemModel != null) {
          itemModelList.add(itemModel);
        }
      } else if (lote != null && lote.isNotEmpty) {
        itemModelList.addAll(await _itemRepository.getByLote(lote));
      }
      if (itemModelList.isEmpty) {
        _loading(false);
        _message.value = MessageModel(
          title: 'Erro em Item',
          message: 'Não foi possível encontrar um item',
          isError: true,
        );
      } else {
        if (itemModelList.length < quantity) {
          _loading(false);
          _message.value = MessageModel(
            title: 'Erro em Item',
            message: 'Quantidade não disponível',
            isError: true,
          );
        } else {
          UserProfileModel? receiverUserProfile;
          receiverUserProfile =
              await _userProfileRepository.getByRegister(register);
          if (receiverUserProfile == null) {
            _loading(false);
            _message.value = MessageModel(
              title: 'Erro em Operador',
              message: 'Não foi possível encontrar um operador',
              isError: true,
            );
          } else {
            operatorContainRestrictionsWithItem = deliveryUserProfile
                .restrictions!
                .any((g) => itemModelList[0].groups!.contains(g));

            cautionModel = CautionModel(
              deliveryUserProfile: deliveryUserProfile,
              deliveryDt: deliveryDt,
              item: itemModelList[0],
              receiverUserProfile: receiverUserProfile,
            );
            itemModelSelected = itemModelList;
            _loading(false);
            return true;
            // Get.toNamed(Routes.cautionDeliveryConfirm);
          }
        }
      }
      return false;
    } on ItemRepositoryException {
      _message.value = MessageModel(
        title: 'Erro em CautionDeliveryController',
        message: 'Não foi possivel salvar em Caution',
        isError: true,
      );
      return false;
    } finally {
      // _loading(false);
    }
  }

  Future<bool> confirmOrder() async {
    try {
      _loading(true);
      for (var i = 0; i < quantityEnd; i++) {
        ItemModel itemModelSend = itemModelSelected[i];
        CautionModel cautionModelSend =
            cautionModel!.copyWith(item: itemModelSend);
        await _cautionRepository.update(cautionModelSend);
        await _itemRepository
            .update(itemModelSend.copyWith(isBlockedOperator: true));
      }
      return true;
    } on CautionRepositoryException {
      _loading(false);
      _message.value = MessageModel(
        title: 'Erro em CautionDeliveryController',
        message: 'Não foi possivel salvar em Caution',
        isError: true,
      );
      return false;
    } on ItemRepositoryException {
      _loading(false);
      _message.value = MessageModel(
        title: 'Erro em CautionDeliveryController',
        message: 'Não foi possivel salvar em Item',
        isError: true,
      );
      return false;
    } finally {
      _loading(false);
    }
  }
}
