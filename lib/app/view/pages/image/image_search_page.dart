import 'package:cimat/app/view/controllers/image/image_search_addedit_controller.dart';
import 'package:cimat/app/view/pages/utils/app_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

import '../utils/app_icon.dart';
import 'image_card.dart';
import 'image_print_page.dart';

class ImageSearchPage extends StatefulWidget {
  final _imageSearchAddEditController =
      Get.find<ImageSearchAddEditController>();
  ImageSearchPage({super.key});

  @override
  State<ImageSearchPage> createState() => _ImageSearchPageState();
}

class _ImageSearchPageState extends State<ImageSearchPage> {
  final _formKey = GlobalKey<FormState>();
  final _keywordsTEC = TextEditingController();

  @override
  void initState() {
    _keywordsTEC.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar images'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => ImagePrintPage());
            },
            icon: const Icon(Icons.print),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Card(
              child: Row(
                children: [
                  Expanded(
                    child: AppTextFormField(
                      label: 'Informe palavra(s) chave',
                      controller: _keywordsTEC,
                      validator:
                          Validatorless.required('Descrição é obrigatório'),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        await widget._imageSearchAddEditController
                            .search(keywords: _keywordsTEC.text);
                      },
                      icon: const Icon(Icons.search))
                ],
              ),
            ),
            InkWell(
              onTap: () {
                widget._imageSearchAddEditController.nextPage();
              },
              child: Obx(() => Container(
                    color: widget._imageSearchAddEditController.lastPage
                        ? Colors.black
                        : Colors.green,
                    height: 24,
                    child: Center(
                      child: widget._imageSearchAddEditController.lastPage
                          ? const Text('Última página')
                          : const Text('Próxima página'),
                    ),
                  )),
            ),
            Expanded(
              child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Obx(
                    () => ListView.builder(
                      itemCount:
                          widget._imageSearchAddEditController.imageList.length,
                      itemBuilder: (context, index) {
                        final item = widget
                            ._imageSearchAddEditController.imageList[index];
                        return ImageCard(
                          imageModel: item,
                        );
                      },
                    ),
                  )),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Inserir nova imagem',
        child: const Icon(AppIconData.addInCloud),
        onPressed: () => widget._imageSearchAddEditController.addImage(),
      ),
    );
  }
}
