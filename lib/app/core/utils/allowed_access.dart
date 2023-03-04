import 'package:cimat/app/view/controllers/splash/splash_controller.dart';
import 'package:get/get.dart';

class AllowedAccess {
  static bool consultFor(List<String> officeIdListAutorized) {
    final splashController = Get.find<SplashController>();
    return splashController.userModel!.userProfile!.routes!
        .any((element) => officeIdListAutorized.contains(element));
  }
}
