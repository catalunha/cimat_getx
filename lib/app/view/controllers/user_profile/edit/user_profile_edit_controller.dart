import 'package:cimat/app/core/models/user_profile_model.dart';
import 'package:cimat/app/data/b4a/entity/user_profile_entity.dart';
import 'package:cimat/app/data/b4a/table/user_profile/user_profile_repository_exception.dart';
import 'package:cimat/app/data/b4a/utils/xfile_to_parsefile.dart';
import 'package:cimat/app/data/repositories/user_profile_repository.dart';
import 'package:cimat/app/view/controllers/splash/splash_controller.dart';
import 'package:cimat/app/view/controllers/utils/loader_mixin.dart';
import 'package:cimat/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileEditController extends GetxController
    with LoaderMixin, MessageMixin {
  final UserProfileRepository _userProfileRepository;
  UserProfileEditController({
    required UserProfileRepository userProfileRepository,
  }) : _userProfileRepository = userProfileRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final _userProfile = Rxn<UserProfileModel>();
  UserProfileModel? get userProfile => _userProfile.value;
  set userProfile(UserProfileModel? profileModelNew) =>
      _userProfile(profileModelNew);

  XFile? _xfile;
  set xfile(XFile? xfile) {
    _xfile = xfile;
  }

  @override
  void onInit() {
    loaderListener(_loading);
    messageListener(_message);
    final SplashController splashController = Get.find();
    userProfile = splashController.userModel!.userProfile;
    // UserProfileModel model = Get.arguments;
    // setProfile(model);
    super.onInit();
  }

  // setProfile(UserProfileModel model) {
  //   _profile(model);
  // }

  Future<void> append({
    String? nickname,
    String? phone,
    String? name,
    String? cpf,
    String? register,
  }) async {
    try {
      _loading(true);
      userProfile = userProfile!.copyWith(
        nickname: nickname,
        phone: phone,
        name: name,
        cpf: cpf,
        register: register,
      );

      String userProfileId = await _userProfileRepository.update(userProfile!);
      if (_xfile != null) {
        String? photoUrl = await XFileToParseFile.xFileToParseFile(
          xfile: _xfile!,
          className: UserProfileEntity.className,
          objectId: userProfileId,
          objectAttribute: 'photo',
        );
        userProfile = userProfile!.copyWith(photo: photoUrl);
      }
      final SplashController splashController = Get.find();
      await splashController.updateUserProfile();
    } on UserProfileRepositoryException {
      _message.value = MessageModel(
        title: 'Erro em UserProfileEditController',
        message: 'Não foi possivel salvar o perfil',
        isError: true,
      );
    } finally {
      _loading(false);
    }
  }
}
