import 'package:cimat/app/view/controllers/image/image_search_addedit_controller.dart';
import 'package:cimat/app/view/pages/utils/app_import_image.dart';
import 'package:cimat/app/view/pages/utils/app_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

class ImageAddEditPage extends StatefulWidget {
  ImageAddEditPage({Key? key}) : super(key: key);
  final _imageSearchAddEditController =
      Get.find<ImageSearchAddEditController>();

  @override
  State<ImageAddEditPage> createState() => _ImageAddEditPageState();
}

class _ImageAddEditPageState extends State<ImageAddEditPage> {
  final _formKey = GlobalKey<FormState>();
  final keywordsTEC = TextEditingController();
  @override
  void initState() {
    super.initState();
    keywordsTEC.text =
        widget._imageSearchAddEditController.image?.keywords?.join(' ') ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar/Editar esta imagem'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.cloud_upload),
        onPressed: () async {
          var result = await saveImage();
          if (result) {
            Get.back(closeOverlays: true);
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
                      const SizedBox(height: 5),
                      AppTextFormField(
                        label: 'Palavra(s) chave. Separados por espaço.',
                        controller: keywordsTEC,
                        validator: Validatorless.required(
                            'Palavra(s) chave é obrigatório'),
                      ),
                      const SizedBox(height: 50),
                      AppImportImage(
                        label: 'Click aqui para buscar uma imagem.',
                        imageUrl:
                            widget._imageSearchAddEditController.image?.url,
                        setXFile: (value) =>
                            widget._imageSearchAddEditController.xfile = value,
                        maxHeightImage: 150,
                        maxWidthImage: 150,
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

  Future<bool> saveImage() async {
    var formValid = _formKey.currentState?.validate() ?? false;
    if (widget._imageSearchAddEditController.xfile == null &&
        widget._imageSearchAddEditController.image?.url == null) {
      formValid = false;
    }
    if (formValid) {
      await widget._imageSearchAddEditController.addedit(
        keywords: keywordsTEC.text,
      );
      return true;
    }
    return false;
  }
}
