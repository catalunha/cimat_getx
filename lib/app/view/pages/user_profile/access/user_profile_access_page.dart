import 'package:cimat/app/view/controllers/user_profile/access/user_profile_access_controller.dart';
import 'package:cimat/app/view/pages/utils/app_photo_show.dart';
import 'package:cimat/app/view/pages/utils/app_text_title_value.dart';
import 'package:cimat/app/view/pages/utils/app_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileAccessPage extends StatefulWidget {
  UserProfileAccessPage({Key? key}) : super(key: key);
  final _userProfileAccessController = Get.find<UserProfileAccessController>();

  @override
  // _UserProfileAccessPageState createState() => _UserProfileAccessPageState();
  State<UserProfileAccessPage> createState() => _UserProfileAccessPageState();
}

class _UserProfileAccessPageState extends State<UserProfileAccessPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar este operador'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.cloud_upload),
        onPressed: () async {
          var result = await saveProfile();
          if (result) {
            Get.back();
          } else {
            Get.snackbar(
              'Atenção',
              'Campos obrigatórios não foram preenchidos.',
              backgroundColor: Colors.red,
            );
          }
        },
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Center(
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(
                    children: [
                      // Text(
                      //   'Id: ${widget._userProfileAccessController.userProfile!.id}',
                      // ),
                      const SizedBox(height: 5),

                      AppImageShow(
                        photoUrl: widget
                            ._userProfileAccessController.userProfile?.photo,
                      ),
                      AppTextTitleValue(
                        title: 'Email: ',
                        value: widget
                            ._userProfileAccessController.userProfile?.email,
                        inColumn: true,
                      ),
                      AppTextTitleValue(
                        inColumn: true,
                        title: 'Nome completo: ',
                        value:
                            '${widget._userProfileAccessController.userProfile?.name}',
                      ),
                      AppTextTitleValue(
                        inColumn: true,
                        title: 'Nome em tropa: ',
                        value:
                            '${widget._userProfileAccessController.userProfile?.nickname}',
                      ),
                      AppTextTitleValue(
                        title: 'Telefone: ',
                        value:
                            '${widget._userProfileAccessController.userProfile?.phone}',
                      ),
                      // AppTextTitleValue(
                      //   title: 'CPF: ',
                      //   value:
                      //       '${widget._userProfileAccessController.userProfile?.cpf}',
                      // ),
                      AppTextTitleValue(
                        title: 'Registro: ',
                        value:
                            '${widget._userProfileAccessController.userProfile?.register}',
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      CheckboxListTile(
                        title: const Text("* Liberar acesso ?"),
                        value: widget._userProfileAccessController.isActive,
                        onChanged: (value) {
                          setState(() {
                            widget._userProfileAccessController.isActive =
                                value!;
                          });
                        },
                      ),
                      const Text(
                          'Marque as opções de acesso para este usuário.'),
                      Wrap(
                        children: [
                          SizedBox(
                            width: 120,
                            child: Card(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Row(
                                  children: [
                                    const Text('Admin'),
                                    Checkbox(
                                        tristate: true,
                                        value: widget
                                            ._userProfileAccessController
                                            .routesMap['admin'],
                                        onChanged: (value) => widget
                                                ._userProfileAccessController
                                                .routesMap['admin'] =
                                            value ?? false),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 140,
                            child: Card(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Row(
                                  children: [
                                    const Text('Patrimônio'),
                                    Checkbox(
                                        value: widget
                                            ._userProfileAccessController
                                            .routesMap['patrimonio'],
                                        onChanged: (value) => widget
                                                ._userProfileAccessController
                                                .routesMap['patrimonio'] =
                                            value ?? false),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 120,
                            child: Card(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Row(
                                  children: [
                                    const Text('Reserva'),
                                    Checkbox(
                                        value: widget
                                            ._userProfileAccessController
                                            .routesMap['reserva'],
                                        onChanged: (value) => widget
                                                ._userProfileAccessController
                                                .routesMap['reserva'] =
                                            value ?? false),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 130,
                            child: Card(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Row(
                                  children: [
                                    const Text('Operador'),
                                    Checkbox(
                                        value: widget
                                            ._userProfileAccessController
                                            .routesMap['operador'],
                                        onChanged: (value) => widget
                                                ._userProfileAccessController
                                                .routesMap['operador'] =
                                            value ?? false),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const Text('Informe restrições aos grupos:.'),
                      AppTextFormField(
                        label: 'separados por espaço',
                        controller:
                            widget._userProfileAccessController.restrictionsTec,
                        // maxLines: 3,
                      ),

                      const SizedBox(height: 70),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> saveProfile() async {
    final formValid = _formKey.currentState?.validate() ?? false;
    if (formValid) {
      await widget._userProfileAccessController.updateAccess(
        isActive: widget._userProfileAccessController.isActive,
        restrictions: widget._userProfileAccessController.restrictionsTec.text,
      );
      return true;
    }
    return false;
  }
}
