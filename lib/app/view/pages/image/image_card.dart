import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/models/image_model.dart';
import '../../controllers/image/image_search_addedit_controller.dart';
import '../utils/app_photo_show.dart';

class ImageCard extends StatelessWidget {
  final _imageSearchAddEditController =
      Get.find<ImageSearchAddEditController>();
  final ImageModel imageModel;
  ImageCard({Key? key, required this.imageModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          AppImageShow(
            photoUrl: imageModel.url,
            width: 300,
            height: 100,
          ),
          // AppTextTitleValue(
          //   title: 'Id: ',
          //   value: imageModel.id,
          // ),
          Text(
            '${imageModel.keywords?.join(' ')}',
            style: const TextStyle(fontSize: 22),
          ),
          Wrap(
            children: [
              IconButton(
                onPressed: () =>
                    _imageSearchAddEditController.updateImage(imageModel),
                icon: const Icon(
                  Icons.edit,
                ),
              ),
              IconButton(
                onPressed: () => Get.back(result: imageModel),
                icon: const Icon(
                  Icons.check,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
