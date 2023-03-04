import 'package:cimat/app/core/models/user_profile_model.dart';
import 'package:cimat/app/data/b4a/entity/user_profile_entity.dart';
import 'package:cimat/app/data/repositories/user_profile_repository.dart';
import 'package:cimat/app/data/utils/pagination.dart';
import 'package:cimat/app/routes.dart';
import 'package:cimat/app/view/controllers/utils/loader_mixin.dart';
import 'package:cimat/app/view/controllers/utils/message_mixin.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class UserProfileSearchController extends GetxController
    with LoaderMixin, MessageMixin {
  final UserProfileRepository _profileRepository;
  UserProfileSearchController({
    required UserProfileRepository userProfileRepository,
  }) : _profileRepository = userProfileRepository;

  final _loading = false.obs;
  final _message = Rxn<MessageModel>();

  List<UserProfileModel> userProfileList = <UserProfileModel>[].obs;
  final _pagination = Pagination().obs;
  final _lastPage = false.obs;
  get lastPage => _lastPage.value;

  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject(UserProfileEntity.className));

  @override
  void onInit() {
    userProfileList.clear();
    _changePagination(1, 2);
    ever(_pagination, (_) async => await getMoreData());
    loaderListener(_loading);
    messageListener(_message);

    super.onInit();
  }

  void _changePagination(int page, int limit) {
    _pagination.update((val) {
      val!.page = page;
      val.limit = limit;
    });
  }

  void nextPage() {
    _changePagination(_pagination.value.page + 1, _pagination.value.limit);
  }

  Future<void> search({
    required bool nameContainsBool,
    required String nameContainsString,
    required bool nicknameContainsBool,
    required String nicknameContainsString,
    required bool cpfEqualToBool,
    required String cpfEqualToString,
    required bool registerEqualToBool,
    required String registerEqualToString,
    required bool phoneEqualToBool,
    required String phoneEqualToString,
  }) async {
    _loading(true);
    query = QueryBuilder<ParseObject>(ParseObject(UserProfileEntity.className));

    if (nameContainsBool) {
      query.whereContains('name', nameContainsString);
    }
    if (nicknameContainsBool) {
      query.whereContains('nickname', nicknameContainsString);
    }
    if (cpfEqualToBool) {
      query.whereEqualTo('cpf', cpfEqualToString);
    }
    if (registerEqualToBool) {
      query.whereEqualTo('register', cpfEqualToString);
    }
    if (phoneEqualToBool) {
      query.whereEqualTo('phone', phoneEqualToString);
    }
    query.orderByDescending('updatedAt');

    userProfileList.clear();
    // if (lastPage) {
    _lastPage(false);
    _pagination.update((val) {
      val!.page = 1;
      val.limit = 2;
    });
    // }
    // await getMoreData();

    // _changePagination(_pagination.value.page, _pagination.value.limit);
    _loading(false);
    Get.toNamed(Routes.userProfileSearchList);
  }

  Future<void> getMoreData() async {
    if (!lastPage) {
      _loading(true);
      List<UserProfileModel> temp = await _profileRepository.list(
        query,
        _pagination.value,
      );
      if (temp.isEmpty) {
        _lastPage(true);
      }
      userProfileList.addAll(temp);
      _loading(false);
    }
  }
}
