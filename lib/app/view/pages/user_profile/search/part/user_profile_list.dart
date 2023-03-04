import 'package:cimat/app/core/models/user_profile_model.dart';
import 'package:cimat/app/view/pages/user_profile/search/part/user_profile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileList extends StatelessWidget {
  final List<UserProfileModel> userProfileList;
  const UserProfileList({
    super.key,
    required this.userProfileList,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: userProfileList.length,
        itemBuilder: (context, index) {
          final person = userProfileList[index];
          return UserProfileCard(
            profile: person,
          );
        },
      ),
    );
  }
}
