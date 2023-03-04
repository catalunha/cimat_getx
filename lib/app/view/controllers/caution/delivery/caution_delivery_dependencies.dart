import 'package:cimat/app/data/b4a/table/caution/caution_repository_b4a.dart';
import 'package:cimat/app/data/b4a/table/item/item_repository_b4a.dart';
import 'package:cimat/app/data/b4a/table/user_profile/user_profile_repository_b4a.dart';
import 'package:cimat/app/data/repositories/caution_repository.dart';
import 'package:cimat/app/data/repositories/item_repository.dart';
import 'package:cimat/app/data/repositories/user_profile_repository.dart';
import 'package:cimat/app/view/controllers/caution/delivery/caution_delivery_controller.dart';
import 'package:get/get.dart';

class CautionDeliveryDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CautionRepository>(
      () => CautionRepositoryB4a(),
    );
    Get.lazyPut<UserProfileRepository>(
      () => UserProfileRepositoryB4a(),
    );
    Get.lazyPut<ItemRepository>(
      () => ItemRepositoryB4a(),
    );

    Get.put<CautionDeliveryController>(
      CautionDeliveryController(
        userProfileRepository: Get.find(),
        itemRepository: Get.find(),
        cautionRepository: Get.find(),
      ),
    );
  }
}
