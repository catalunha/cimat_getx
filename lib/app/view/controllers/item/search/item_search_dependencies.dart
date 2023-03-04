import 'package:cimat/app/data/b4a/table/item/item_repository_b4a.dart';
import 'package:cimat/app/data/repositories/item_repository.dart';
import 'package:cimat/app/view/controllers/item/search/item_search_controller.dart';
import 'package:get/get.dart';

class ItemSearchDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ItemRepository>(
      () => ItemRepositoryB4a(),
    );

    Get.put<ItemSearchController>(
      ItemSearchController(
        itemRepository: Get.find(),
      ),
    );
  }
}
