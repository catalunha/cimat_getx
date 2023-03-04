import 'package:cimat/app/core/models/user_profile_model.dart';
import 'package:cimat/app/routes.dart';
import 'package:cimat/app/view/pages/utils/app_text_title_value.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileCard extends StatelessWidget {
  final UserProfileModel profile;
  const UserProfileCard({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              profile.photo != null && profile.photo!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        profile.photo!,
                        height: 58,
                        width: 58,
                      ),
                    )
                  : const SizedBox(
                      height: 58,
                      width: 58,
                      child: Icon(Icons.person_outline),
                    ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // AppTextTitleValue(
                    //   title: 'Id: ',
                    //   value: profile.id,
                    // ),
                    AppTextTitleValue(
                      title: 'Email: ',
                      value: profile.email,
                    ),
                    // AppTextTitleValue(
                    //   title: 'Nome: ',
                    //   value: '${profile.name}',
                    // ),
                    AppTextTitleValue(
                      title: 'Nome em tropa: ',
                      value: '${profile.nickname}',
                    ),
                    // AppTextTitleValue(
                    //   title: 'Telefone: ',
                    //   value: '${profile.phone}',
                    // ),
                    // AppTextTitleValue(
                    //   title: 'Registro: ',
                    //   value: '${profile.register}',
                    // ),
                    Wrap(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.toNamed(Routes.userProfileAccess,
                                arguments: profile);
                          },
                          icon: const Icon(
                            Icons.edit,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.toNamed(
                              Routes.userProfileView,
                              arguments: profile,
                            );
                          },
                          icon: const Icon(
                            Icons.assignment_ind_outlined,
                          ),
                        ),
                        // IconButton(
                        //   onPressed: () => copy(profile.id),
                        //   icon: const Icon(
                        //     Icons.copy,
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // copy(String text) async {
  //   Get.snackbar(text, 'Id copiado.',
  //       margin: const EdgeInsets.all(10), duration: const Duration(seconds: 1));
  //   await Clipboard.setData(ClipboardData(text: text));
  // }
}
