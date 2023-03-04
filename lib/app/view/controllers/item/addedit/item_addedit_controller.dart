import 'package:cimat/app/core/models/item_model.dart';
import 'package:cimat/app/data/b4a/table/item/item_repository_exception.dart';
import 'package:cimat/app/data/repositories/item_repository.dart';
import 'package:cimat/app/view/controllers/item/search/item_search_controller.dart';
import 'package:cimat/app/view/controllers/utils/loader_mixin.dart';
import 'package:cimat/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';

import '../../../../core/models/image_model.dart';

class ItemAddEditController extends GetxController
    with LoaderMixin, MessageMixin {
  final ItemRepository _itemRepository;
  ItemAddEditController({
    required ItemRepository itemRepository,
  }) : _itemRepository = itemRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final _item = Rxn<ItemModel>();
  ItemModel? get item => _item.value;
  set item(ItemModel? itemNew) => _item(itemNew);

// //+++ forms
//   final descriptionTec = TextEditingController();
//   final serieTec = TextEditingController();
//   final lote = TextEditingController();
//   final brandTec = TextEditingController();
//   final modelTec = TextEditingController();
//   final calibreTec = TextEditingController();
//   final docTec = TextEditingController();
//   final obsCautionTec = TextEditingController();
//   bool isMunition = false;
//   bool isBlockedOperator = false;
//   bool isBlockedDoc = false;
//   final groupsTec = TextEditingController();
// //--- forms
  // XFile? _xfile;
  // set xfile(XFile? xfile) {
  //   _xfile = xfile;
  // }

  final Rxn<DateTime> _validate = Rxn<DateTime>();
  DateTime? get validate => _validate.value;
  set validate(DateTime? selectedDate) {
    if (selectedDate != null) {
      _validate.value = DateTime(selectedDate.year, selectedDate.month);
    }
  }

  // final image = Rxn<ImageModel>();

  @override
  void onInit() async {
    validate = DateTime.now().add(const Duration(days: 365));
    loaderListener(_loading);
    messageListener(_message);
    item = Get.arguments;
    // if (item != null) {
    //   image.value = item?.image;
    // }
    super.onInit();
  }

  Future<void> addedit({
    String? description,
    String? serie,
    String? lote,
    String? brand,
    String? model,
    String? calibre,
    String? doc,
    String? obsCaution,
    bool? isMunition,
    bool? isBlockedOperator,
    bool? isBlockedDoc,
    String? groups,
    int quantity = 1,
    ImageModel? imageModel,
  }) async {
    try {
      _loading(true);
      if (item == null) {
        item = ItemModel(
          description: description,
          serie: serie,
          lote: lote,
          brand: brand,
          model: model,
          calibre: calibre,
          doc: doc,
          obsCaution: obsCaution,
          validate: validate,
          isMunition: isMunition,
          isBlockedOperator: isBlockedOperator,
          isBlockedDoc: isBlockedDoc,
          groups: groups?.split('\n'),
          image: imageModel,
        );
      } else {
        item = item!.copyWith(
          description: description,
          serie: serie,
          lote: lote,
          brand: brand,
          model: model,
          calibre: calibre,
          doc: doc,
          obsCaution: obsCaution,
          validate: validate,
          isMunition: isMunition,
          isBlockedOperator: isBlockedOperator,
          isBlockedDoc: isBlockedDoc,
          groups: groups?.split('\n'),
          image: imageModel,
        );
      }

      for (var i = 0; i < quantity; i++) {
        await _itemRepository.update(item!);
        // if (_xfile != null) {
        //   String? photoUrl = await XFileToParseFile.xFileToParseFile(
        //     xfile: _xfile!,
        //     className: ItemEntity.className,
        //     objectId: itemModel.id!,
        //     objectAttribute: 'photo',
        //   );
        //   item = item!.copyWith(photo: photoUrl);
        // }
      }
      bool existCautionSearchController =
          Get.isRegistered<ItemSearchController>();
      if (existCautionSearchController) {
        var itemSearchController = Get.find<ItemSearchController>();
        itemSearchController.itemList;
        int index = itemSearchController.itemList
            .indexWhere((model) => model.id == item!.id!);
        itemSearchController.itemList.replaceRange(index, index + 1, [item!]);
      }
    } on ItemRepositoryException {
      _message.value = MessageModel(
        title: 'Erro em ProfileController',
        message: 'Não foi possivel salvar o perfil',
        isError: true,
      );
    } finally {
      _loading(false);
    }
  }
}
