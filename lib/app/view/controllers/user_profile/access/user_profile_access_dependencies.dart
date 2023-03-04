import 'package:cimat/app/data/b4a/table/user_profile/user_profile_repository_b4a.dart';
import 'package:cimat/app/data/repositories/user_profile_repository.dart';
import 'package:cimat/app/view/controllers/user_profile/access/user_profile_access_controller.dart';
import 'package:get/get.dart';

class UserProfileAccessDependencies implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProfileRepository>(
      () => UserProfileRepositoryB4a(),
    );

    Get.put<UserProfileAccessController>(
      UserProfileAccessController(
        userProfileRepository: Get.find(),
      ),
    );
  }
}
