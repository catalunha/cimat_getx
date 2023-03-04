import 'package:cimat/app/core/models/user_profile_model.dart';
import 'package:cimat/app/data/b4a/table/user_profile/user_profile_repository_exception.dart';
import 'package:cimat/app/data/repositories/user_profile_repository.dart';
import 'package:cimat/app/view/controllers/user_profile/search/user_profile_search_controller.dart';
import 'package:cimat/app/view/controllers/utils/loader_mixin.dart';
import 'package:cimat/app/view/controllers/utils/message_mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UserProfileAccessController extends GetxController
    with LoaderMixin, MessageMixin {
  final UserProfileRepository _userProfileRepository;
  UserProfileAccessController({
    required UserProfileRepository userProfileRepository,
  }) : _userProfileRepository = userProfileRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  final _userProfile = Rxn<UserProfileModel>();
  UserProfileModel? get userProfile => _userProfile.value;
  set userProfile(UserProfileModel? profileModelNew) =>
      _userProfile(profileModelNew);

  String? clientId;

//+++ forms
  final restrictionsTec = TextEditingController();
  bool isActive = true;
//--- forms
  RxMap<String, bool> routesMap = RxMap<String, bool>({
    'admin': false,
    'patrimonio': false,
    'reserva': false,
    'operador': false
  });

  @override
  void onReady() {
    userProfile = Get.arguments;
    // getProfile();
    setFormFieldControllers();

    super.onReady();
  }

  @override
  void onInit() async {
    loaderListener(_loading);
    messageListener(_message);

    super.onInit();
  }

  // Future<void> getProfile() async {
  //   _loading(true);
  //   log('+++> getProfile $clientId', name: 'getProfile');
  //   UserProfileModel? userProfileModelTemp =
  //       await _userProfileRepository.readById(clientId!);
  //   userProfile = userProfileModelTemp;
  //   setFormFieldControllers();
  //   _loading(false);
  // }

  setFormFieldControllers() {
    userProfile?.routes?.forEach((e) {
      routesMap[e] = true;
    });
    restrictionsTec.text = userProfile?.restrictions?.join(' ') ?? "";
    isActive = userProfile?.isActive ?? false;
  }

  Future<void> updateAccess({
    bool? isActive,
    String? restrictions,
  }) async {
    try {
      _loading(true);
      var routes = routesMap.entries.map((e) {
        if (e.value == true) {
          return e.key;
        }
      }).toList();
      routes.removeWhere((element) => element == null);
      userProfile = userProfile!.copyWith(
        isActive: isActive,
        routes: routes.cast(),
        restrictions: restrictions != null ? restrictions.split(' ') : [],
      );

      await _userProfileRepository.update(userProfile!);

      bool userProfileSearchController =
          Get.isRegistered<UserProfileSearchController>();
      if (userProfileSearchController) {
        var userProfileSearchController =
            Get.find<UserProfileSearchController>();
        userProfileSearchController.userProfileList;
        int index = userProfileSearchController.userProfileList
            .indexWhere((model) => model.id == userProfile!.id);
        userProfileSearchController.userProfileList
            .replaceRange(index, index + 1, [userProfile!]);
      }
    } on UserProfileRepositoryException {
      _message.value = MessageModel(
        title: 'Erro em ProfileController',
        message: 'Não foi possivel salvar o perfil',
        isError: true,
      );
    } finally {
      _loading(false);
    }
  }
}
