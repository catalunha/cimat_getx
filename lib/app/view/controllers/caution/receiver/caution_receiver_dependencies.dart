import 'package:cimat/app/data/b4a/table/caution/caution_repository_b4a.dart';
import 'package:cimat/app/data/repositories/caution_repository.dart';
import 'package:cimat/app/view/controllers/caution/receiver/caution_receiver_controller.dart';
import 'package:get/get.dart';

class CautionReceiverDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CautionRepository>(
      () => CautionRepositoryB4a(),
    );
    Get.put<CautionReceiverController>(
      CautionReceiverController(
        cautionRepository: Get.find(),
      ),
    );
  }
}
