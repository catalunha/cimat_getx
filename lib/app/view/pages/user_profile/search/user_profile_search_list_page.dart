import 'package:cimat/app/view/controllers/user_profile/search/user_profile_search_controller.dart';
import 'package:cimat/app/view/pages/user_profile/search/part/user_profile_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../print/user_profile_print_page.dart';

class UserProfileSearchListPage extends StatelessWidget {
  final _userProfileSearchController = Get.find<UserProfileSearchController>();

  UserProfileSearchListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
              'Usuarios: ${_userProfileSearchController.userProfileList.length}'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => UserProfilePrintPage());
            },
            icon: const Icon(Icons.print),
          )
        ],
      ),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              _userProfileSearchController.nextPage();
            },
            child: Obx(() => Container(
                  color: _userProfileSearchController.lastPage
                      ? Colors.black
                      : Colors.green,
                  height: 24,
                  child: Center(
                    child: _userProfileSearchController.lastPage
                        ? const Text('Última página')
                        : const Text('Próxima página'),
                  ),
                )),
          ),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: UserProfileList(
                userProfileList: _userProfileSearchController.userProfileList,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
