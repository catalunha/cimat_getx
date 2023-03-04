import 'package:cimat/app/data/b4a/table/image/image_repository_b4a.dart';
import 'package:cimat/app/data/repositories/image_repository.dart';
import 'package:get/get.dart';

import 'image_search_addedit_controller.dart';

class ImageSearchAddEditDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImageRepository>(
      () => ImageRepositoryB4a(),
    );
    Get.put<ImageSearchAddEditController>(
      ImageSearchAddEditController(
        imageRepository: Get.find<ImageRepository>(),
      ),
    );
  }
}
