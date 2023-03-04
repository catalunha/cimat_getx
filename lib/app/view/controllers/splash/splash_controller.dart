import 'package:cimat/app/core/models/user_model.dart';
import 'package:cimat/app/core/models/user_profile_model.dart';
import 'package:cimat/app/core/utils/app_error_code.dart';
import 'package:cimat/app/data/b4a/table/user_profile/user_profile_repository_b4a.dart';
import 'package:cimat/app/data/init_back4app.dart';
import 'package:cimat/app/data/repositories/user_repository.dart';
import 'package:cimat/app/routes.dart';
import 'package:cimat/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class SplashController extends GetxController with MessageMixin {
  final UserRepository _userRepository;
  SplashController({required UserRepository userRepository})
      : _userRepository = userRepository;

  final Rxn<ParseUser> _parseUser = Rxn<ParseUser>();
  ParseUser? get parseUser => _parseUser.value;
  set parseUser(ParseUser? parseUserNew) {
    _parseUser(parseUserNew);
  }

  final _userModel = Rxn<UserModel>();
  UserModel? get userModel => _userModel.value;
  set userModel(UserModel? userModelNew) {
    _userModel(userModelNew);
  }

  final officeIdList = <String>[];
  final _message = Rxn<MessageModel>();

  @override
  void onInit() async {
    messageListener(_message);

    super.onInit();
    await startApp();
  }

  Future<void> startApp() async {
    await Future.delayed(const Duration(seconds: 1), () {});

    InitBack4app initBack4app = InitBack4app();
    bool initParse = await initBack4app.init();
    if (initParse) {
      final isLogged = await _hasUserLogged();
      if (isLogged) {
        if (userModel!.userProfile!.isActive == true) {
          Get.offAllNamed(Routes.home);
        } else {
          Get.offAllNamed(Routes.userLogin);
          var appErrorCode = AppErrorCode(0);
          _message.value = MessageModel(
            title: appErrorCode.code,
            message: appErrorCode.message,
            isError: true,
          );
        }
      } else {
        Get.offAllNamed(Routes.userLogin);
      }
    } else {
      var appErrorCode = AppErrorCode(0);

      _message.value = MessageModel(
        title: appErrorCode.code,
        message: appErrorCode.message,
        isError: true,
      );
    }
  }

  Future<bool> _hasUserLogged() async {
    parseUser = await ParseUser.currentUser() as ParseUser?;
    if (parseUser == null) {
      return false;
    }
    //Checks whether the user's session token is valid
    final ParseResponse? parseResponse =
        await ParseUser.getCurrentUserFromServer(parseUser!.sessionToken!);

    if (parseResponse?.success == null || !parseResponse!.success) {
      //Invalid session. Logout
      await parseUser!.logout();
      return false;
    } else {
      var profileModel = await updateUserProfile();
      // var profileField = parseUser!.get('profile');
      // var profileRepositoryB4a = ProfileRepositoryB4a();

      // var profileModel =
      //     await profileRepositoryB4a.readById(profileField.objectId);
      // officeIdList.clear();
      // if (profileModel!.office != null && profileModel.office!.isNotEmpty) {
      //   officeIdList.addAll(profileModel.office!.map((e) => e.id!).toList());
      // }
      userModel = UserModel(
        id: parseUser!.objectId!,
        email: parseUser!.emailAddress!,
        userProfile: profileModel,
      );
      return true;
    }
  }

  Future<UserProfileModel?> updateUserProfile() async {
    var profileField = parseUser!.get('userProfile');
    var profileRepositoryB4a = UserProfileRepositoryB4a();
    var profileModel =
        await profileRepositoryB4a.readById(profileField.objectId);
    officeIdList.clear();

    _userModel.update((val) {
      val?.userProfile = profileModel;
    });
    return profileModel;
  }

  Future<void> logout() async {
    await _userRepository.logout();
    Get.offAllNamed(Routes.userLogin);
  }
}
