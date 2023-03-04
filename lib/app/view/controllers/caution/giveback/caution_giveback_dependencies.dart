import 'package:cimat/app/data/b4a/table/caution/caution_repository_b4a.dart';
import 'package:cimat/app/data/b4a/table/item/item_repository_b4a.dart';
import 'package:cimat/app/data/repositories/caution_repository.dart';
import 'package:cimat/app/data/repositories/item_repository.dart';
import 'package:cimat/app/view/controllers/caution/giveback/caution_giveback_controller.dart';
import 'package:get/get.dart';

class CautionGivebackDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CautionRepository>(
      () => CautionRepositoryB4a(),
    );
    Get.lazyPut<ItemRepository>(
      () => ItemRepositoryB4a(),
    );

    Get.put<CautionGivebackController>(
      CautionGivebackController(
        itemRepository: Get.find(),
        cautionRepository: Get.find(),
      ),
    );
  }
}
