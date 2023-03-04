import 'package:cimat/app/view/controllers/user_profile/search/user_profile_search_controller.dart';
import 'package:cimat/app/view/pages/utils/app_icon.dart';
import 'package:cimat/app/view/pages/utils/app_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileSearchPage extends StatefulWidget {
  final _userProfileSearchController = Get.find<UserProfileSearchController>();
  UserProfileSearchPage({Key? key}) : super(key: key);

  @override
  State<UserProfileSearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<UserProfileSearchPage> {
  final _formKey = GlobalKey<FormState>();
  bool _nicknameContains = false;
  bool _nameContains = false;
  bool _cpfEqualTo = false;
  bool _registerEqualTo = false;
  bool _phoneEqualTo = false;
  final _nicknameContainsTEC = TextEditingController();
  final _nameContainsTEC = TextEditingController();
  final _cpfEqualToTEC = TextEditingController();
  final _registerEqualToTEC = TextEditingController();
  final _phoneEqualToTEC = TextEditingController();

  @override
  void initState() {
    _nicknameContainsTEC.text = '';
    _nameContainsTEC.text = '';
    _cpfEqualToTEC.text = '';
    _registerEqualToTEC.text = '';
    _phoneEqualToTEC.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscando usuário'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Card(
                    child: Column(
                      children: [
                        const Text('por Nome em tropa'),
                        Row(
                          children: [
                            Checkbox(
                              value: _nicknameContains,
                              onChanged: (value) {
                                setState(() {
                                  _nicknameContains = value!;
                                });
                                Get.back();
                              },
                            ),
                            Expanded(
                              child: AppTextFormField(
                                label: 'que contém',
                                controller: _nicknameContainsTEC,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        const Text('por Nome'),
                        Row(
                          children: [
                            Checkbox(
                              value: _nameContains,
                              onChanged: (value) {
                                setState(() {
                                  _nameContains = value!;
                                });
                              },
                            ),
                            Expanded(
                              child: AppTextFormField(
                                label: 'que contém',
                                controller: _nameContainsTEC,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        const Text('por CPF'),
                        Row(
                          children: [
                            Checkbox(
                              value: _cpfEqualTo,
                              onChanged: (value) {
                                setState(() {
                                  _cpfEqualTo = value!;
                                });
                              },
                            ),
                            Expanded(
                              child: AppTextFormField(
                                label: 'igual a',
                                controller: _cpfEqualToTEC,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        const Text('por registro'),
                        Row(
                          children: [
                            Checkbox(
                              value: _registerEqualTo,
                              onChanged: (value) {
                                setState(() {
                                  _registerEqualTo = value!;
                                });
                              },
                            ),
                            Expanded(
                              child: AppTextFormField(
                                label: 'igual a',
                                controller: _registerEqualToTEC,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        const Text('por Telefone'),
                        Row(
                          children: [
                            Checkbox(
                              value: _phoneEqualTo,
                              onChanged: (value) {
                                setState(() {
                                  _phoneEqualTo = value!;
                                });
                              },
                            ),
                            Expanded(
                              child: AppTextFormField(
                                label: 'igual a',
                                controller: _phoneEqualToTEC,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 70)
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Executar busca',
        child: const Icon(AppIconData.search),
        onPressed: () async {
          final formValid = _formKey.currentState?.validate() ?? false;
          if (formValid) {
            await widget._userProfileSearchController.search(
              nameContainsBool: _nameContains,
              nameContainsString: _nameContainsTEC.text,
              nicknameContainsBool: _nicknameContains,
              nicknameContainsString: _nicknameContainsTEC.text,
              cpfEqualToBool: _cpfEqualTo,
              cpfEqualToString: _cpfEqualToTEC.text,
              registerEqualToBool: _registerEqualTo,
              registerEqualToString: _registerEqualToTEC.text,
              phoneEqualToBool: _phoneEqualTo,
              phoneEqualToString: _phoneEqualToTEC.text,
            );
            // Get.back();
          }
        },
      ),
    );
  }
}
