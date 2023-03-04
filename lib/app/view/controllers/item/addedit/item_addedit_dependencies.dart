import 'package:cimat/app/data/b4a/table/item/item_repository_b4a.dart';
import 'package:cimat/app/data/repositories/item_repository.dart';
import 'package:cimat/app/view/controllers/item/addedit/item_addedit_controller.dart';
import 'package:get/get.dart';

class ItemAddEditDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ItemRepository>(
      () => ItemRepositoryB4a(),
    );

    Get.put<ItemAddEditController>(
      ItemAddEditController(
        itemRepository: Get.find(),
      ),
    );
  }
}
